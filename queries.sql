-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`average_lessons_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`average_lessons_this_year` (`AvgOfantal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`singleinstrument_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`singleinstrument_this_year` (`månad` INT, `antal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`average_singleinstrument_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`average_singleinstrument_this_year` (`AvgOfantal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`sololektion_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`sololektion_this_year` (`månad` INT, `antal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`avg_sololektion_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`avg_sololektion_this_year` (`AvgOfantal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`ensambles_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ensambles_this_year` (`månad` INT, `antal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`average_ensambles_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`average_ensambles_this_year` (`AvgOfantal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`instructor_lessons_this_month`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`instructor_lessons_this_month` (`instruktör` INT, `antal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`query for ensemble next week (current is week43)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`query for ensemble next week (current is week43)` (`Platser_Kvar` INT, `genre` INT, `lektionsID` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`lessons_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lessons_this_year` (`Month` INT, `antal` INT);

-- -----------------------------------------------------
-- View `mydb`.`average_lessons_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`average_lessons_this_year`;
DROP VIEW IF EXISTS `mydb`.`average_lessons_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `average_lessons_this_year` AS
SELECT Avg(lessons_this_year.antal) AS AvgOfantal
FROM lessons_this_year;

-- -----------------------------------------------------
-- View `mydb`.`singleinstrument_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`singleinstrument_this_year`;
DROP VIEW IF EXISTS `mydb`.`singleinstrument_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `singleinstrument_this_year` AS
SELECT Month(lektion.datum) AS månad, Count(*) AS antal
FROM lektion INNER JOIN singleinstrument ON lektion.lektionsID = singleinstrument.LektionsID
GROUP BY Month(lektion.datum);

-- -----------------------------------------------------
-- View `mydb`.`average_singleinstrument_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`average_singleinstrument_this_year`;
DROP VIEW IF EXISTS `mydb`.`average_singleinstrument_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `average_singleinstrument_this_year` AS
SELECT Avg(singleinstrument_this_year.antal) AS AvgOfantal
FROM singleinstrument_this_year;

-- -----------------------------------------------------
-- View `mydb`.`sololektion_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`sololektion_this_year`;
DROP VIEW IF EXISTS `mydb`.`sololektion_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `sololektion_this_year` AS
SELECT Month(lektion.datum) AS månad, Count(*) AS antal
FROM lektion INNER JOIN sololektion ON lektion.lektionsID = sololektion.LektionsID
GROUP BY Month(lektion.datum);

-- -----------------------------------------------------
-- View `mydb`.`avg_sololektion_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`avg_sololektion_this_year`;
DROP VIEW IF EXISTS `mydb`.`avg_sololektion_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `avg_sololektion_this_year` AS
SELECT Avg(sololektion_this_year.antal) AS AvgOfantal
FROM sololektion_this_year;

-- -----------------------------------------------------
-- View `mydb`.`ensambles_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ensambles_this_year`;
DROP VIEW IF EXISTS `mydb`.`ensambles_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `ensambles_this_year` AS
SELECT Month(lektion.datum) AS månad, COUNT(*) AS antal
FROM lektion INNER JOIN ensemble ON lektion.lektionsID = ensemble.LektionsID
GROUP BY Month(lektion.datum);

-- -----------------------------------------------------
-- View `mydb`.`average_ensambles_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`average_ensambles_this_year`;
DROP VIEW IF EXISTS `mydb`.`average_ensambles_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `average_ensambles_this_year` AS
SELECT Avg(ensambles_this_year.antal) AS AvgOfantal
FROM ensambles_this_year;

-- -----------------------------------------------------
-- View `mydb`.`instructor_lessons_this_month`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`instructor_lessons_this_month`;
DROP VIEW IF EXISTS `mydb`.`instructor_lessons_this_month` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `instructor_lessons_this_month` AS
SELECT instruktör.personnummer AS instruktör, Count(*) AS antal
FROM lektion INNER JOIN instruktör ON lektion.instruktörspersonnummer = instruktör.personnummer AND Month(lektion.datum) = 12 AND Year(lektion.datum) = 2021
GROUP BY instruktör.personnummer;

-- -----------------------------------------------------
-- View `mydb`.`query for ensemble next week (current is week43)`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`query for ensemble next week (current is week43)`;
DROP VIEW IF EXISTS `mydb`.`query for ensemble next week (current is week43)` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `query for ensemble next week (current is week43)` AS
SELECT 
((SELECT rum.platser
FROM rum
WHERE rumnummer = rum.rumnummer IN (SELECT lektion.rumnummer 
FROM grupp INNER JOIN lektion
ON grupp.lektionsID = lektion.lektionsID AND MID(grupp.tidsblock,5,2) = '44')
)
-
(SELECT COUNT(*)
FROM grupp INNER JOIN elevbokning
ON grupp.lektionsID = elevbokning.lektionsID AND MID(grupp.tidsblock,5,2) = '44'
GROUP BY grupp.lektionsID))
 AS Platser_Kvar,
 (SELECT ensemble.genre
 FROM ensemble INNER JOIN grupp
 ON ensemble.lektionsID = grupp.lektionsID ) AS genre,
 (SELECT grupp.lektionsID
 FROM grupp INNER JOIN elevbokning
ON grupp.lektionsID = elevbokning.lektionsID ) AS lektionsID;

-- -----------------------------------------------------
-- View `mydb`.`lessons_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`lessons_this_year`;
DROP VIEW IF EXISTS `mydb`.`lessons_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `lessons_this_year` AS
SELECT Month(datum) AS Month, Count(*) AS antal
FROM lektion
WHERE (((Year(datum))=2021))
GROUP BY Month(datum);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
