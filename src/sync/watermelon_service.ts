import { PrismaClient } from '@prisma/client';
import { TableSchema, SyncableRecord, Changes, SyncableRecord_sanitizeRecord } from './types';

export class watermelonSync {
  private prisma: PrismaClient;
  private tables: TableSchema[];

  constructor(prisma: PrismaClient, tables: TableSchema[]) {
    this.prisma = prisma;
    this.tables = tables;
  }

  

  async syncPush(clientChange: Changes): Promise<void> {
    try {
      const serverChanges = await this.prisma.$transaction(async (tx) => {
        await this.pushChanges(clientChange, tx);
        // Return something useful if needed (for example, a summary of changes made)
        return { success: true };
      });
  
      console.log('Server changes:', serverChanges); // Log or use serverChanges if necessary
    } catch (error) {
      console.error('Error syncing changes:', error); // Log the error for debugging
    }
  }

    private async pushChanges(clientChange: Changes, tx: any): Promise<void> {
      const operations: Promise<any>[] = [];
  
      for (const [tableName, tableChanges] of Object.entries(clientChange)) {
        const tableSchema = this.tables.find((table) => table.name === tableName);
        let model: any;
        if (tableSchema) {
          model = tx[tableSchema.name.trim().slice(0, -1)]
        } else {
          console.error(`Table schema not found for table name: ${tableName}`);
          continue;
        }
  
      // Handle created records
    if (Array.isArray(tableChanges.created)) {
      operations.push(
        ...tableChanges.created.map((record) =>
          model.create({
            data: record,
          })
        )
      );
    } else {
      console.error(`Created records not found for table name: ${tableName}`);
    }
    
        
      }
  
      //   // Handle updated records
      //   operations.push(
      //     ...tableChanges.updated.map(async (record) => {
      //       try {
      //         const existing = await model.findUnique({
      //           where: { id: record.id }
      //         });
  
      //         if (!existing) {
      //           console.error(`Record with id ${record.id} not found in table ${tableName}`);
      //           return;
      //         }
  
      //         return model.update({
      //           where: { id: record.id },
      //           data: {
      //             ...record
      //           }
      //         });
      //       } catch (error) {
      //         console.error(`Error updating record in table ${tableName}:`, error);
      //       }
      //     })
      //   );
  
      //   // Handle deleted records
      //   operations.push(
      //     ...tableChanges.deleted.map((id) =>
      //       model.update({
      //         where: { id },
      //         data: {
      //           deleted_at: new Date(),
      //           updated_at: new Date()
      //         }
      //       }).catch((error:Error) => {
      //         console.error(`Error deleting record in table ${tableName}:`, error);
      //       })
      //     )
      //   );
      // }
  
      // Execute all operations concurrently within the transaction
      try {
        await Promise.all(operations);
        console.log('All operations executed successfully.');
      } catch (error) {
        console.error('Error executing operations:', error);
      }
    }

  private sanitizeRecord(record: SyncableRecord): SyncableRecord_sanitizeRecord {
    const {
      server_created_at,
      server_updated_at,
      server_deleted_at,
      _status,
      _changed,
      ...sanitizedRecord
    } = record;

    return sanitizedRecord;
  }

  async pullChanges(lastPulledAt: number): Promise<Changes> {
    const changes: Changes = {};

    const lastPulledAt_UTC = new Date(lastPulledAt * 1000).toISOString();
    console.log('lastPulledAt_UTC', lastPulledAt_UTC);

    for (const { name: tableName, model } of this.tables) {
      console.log('tableName', tableName);
      console.log('model', model);
      const changes: Changes = {
        [tableName]: {
          created: [],
          updated: [],
          deleted: []
        }
      };

      const records = await model.findMany({
        where: {
          server_updatedAt: {
            gt: new Date(lastPulledAt_UTC)
          },
          OR: [{ server_deletedAt: null }, { server_deletedAt: { gt: new Date(lastPulledAt_UTC) } }]
        },
        orderBy: {
          server_updatedAt: 'asc'
        }
      });

      console.log('records', records);

      // Process each record
      for (const record of records) {
        // Deletion logic:
        // - If record is deleted, add to deleted list
        if (record.server_deleted_at) {
          changes[tableName].deleted.push(record.id);
          continue;
        }

        // Creation logic:
        // - If record created after last pull, mark as created
        if (record.server_created_at > lastPulledAt_UTC) {
          const sanitizedRecord = this.sanitizeRecord(record);
          changes[tableName].created.push(sanitizedRecord);
          continue;
        }

        // Creation logic:
        // - If record updated after last pull, mark as created
        if (record.server_updated_at > lastPulledAt_UTC) {
          const sanitizedRecord = this.sanitizeRecord(record);
          changes[tableName].updated.push(sanitizedRecord);
          continue;
        }
      }
    }
    return changes;
  }
}
