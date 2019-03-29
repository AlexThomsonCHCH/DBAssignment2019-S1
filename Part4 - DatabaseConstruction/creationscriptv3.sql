-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Drop Existing Schema AMSTestData
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `amstestdata`;
-- -----------------------------------------------------
-- Schema AMSTestData
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `AMSTestData` DEFAULT CHARACTER SET utf8 ;
USE `AMSTestData` ;

-- -----------------------------------------------------
-- Table `AMSTestData`.`Job`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Job` (
  `workOrder` CHAR(11) NOT NULL COMMENT 'This is the Unique Identifier for the WorkOrder/Job. This is split out from the rest as there may be multiple tests for the same Job/Installation',
  PRIMARY KEY (`workOrder`))
ENGINE = InnoDB
COMMENT = 'This is the root table of the database. All tests conducted are a result of a workorder. As Primary Keys should be Unique, it has been split out into a seperate table';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Installer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Installer` (
  `employeeID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for an Employee. This is split out from the test tab;e as there may be multiple tests for the same employee (they may work on multiple jobs/test)',
  `userName` VARCHAR(25) NOT NULL COMMENT 'All testing staff must have a username that is used to identify them when the log files come through',
  PRIMARY KEY (`employeeID`))
ENGINE = InnoDB
COMMENT = 'This Table Sits in Regard to Employee Details';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Meter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Meter` (
  `meterID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the Meter. This is split out from the rest as there may be multiple tests for the same meter.',
  `bluetoothName` VARCHAR(25) NOT NULL COMMENT 'This is the bluetooth hostname of the meter. Every bluetooth requires a hostname (hence NN). I went for a value of 25 for the hostname to allow for redundancy in case of duplicates (should be unique)',
  `gpsLong` DECIMAL(20,17) NULL COMMENT 'Longitude of the Meter according to GPS. Set to decimal to allow for precision, with up to 3 places pre-point for degrees, and the rest for precise accuracy of location',
  `gpsLat` DECIMAL(20,17) NULL COMMENT 'lattitude of the Meter according to GPS. Set to decimal to allow for precision, with up to 3 places pre-point for degrees, and the rest for precise accuracy of location',
  `gpsAccuracy` VARCHAR(30) NULL DEFAULT 'kCLLocationAccuracyKilometer' COMMENT 'Normally set to kCLLocationAccuracyKilometer',
  `serialNumber` CHAR(8) NOT NULL COMMENT 'Manafacturers serial code for the meter. Every single meter must have one, and it must be unique. Require 8 places due to standard device template serial number',
  `modemType` VARCHAR(7) NULL COMMENT 'This is the modem type that was used for this testing.',
  `firmwareVersion` CHAR(8) NULL COMMENT 'This is the firmware version of the meter. ',
  PRIMARY KEY (`meterID`),
  UNIQUE INDEX `bluetoothName_UNIQUE` (`bluetoothName` ASC) VISIBLE,
  UNIQUE INDEX `serialNumber_UNIQUE` (`serialNumber` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'These Are Attributes of the Meters ';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Test Equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Test Equipment` (
  `testerID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the test tablet. This may be used for multiple tests of different meters',
  `appVersion` CHAR(5) NULL COMMENT 'This is the version number of the App on the tablet. Char is used to void truncation of values and for accuracy of input',
  `deviceType` VARCHAR(20) NULL COMMENT 'This is used to describe the type of tablet used for the test. ',
  PRIMARY KEY (`testerID`),
  UNIQUE INDEX `testerID_UNIQUE` (`testerID` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This contains details of the tablet (Ipads) used to test the modem';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Test`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Test` (
  `testID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the Test. This is a Unique value',
  `workOrder` CHAR(11) NOT NULL COMMENT 'This is the foreign Key Relating to the Job',
  `meterID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the Meter used in the test',
  `employeeID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the employee used in the test',
  `testerID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the tablet used in the test',
  `date` DATETIME NOT NULL COMMENT 'Date and Time of the Test',
  `testType` VARCHAR(10) NULL DEFAULT 'production' COMMENT 'production or test?',
  `antennaTestType` VARCHAR(17) NOT NULL COMMENT 'This data field confirms what antenna test type it is. ',
  `batteryLevel` DECIMAL(4,2) NULL COMMENT 'This field indicates the level of battery the meter has at the time of testing.',
  `bluetoothSignal` VARCHAR(50) NULL COMMENT 'This indicates the level of bluetooth signal the Meter has to the Tablet at the test time',
  `gen` INT NOT NULL COMMENT 'The generation of test it is',
  PRIMARY KEY (`testID`),
  INDEX `workOrder_idx` (`workOrder` ASC) VISIBLE,
  INDEX `meterID_idx` (`meterID` ASC) VISIBLE,
  INDEX `employeeID_idx` (`employeeID` ASC) VISIBLE,
  INDEX `testerID_idx` (`testerID` ASC) VISIBLE,
  UNIQUE INDEX `testID_UNIQUE` (`testID` ASC) VISIBLE,
  CONSTRAINT `workOrder`
    FOREIGN KEY (`workOrder`)
    REFERENCES `AMSTestData`.`Job` (`workOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `meterID`
    FOREIGN KEY (`meterID`)
    REFERENCES `AMSTestData`.`Meter` (`meterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employeeID`
    FOREIGN KEY (`employeeID`)
    REFERENCES `AMSTestData`.`Installer` (`employeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `testerID`
    FOREIGN KEY (`testerID`)
    REFERENCES `AMSTestData`.`Test Equipment` (`testerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This table contains details of the test and links to the signal results table';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Network`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Network` (
  `networkID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the network. This is split out from the rest as there may be multiple tests for the same network',
  `networkName` VARCHAR(10) NULL COMMENT 'This is the name of the network provider. ',
  PRIMARY KEY (`networkID`),
  UNIQUE INDEX `networkID_UNIQUE` (`networkID` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This contains details and attributes about the different network providers the signal tests for.';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Antenna`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Antenna` (
  `antennaID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the antenna type. This is used to reduce redundancy',
  `antennaName` VARCHAR(5) NULL COMMENT 'The name/type of antenna. e.g blade/whip',
  PRIMARY KEY (`antennaID`),
  UNIQUE INDEX `antennaID_UNIQUE` (`antennaID` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This table contains attributes about the different antennas used to pick up signal for the meters.';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Signal Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Signal Type` (
  `signalID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the signal. This is used to reduce redundancy.',
  `signalName` CHAR(4) NULL COMMENT 'This is the 4 letter abbreviation of the signal type',
  `signalLowerThreshold` DECIMAL(5,2) NULL COMMENT 'The lower threshold of the signal type',
  `signalHigherThreshold` DECIMAL(5,2) NULL COMMENT 'The higher threshold of the signal type',
  PRIMARY KEY (`signalID`),
  UNIQUE INDEX `signalID_UNIQUE` (`signalID` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = 'This contains different signal types (This table helps with normalisation)';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Results` (
  `resultID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the Test Result.',
  `antennaID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the antenna used in the result',
  `networkID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the network used in the result',
  `testID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the parent test',
  `result` CHAR(4) NOT NULL COMMENT 'Indicates whether the result is a pass or a fail',
  `simCard` CHAR(20) NULL COMMENT 'This is the slot for the simacard identifier. ',
  `modemStatus` VARCHAR(45) NULL COMMENT 'network status for the result (diagnostic for network connection)',
  `rawArray` VARCHAR(350) NULL COMMENT 'Raw array of data for the Result',
  `networkReturn` VARCHAR(20) NULL COMMENT 'Name of the network provider as returned during the test (Network Diagnostic)',
  `timeOut` TINYINT NOT NULL COMMENT 'Boolean value to indicate whether the connection timed out to the network.',
  PRIMARY KEY (`resultID`),
  INDEX `antennaID_idx` (`antennaID` ASC) VISIBLE,
  INDEX `networkID_idx` (`networkID` ASC) VISIBLE,
  CONSTRAINT `antennaID`
    FOREIGN KEY (`antennaID`)
    REFERENCES `AMSTestData`.`Antenna` (`antennaID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `networkID`
    FOREIGN KEY (`networkID`)
    REFERENCES `AMSTestData`.`Network` (`networkID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `testID`
    FOREIGN KEY (`testID`)
    REFERENCES `AMSTestData`.`Test` (`testID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This contains information about the different test results. It is more related to signal specifics, so that redundancy can be reduced in the Test Table';


-- -----------------------------------------------------
-- Table `AMSTestData`.`Signal Results`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `AMSTestData`.`Signal Results` (
  `signalResultsID` INT NOT NULL AUTO_INCREMENT COMMENT 'This is the Unique Identifier for the signalResult.',
  `signalID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the signal type used in the test',
  `resultID` INT NOT NULL COMMENT 'This is the foreign Key Relating to the parent test result used in the test',
  `signalStrength` DECIMAL(16,13) NULL COMMENT 'Decimal value outlining how strong the connection was to the specific network type',
  PRIMARY KEY (`signalResultsID`),
  INDEX `signalID_idx` (`signalID` ASC) VISIBLE,
  INDEX `resultID_idx` (`resultID` ASC) VISIBLE,
  UNIQUE INDEX `signalResultsID_UNIQUE` (`signalResultsID` ASC) VISIBLE,
  CONSTRAINT `signalID`
    FOREIGN KEY (`signalID`)
    REFERENCES `AMSTestData`.`Signal Type` (`signalID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `resultID`
    FOREIGN KEY (`resultID`)
    REFERENCES `AMSTestData`.`Results` (`resultID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This contains Results for specific signal types';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
