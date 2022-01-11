-- MySQL Workbench Forward Engineering
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

