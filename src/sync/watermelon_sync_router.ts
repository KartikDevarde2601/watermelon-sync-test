import express from 'express';
import { pull_changes, push_changes } from './watermelon_sync_controller';

const router = express.Router();

router.get('/push', push_changes);
router.post('/pull', pull_changes);

export default router;