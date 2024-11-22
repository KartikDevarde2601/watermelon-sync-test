import express from 'express';
import syncRouter from './watermelon_sync_router';

const router = express.Router();

router.use('/sync', syncRouter);

export default router;


