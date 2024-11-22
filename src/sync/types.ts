interface SyncableRecord {
  id: string;
  server_created_at: Date;
  server_updated_at: Date;
  server_deleted_at?: Date | null;
  _status?: string;
  _changed?: string;
  [key: string]: any;
}

interface SyncableRecord_sanitizeRecord {
  id: string;
  [key: string]: any;
}

interface TableSchema {
  name: string;
  model: any;
}

interface SyncChanges {
  created: Record<string, SyncableRecord>[];
  updated: Record<string, SyncableRecord>[];
  deleted: string[];
}

interface Changes {
  [tableName: string]: SyncChanges;
}

export { SyncableRecord, TableSchema, SyncChanges, Changes, SyncableRecord_sanitizeRecord };
