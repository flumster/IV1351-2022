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


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`people`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`people` (`personnummer`, `telnr`, `addr`, `namn`) VALUES ('201407062431', 0704206942, 'kungliga slottet, 107 70 stockholm', 'Jack Gus');
INSERT INTO `mydb`.`people` (`personnummer`, `telnr`, `addr`, `namn`) VALUES ('198902031234', 0704269420, 'Isafjordsgatan 22, 164 40 Kista', 'Sarafina Starkey');
INSERT INTO `mydb`.`people` (`personnummer`, `telnr`, `addr`, `namn`) VALUES ('201801064321', 0702589632, 'Lordaeron slott, 982 39 Tirisfal', 'Lianne Menethil');
INSERT INTO `mydb`.`people` (`personnummer`, `telnr`, `addr`, `namn`) VALUES ('201407062531', 0702589632, 'kungliga slottet, 107 70 stockholm', 'hejsan svejsan');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`elev`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`elev` (`personnummer`, `MOPtelefonnummer`, `syskon`, `nota`) VALUES ('201407062431', 0700866234, 7, 0);
INSERT INTO `mydb`.`elev` (`personnummer`, `MOPtelefonnummer`, `syskon`, `nota`) VALUES ('201407062531', 0700866234, 7, 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`instruktör`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`instruktör` (`personnummer`, `instrument`, `lön`) VALUES ('198902031234', 'Fagott', 1337);
INSERT INTO `mydb`.`instruktör` (`personnummer`, `instrument`, `lön`) VALUES ('201801064321', 'Harpa', 0);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`rum`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`rum` (`rumnummer`, `platser`) VALUES ('1', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`lektionsprisklass`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`lektionsprisklass` (`skicklighet`, `grupp`, `pris`) VALUES (1, 0, 420);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`lektion`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`lektion` (`lektionsID`, `rumnummer`, `skicklighet`, `instruktörspersonnummer`, `pris`, `datum`) VALUES (1, '1', 1, '198902031234', 420, '2021-12-27');
INSERT INTO `mydb`.`lektion` (`lektionsID`, `rumnummer`, `skicklighet`, `instruktörspersonnummer`, `pris`, `datum`) VALUES (2, '1', 1, '198902031234', 420, '2021-12-28');
INSERT INTO `mydb`.`lektion` (`lektionsID`, `rumnummer`, `skicklighet`, `instruktörspersonnummer`, `pris`, `datum`) VALUES (3, '1', 1, '198902031234', 420, '2021-11-01');
INSERT INTO `mydb`.`lektion` (`lektionsID`, `rumnummer`, `skicklighet`, `instruktörspersonnummer`, `pris`, `datum`) VALUES (4, '1', 1, '198902031234', 420, '2021-01-01');
INSERT INTO `mydb`.`lektion` (`lektionsID`, `rumnummer`, `skicklighet`, `instruktörspersonnummer`, `pris`, `datum`) VALUES (5, '1', 1, '198902031234', 420, '2021-02-02');
INSERT INTO `mydb`.`lektion` (`lektionsID`, `rumnummer`, `skicklighet`, `instruktörspersonnummer`, `pris`, `datum`) VALUES (6, '1', 1, '198902031234', 420, '2021-12-29');
INSERT INTO `mydb`.`lektion` (`lektionsID`, `rumnummer`, `skicklighet`, `instruktörspersonnummer`, `pris`, `datum`) VALUES (7, '1', 2, '201801064321', 420, '2022-01-06');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`elevbokning`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`elevbokning` (`personnummer`, `lektionsID`, `syskonrabatt`, `datum`) VALUES ('201407062431', 2, 0, '2021-12-27');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`grupp`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`grupp` (`lektionsID`, `tidsblock`, `maxelever`, `minelever`) VALUES (2, 0800522, 10, 1);
INSERT INTO `mydb`.`grupp` (`lektionsID`, `tidsblock`, `maxelever`, `minelever`) VALUES (3, 1000443, 10, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`ensemble`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ensemble` (`lektionsID`, `genre`, `antalinstrument`) VALUES (3, 'jazz', 42);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`instrument`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`instrument` (`instrumentID`, `tillverkare`, `instrumenttyp`, `pris`) VALUES (1, 'Henricks', 'fagott', 420);
INSERT INTO `mydb`.`instrument` (`instrumentID`, `tillverkare`, `instrumenttyp`, `pris`) VALUES (2, 'Yamaha', 'violin', 420);
INSERT INTO `mydb`.`instrument` (`instrumentID`, `tillverkare`, `instrumenttyp`, `pris`) VALUES (3, 'Pearl', 'slagwerk', 420);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`instrumenthyra`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`instrumenthyra` (`personnummer`, `instrumentID`, `datum`, `lanetid`) VALUES ('201407062431', 1, '2021-12-01', 1095);
INSERT INTO `mydb`.`instrumenthyra` (`personnummer`, `instrumentID`, `datum`, `lanetid`) VALUES ('201407062431', 2, '2021-12-02', 365);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`singleinstrument`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`singleinstrument` (`lektionsID`, `instrument`) VALUES (2, 'fagott');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`sololektion`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`sololektion` (`lektionsID`, `instrument`, `tid`) VALUES (1, 'fagott', 1920);

COMMIT;

