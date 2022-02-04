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
USE `mydb` ;

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`average_lessons_this_year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`average_lessons_this_year` (`lektioner` INT);

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
CREATE TABLE IF NOT EXISTS `mydb`.`instructor_lessons_this_month` (`personnummer` INT, `antal` INT);

-- -----------------------------------------------------
-- Placeholder table for view `mydb`.`query for ensemble next week (current is week43)`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`query for ensemble next week (current is week43)` (`lektionsID` INT, `genre` INT, `platser_kvar` INT);

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
SELECT (SELECT Count(*) 
	FROM lektion WHERE Year(datum) = 2021)/12 AS lektioner;

-- -----------------------------------------------------
-- View `mydb`.`singleinstrument_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`singleinstrument_this_year`;
DROP VIEW IF EXISTS `mydb`.`singleinstrument_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `singleinstrument_this_year` AS
SELECT Month(lektion.datum) AS månad, Count(*) AS antal
FROM lektion INNER JOIN singleinstrument ON lektion.lektionsID = singleinstrument.LektionsID AND YEAR(lektion.datum) = 2021
GROUP BY Month(lektion.datum);

-- -----------------------------------------------------
-- View `mydb`.`average_singleinstrument_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`average_singleinstrument_this_year`;
DROP VIEW IF EXISTS `mydb`.`average_singleinstrument_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `average_singleinstrument_this_year` AS
SELECT (SELECT COUNT(*) FROM lektion INNER JOIN singleinstrument ON lektion.lektionsID = singleinstrument.LektionsID AND YEAR(lektion.datum) = 2021) /12 AS AvgOfantal;

-- -----------------------------------------------------
-- View `mydb`.`sololektion_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`sololektion_this_year`;
DROP VIEW IF EXISTS `mydb`.`sololektion_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `sololektion_this_year` AS
SELECT Month(lektion.datum) AS månad, Count(*) AS antal
FROM lektion INNER JOIN sololektion ON lektion.lektionsID = sololektion.LektionsID AND YEAR(lektion.datum) = 2021
GROUP BY Month(lektion.datum);

-- -----------------------------------------------------
-- View `mydb`.`avg_sololektion_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`avg_sololektion_this_year`;
DROP VIEW IF EXISTS `mydb`.`avg_sololektion_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `avg_sololektion_this_year` AS
SELECT (SELECT COUNT(*) FROM lektion INNER JOIN sololektion ON lektion.lektionsID = sololektion.LektionsID AND YEAR(lektion.datum) = 2021)/12 AS AvgOfantal;

-- -----------------------------------------------------
-- View `mydb`.`ensambles_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ensambles_this_year`;
DROP VIEW IF EXISTS `mydb`.`ensambles_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `ensambles_this_year` AS
SELECT Month(lektion.datum) AS månad, COUNT(*) AS antal
FROM lektion INNER JOIN ensemble ON lektion.lektionsID = ensemble.LektionsID AND YEAR(lektion.datum) = 2021
GROUP BY Month(lektion.datum);

-- -----------------------------------------------------
-- View `mydb`.`average_ensambles_this_year`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`average_ensambles_this_year`;
DROP VIEW IF EXISTS `mydb`.`average_ensambles_this_year` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `average_ensambles_this_year` AS
SELECT (SELECT COUNT(*) FROM lektion INNER JOIN ensemble ON lektion.lektionsID = ensemble.LektionsID AND YEAR(lektion.datum) = 2021)/12 AS AvgOfantal;

-- -----------------------------------------------------
-- View `mydb`.`instructor_lessons_this_month`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`instructor_lessons_this_month`;
DROP VIEW IF EXISTS `mydb`.`instructor_lessons_this_month` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `instructor_lessons_this_month` AS
SELECT instruktör.personnummer, Count(*) AS antal
FROM lektion INNER JOIN instruktör ON lektion.instruktörspersonnummer = instruktör.personnummer AND Month(lektion.datum) = 12 AND Year(lektion.datum) = 2021
GROUP BY instruktör.personnummer
HAVING antal >1
ORDER BY antal;

-- -----------------------------------------------------
-- View `mydb`.`query for ensemble next week (current is week43)`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`query for ensemble next week (current is week43)`;
DROP VIEW IF EXISTS `mydb`.`query for ensemble next week (current is week43)` ;
USE `mydb`;
CREATE  OR REPLACE VIEW `query for ensemble next week (current is week43)` AS
SELECT (SELECT lektion.lektionsID
	FROM lektion
    INNER JOIN elevbokning
    ON lektion.lektionsID = elevbokning.lektionsID
    INNER JOIN ensemble
    ON lektion.lektionsID = ensemble.lektionsID 
    INNER JOIN grupp
    ON grupp.lektionsID = ensemble.lektionsID AND
    MID(grupp.tidsblock,8,2) = '44' )AS lektionsID,
     (SELECT ensemble.genre
	FROM lektion
    INNER JOIN elevbokning
    ON lektion.lektionsID = elevbokning.lektionsID
    INNER JOIN ensemble
    ON lektion.lektionsID = ensemble.lektionsID 
    INNER JOIN grupp
    ON grupp.lektionsID = ensemble.lektionsID AND
    MID(grupp.tidsblock,8,2) = '44' )AS genre,
(SELECT 
CASE 
	WHEN antal <0 THEN 'full booked'
    WHEN antal < 3 AND antal > 0 THEN '1-2 seats left'
    ELSE 'has more seats left'
END AS platser_kvar
FROM
(SELECT ((SELECT rum.platser AS lektionsid
	FROM rum 
	INNER JOIN lektion
    ON rum.rumnummer = lektion.rumnummer
    INNER JOIN ensemble
    ON lektion.lektionsID = ensemble.lektionsID
    INNER JOIN grupp
    ON grupp.lektionsID = ensemble.lektionsID AND MID(grupp.tidsblock,8,2) = '44')
    -
(SELECT COUNT(*) AS test
    FROM lektion
    INNER JOIN elevbokning
    ON lektion.lektionsID = elevbokning.lektionsID
    INNER JOIN ensemble
    ON lektion.lektionsID = ensemble.lektionsID 
    INNER JOIN grupp
    ON grupp.lektionsID = ensemble.lektionsID AND MID(grupp.tidsblock,8,2) = '44'
    )) AS antal) AS antal3) AS platser_kvar
    ORDER BY genre;

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
