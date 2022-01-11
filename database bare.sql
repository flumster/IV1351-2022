-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`people` ;

CREATE TABLE IF NOT EXISTS `mydb`.`people` (
  `personnummer` VARCHAR(14) NOT NULL,
  `telnr` INT NULL,
  `addr` VARCHAR(45) NULL,
  `namn` VARCHAR(20) NULL,
  PRIMARY KEY (`personnummer`),
  UNIQUE INDEX `personnummer_UNIQUE` (`personnummer` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`elev`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`elev` ;

CREATE TABLE IF NOT EXISTS `mydb`.`elev` (
  `personnummer` VARCHAR(14) NOT NULL,
  `MOPtelefonnummer` DOUBLE NOT NULL,
  `syskon` INT NULL,
  `nota` DOUBLE NULL,
  PRIMARY KEY (`personnummer`),
  UNIQUE INDEX `personnummer_UNIQUE` (`personnummer` ASC) VISIBLE,
  CONSTRAINT `personsnummer`
    FOREIGN KEY (`personnummer`)
    REFERENCES `mydb`.`people` (`personnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`anmälan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`anmälan` ;

CREATE TABLE IF NOT EXISTS `mydb`.`anmälan` (
  `personnummer` VARCHAR(14) NOT NULL,
  `skicklighet` INT UNSIGNED NOT NULL,
  `ensemble` INT NULL,
  `genre` VARCHAR(45) NULL,
  PRIMARY KEY (`personnummer`),
  UNIQUE INDEX `personnummer_UNIQUE` (`personnummer` ASC) VISIBLE,
  CONSTRAINT `elevpersonnummer`
    FOREIGN KEY (`personnummer`)
    REFERENCES `mydb`.`elev` (`personnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`instruktör`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`instruktör` ;

CREATE TABLE IF NOT EXISTS `mydb`.`instruktör` (
  `personnummer` VARCHAR(14) NOT NULL,
  `instrument` VARCHAR(45) NULL,
  `lön` DOUBLE NULL,
  PRIMARY KEY (`personnummer`),
  UNIQUE INDEX `personnummer_UNIQUE` (`personnummer` ASC) VISIBLE,
  CONSTRAINT `persnummr`
    FOREIGN KEY (`personnummer`)
    REFERENCES `mydb`.`people` (`personnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rum`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`rum` ;

CREATE TABLE IF NOT EXISTS `mydb`.`rum` (
  `rumnummer` VARCHAR(20) NOT NULL,
  `platser` INT NULL,
  PRIMARY KEY (`rumnummer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lektionsprisklass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`lektionsprisklass` ;

CREATE TABLE IF NOT EXISTS `mydb`.`lektionsprisklass` (
  `skicklighet` INT NOT NULL,
  `grupp` INT NOT NULL,
  `pris` INT NOT NULL,
  PRIMARY KEY (`skicklighet`, `grupp`),
  UNIQUE INDEX `pris_UNIQUE` (`pris` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lektion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`lektion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`lektion` (
  `lektionsID` INT NOT NULL AUTO_INCREMENT,
  `rumnummer` VARCHAR(20) NOT NULL,
  `skicklighet` INT NOT NULL,
  `instruktörspersonnummer` VARCHAR(14) NOT NULL,
  `pris` INT NOT NULL,
  `datum` DATE NOT NULL,
  PRIMARY KEY (`lektionsID`),
  UNIQUE INDEX `lektionsID_UNIQUE` (`lektionsID` ASC) VISIBLE,
  INDEX `instpersnummr_idx` (`instruktörspersonnummer` ASC) VISIBLE,
  INDEX `rmnmr_idx` (`rumnummer` ASC) VISIBLE,
  INDEX `prs_idx` (`pris` ASC) VISIBLE,
  CONSTRAINT `instpersnummr`
    FOREIGN KEY (`instruktörspersonnummer`)
    REFERENCES `mydb`.`instruktör` (`personnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `rmnmr`
    FOREIGN KEY (`rumnummer`)
    REFERENCES `mydb`.`rum` (`rumnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `prs`
    FOREIGN KEY (`pris`)
    REFERENCES `mydb`.`lektionsprisklass` (`pris`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`elevbokning`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`elevbokning` ;

CREATE TABLE IF NOT EXISTS `mydb`.`elevbokning` (
  `personnummer` VARCHAR(14) NOT NULL,
  `lektionsID` INT NOT NULL AUTO_INCREMENT,
  `syskonrabatt` INT NULL,
  `datum` DATE NULL,
  PRIMARY KEY (`personnummer`),
  UNIQUE INDEX `personnummer_UNIQUE` (`personnummer` ASC) VISIBLE,
  UNIQUE INDEX `lektionsID_UNIQUE` (`lektionsID` ASC) VISIBLE,
  CONSTRAINT `elevpersnummer`
    FOREIGN KEY (`personnummer`)
    REFERENCES `mydb`.`elev` (`personnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `lektID`
    FOREIGN KEY (`lektionsID`)
    REFERENCES `mydb`.`lektion` (`lektionsID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`grupp`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`grupp` ;

CREATE TABLE IF NOT EXISTS `mydb`.`grupp` (
  `lektionsID` INT NOT NULL,
  `tidsblock` INT ZEROFILL NULL,
  `maxelever` INT NULL,
  `minelever` INT NULL,
  PRIMARY KEY (`lektionsID`),
  UNIQUE INDEX `lektionsID_UNIQUE` (`lektionsID` ASC) VISIBLE,
  CONSTRAINT `lekIDgrupp`
    FOREIGN KEY (`lektionsID`)
    REFERENCES `mydb`.`lektion` (`lektionsID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ensemble`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ensemble` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ensemble` (
  `lektionsID` INT NOT NULL,
  `genre` VARCHAR(45) NOT NULL,
  `antalinstrument` INT NOT NULL,
  PRIMARY KEY (`lektionsID`),
  UNIQUE INDEX `lektionsID_UNIQUE` (`lektionsID` ASC) VISIBLE,
  CONSTRAINT `lekIDensemble`
    FOREIGN KEY (`lektionsID`)
    REFERENCES `mydb`.`grupp` (`lektionsID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`instrument`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`instrument` ;

CREATE TABLE IF NOT EXISTS `mydb`.`instrument` (
  `instrumentID` INT NOT NULL AUTO_INCREMENT,
  `tillverkare` VARCHAR(45) NOT NULL,
  `instrumenttyp` VARCHAR(45) NOT NULL,
  `pris` INT NOT NULL,
  PRIMARY KEY (`instrumentID`),
  UNIQUE INDEX `instrumentID_UNIQUE` (`instrumentID` ASC) VISIBLE)
ENGINE = InnoDB
COMMENT = '		';


-- -----------------------------------------------------
-- Table `mydb`.`instrumenthyra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`instrumenthyra` ;

CREATE TABLE IF NOT EXISTS `mydb`.`instrumenthyra` (
  `personnummer` VARCHAR(14) NOT NULL,
  `instrumentID` INT NOT NULL,
  `datum` DATE NOT NULL,
  `lanetid` INT NOT NULL,
  PRIMARY KEY (`personnummer`, `instrumentID`, `datum`),
  INDEX `instID_idx` (`instrumentID` ASC) VISIBLE,
  CONSTRAINT `personnummers`
    FOREIGN KEY (`personnummer`)
    REFERENCES `mydb`.`elev` (`personnummer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `instID`
    FOREIGN KEY (`instrumentID`)
    REFERENCES `mydb`.`instrument` (`instrumentID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`singleinstrument`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`singleinstrument` ;

CREATE TABLE IF NOT EXISTS `mydb`.`singleinstrument` (
  `lektionsID` INT NOT NULL,
  `instrument` VARCHAR(45) NULL,
  PRIMARY KEY (`lektionsID`),
  UNIQUE INDEX `lektionsID_UNIQUE` (`lektionsID` ASC) VISIBLE,
  CONSTRAINT `lekIDsingle`
    FOREIGN KEY (`lektionsID`)
    REFERENCES `mydb`.`grupp` (`lektionsID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`sololektion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`sololektion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`sololektion` (
  `lektionsID` INT NOT NULL,
  `instrument` VARCHAR(45) NULL,
  `tid` INT NULL,
  PRIMARY KEY (`lektionsID`),
  UNIQUE INDEX `lektionsID_UNIQUE` (`lektionsID` ASC) VISIBLE,
  CONSTRAINT `lekid`
    FOREIGN KEY (`lektionsID`)
    REFERENCES `mydb`.`lektion` (`lektionsID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;
