/*
  Warnings:

  - You are about to drop the column `alcoholConsumption` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `alcoholFreeDays` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `alcoholType` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `antigenStatus` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `bloodGroup` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `dailyConsumption` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `hereditaryHistory` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `overAllYearOfSmoking` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `recentHealthIssue` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `smokingIndex` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `smokingType` on the `Clinic` table. All the data in the column will be lost.
  - You are about to drop the column `BirthDay` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `contactInformation` on the `Patient` table. All the data in the column will be lost.
  - You are about to drop the column `isClinicalCollected` on the `Visit` table. All the data in the column will be lost.
  - You are about to drop the column `isDataCollected` on the `Visit` table. All the data in the column will be lost.
  - You are about to drop the column `visitNotes` on the `Visit` table. All the data in the column will be lost.
  - Added the required column `alcohol_consumption` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `alcohol_free_days` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `alcohol_type` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `antigen_status` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `blood_group` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `daily_consumption` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hereditary_history` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `over_all_year_of_smoking` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `recent_health_issue` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `smoking_index` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `smoking_type` to the `Clinic` table without a default value. This is not possible if the table is not empty.
  - Added the required column `birthday` to the `Patient` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contact_information` to the `Patient` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Clinic" DROP COLUMN "alcoholConsumption",
DROP COLUMN "alcoholFreeDays",
DROP COLUMN "alcoholType",
DROP COLUMN "antigenStatus",
DROP COLUMN "bloodGroup",
DROP COLUMN "dailyConsumption",
DROP COLUMN "hereditaryHistory",
DROP COLUMN "overAllYearOfSmoking",
DROP COLUMN "recentHealthIssue",
DROP COLUMN "smokingIndex",
DROP COLUMN "smokingType",
ADD COLUMN     "alcohol_consumption" INTEGER NOT NULL,
ADD COLUMN     "alcohol_free_days" INTEGER NOT NULL,
ADD COLUMN     "alcohol_type" INTEGER NOT NULL,
ADD COLUMN     "antigen_status" TEXT NOT NULL,
ADD COLUMN     "blood_group" TEXT NOT NULL,
ADD COLUMN     "daily_consumption" INTEGER NOT NULL,
ADD COLUMN     "hereditary_history" TEXT NOT NULL,
ADD COLUMN     "over_all_year_of_smoking" INTEGER NOT NULL,
ADD COLUMN     "recent_health_issue" TEXT NOT NULL,
ADD COLUMN     "smoking_index" INTEGER NOT NULL,
ADD COLUMN     "smoking_type" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Patient" DROP COLUMN "BirthDay",
DROP COLUMN "contactInformation",
ADD COLUMN     "birthday" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "contact_information" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "Visit" DROP COLUMN "isClinicalCollected",
DROP COLUMN "isDataCollected",
DROP COLUMN "visitNotes",
ADD COLUMN     "is_clinical_collected" BOOLEAN,
ADD COLUMN     "is_data_collected" BOOLEAN,
ADD COLUMN     "visit_notes" TEXT;
