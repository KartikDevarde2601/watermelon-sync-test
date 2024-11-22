/*
  Warnings:

  - You are about to drop the column `createdAt` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `Visit` table. All the data in the column will be lost.
  - Added the required column `server_updatedAt` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `server_updatedAt` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `server_updatedAt` to the `Visit` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Clinic" DROP COLUMN "createdAt",
ADD COLUMN     "server_createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "server_deletedAt" TIMESTAMP(3),
ADD COLUMN     "server_updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Patient" DROP COLUMN "createdAt",
ADD COLUMN     "server_createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "server_deletedAt" TIMESTAMP(3),
ADD COLUMN     "server_updatedAt" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Visit" DROP COLUMN "createdAt",
ADD COLUMN     "server_createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "server_deletedAt" TIMESTAMP(3),
ADD COLUMN     "server_updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE INDEX "Clinic_server_updatedAt_idx" ON "Clinic"("server_updatedAt");

-- CreateIndex
CREATE INDEX "Clinic_server_deletedAt_idx" ON "Clinic"("server_deletedAt");

-- CreateIndex
CREATE INDEX "Patient_server_updatedAt_idx" ON "Patient"("server_updatedAt");

-- CreateIndex
CREATE INDEX "Patient_server_deletedAt_idx" ON "Patient"("server_deletedAt");

-- CreateIndex
CREATE INDEX "Visit_server_updatedAt_idx" ON "Visit"("server_updatedAt");

-- CreateIndex
CREATE INDEX "Visit_server_deletedAt_idx" ON "Visit"("server_deletedAt");
