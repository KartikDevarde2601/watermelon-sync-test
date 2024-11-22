/*
  Warnings:

  - You are about to drop the `Token` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Token" DROP CONSTRAINT "Token_userId_fkey";

-- DropTable
DROP TABLE "Token";

-- DropTable
DROP TABLE "User";

-- DropEnum
DROP TYPE "Role";

-- DropEnum
DROP TYPE "TokenType";

-- CreateTable
CREATE TABLE "Patient" (
    "pid" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "contactInformation" TEXT NOT NULL,
    "BirthDay" TIMESTAMP(3) NOT NULL,
    "gender" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Patient_pkey" PRIMARY KEY ("pid")
);

-- CreateTable
CREATE TABLE "Visit" (
    "vid" TEXT NOT NULL,
    "pid" TEXT NOT NULL,
    "isClinicalCollected" BOOLEAN,
    "isDataCollected" BOOLEAN,
    "visitNotes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Visit_pkey" PRIMARY KEY ("vid")
);

-- CreateTable
CREATE TABLE "Clinic" (
    "cid" TEXT NOT NULL,
    "vid" TEXT NOT NULL,
    "bloodGroup" TEXT NOT NULL,
    "antigenStatus" TEXT NOT NULL,
    "systolic" INTEGER NOT NULL,
    "diastolic" INTEGER NOT NULL,
    "temperature" INTEGER NOT NULL,
    "smokingType" TEXT NOT NULL,
    "overAllYearOfSmoking" INTEGER NOT NULL,
    "dailyConsumption" INTEGER NOT NULL,
    "smokingIndex" INTEGER NOT NULL,
    "alcoholFreeDays" INTEGER NOT NULL,
    "alcoholType" INTEGER NOT NULL,
    "alcoholConsumption" INTEGER NOT NULL,
    "homoglobin" INTEGER NOT NULL,
    "recentHealthIssue" TEXT NOT NULL,
    "hereditaryHistory" TEXT NOT NULL,
    "height" INTEGER NOT NULL,
    "weight" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Clinic_pkey" PRIMARY KEY ("cid")
);

-- CreateIndex
CREATE UNIQUE INDEX "Clinic_vid_key" ON "Clinic"("vid");

-- AddForeignKey
ALTER TABLE "Visit" ADD CONSTRAINT "Visit_pid_fkey" FOREIGN KEY ("pid") REFERENCES "Patient"("pid") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clinic" ADD CONSTRAINT "Clinic_vid_fkey" FOREIGN KEY ("vid") REFERENCES "Visit"("vid") ON DELETE RESTRICT ON UPDATE CASCADE;
