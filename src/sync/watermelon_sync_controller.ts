import express from 'express';
import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';
import { watermelonSync } from './watermelon_service';

const prisma = new PrismaClient();

const syncService = new watermelonSync(prisma, [
  { name: 'patients', model: prisma.patient },
  { name: 'clinics', model: prisma.clinic },
  { name: 'visits', model: prisma.visit }
]);

const push_changes = async (req: Request, res: Response) => {
  const { last_pulled_at } = req.query;

  console.log('last_pulled_at', last_pulled_at);

  try {
    const result = await syncService.pullChanges(Number(last_pulled_at));
    const response = {
      last_pulled_at: new Date().toISOString(),
      changes: result
    };
    res.json(response);
  } catch (error) {
    res.status(500).json({ error: 'Sync failed' });
  }
};

const pull_changes = async (req: Request, res: Response) => {
  const changes = req.body;
  try {
    await syncService.syncPush(changes);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ error: 'Sync failed' });
  }
};

export { push_changes, pull_changes };
