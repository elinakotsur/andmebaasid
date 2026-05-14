-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Mai 14, 2026 kell 10:38 EL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `protseduurkotsur`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `KliendiHinnang` ()   BEGIN
	SELECT nimi, saldo,
    IF(saldo>100, 'hea klient', 'tavaline klient') AS 		hinnang
    FROM kliendid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Kustuta klient` (IN `kustutaid` INT)   BEGIN
	SELECT * FROM kliendid;
    DELETE FROM kliendid WHERE ID=kustutaid;
    SELECT * FROM kliendid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaloom` (IN `kustutaID` INT)   BEGIN
	SELECT * FROM loomad;
	DELETE FROM loomad WHERE loomadID=kustutaID;
    SELECT * FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Kuva kliendid` ()   BEGIN
	SELECT nimi from kliendid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Lisaklient` (IN `uusNimi` VARCHAR(20), IN `uusLinn` VARCHAR(20), IN `uusVanus` INT, IN `uusSaldo` DECIMAL)   BEGIN
	INSERT INTO kliendid(nimi,linn,vanus,saldo)
    VALUES (uusNimi,uusLinn,uusVanus,uusSaldo);
    SELECT * FROM kliendid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaLoom` (IN `uusNimi` VARCHAR(20), IN `uusKaal` INT, IN `uusAAsta` INT)   BEGIN
	INSERT INTO loomad(loomanimi, kaal, synniaasta)
    VALUES (uusNimi, uusKaal, uusAAsta);
    SELECT * FROM loomad;
    
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `loomaHinnang` ()   BEGIN
	SELECT loomanimi, kaal,
    IF(kaal>8, 'suur loom', 'väike loom') AS
   hinnang
   FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `minmaxkaal` (OUT `minKaal` INT, OUT `maxKaal` INT, OUT `avgKaal` DECIMAL(6,2), OUT `sumKaal` INT, OUT `countLoom` INT)   BEGIN
	SELECT
    	MIN(kaal),MAX(kaal),AVG(kaal),SUM(kaal),COUNT(*)
        INTO minKaal, maxKaal, avgKaal, sumKaal, countLoom
        FROM loomad;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Muuda kliendi andmeid` (IN `uusid` INT, IN `uuslinn` VARCHAR(20))   BEGIN
	SELECT * FROM kliendid;
    UPDATE kliendid
    SET linn = uuslinn
    WHERE ID = uusid;
    
    SELECT * FROM kliendid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `naitalooma` ()   BEGIN
	SELECT loomanimi FROM loomad;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Otsi klienti` (IN `taht` CHAR(1))   BEGIN
	SELECT * FROM kliendid
    WHERE nimi LIKE Concat(taht, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1taht` (IN `taht` CHAR(1))   BEGIN
	SELECT * FROM loomad
    WHERE loomanimi LIKE Concat(taht, '%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Saldo min/max` (OUT `minKlient` INT, OUT `maxKlient` INT)   BEGIN
	SELECT
    	MIN(saldo),MAX(saldo)
        INTO minKlient, maxKlient
        FROM kliendid;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Veeru haldus` (IN `valik` VARCHAR(30), IN `tabelinimi` VARCHAR(25), IN `veerunimi` VARCHAR(25), IN `tyyp` VARCHAR(25))   BEGIN
	SET @sql = CASE
    WHEN valik LIKE 'add' THEN
    	CONCAT('ALTER TABLE', tabelinimi, ' ADD ', veerunimi, ' ', tyyp)
    WHEN valik LIKE 'drop' THEN
    	CONCAT('ALTER TABLE', tabelinimi, ' DROP COLUMN ', veerunimi, ' ')
    END;
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kliendid`
--

CREATE TABLE `kliendid` (
  `ID` int(11) NOT NULL,
  `nimi` varchar(20) NOT NULL,
  `linn` varchar(20) DEFAULT NULL,
  `vanus` int(11) DEFAULT NULL,
  `saldo` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `kliendid`
--

INSERT INTO `kliendid` (`ID`, `nimi`, `linn`, `vanus`, `saldo`) VALUES
(1, 'elina', 'Tallin', 18, 7000),
(3, 'savelij', 'Tallin', 23, 500),
(4, 'nastja', 'Viimsi', 15, 10);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `klient`
--

CREATE TABLE `klient` (
  `ID` int(11) NOT NULL,
  `nimi` text NOT NULL,
  `linn` text DEFAULT NULL,
  `saldo` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `klient`
--

INSERT INTO `klient` (`ID`, `nimi`, `linn`, `saldo`) VALUES
(1, 'darja', 'Tallinn', 1000),
(2, 'elina', 'Viimsi', 7000),
(3, 'savelij', 'Võru', 500);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `loomad`
--

CREATE TABLE `loomad` (
  `loomadID` int(11) NOT NULL,
  `loomanimi` varchar(20) NOT NULL,
  `kaal` int(11) DEFAULT NULL,
  `synniaasta` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `loomad`
--

INSERT INTO `loomad` (`loomadID`, `loomanimi`, `kaal`, `synniaasta`) VALUES
(2, 'kass dasa', 10, 2024),
(3, 'papagoi', 2, 2009),
(4, 'gekon', 1, 2024);

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `kliendid`
--
ALTER TABLE `kliendid`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksid tabelile `klient`
--
ALTER TABLE `klient`
  ADD PRIMARY KEY (`ID`);

--
-- Indeksid tabelile `loomad`
--
ALTER TABLE `loomad`
  ADD PRIMARY KEY (`loomadID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `kliendid`
--
ALTER TABLE `kliendid`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `klient`
--
ALTER TABLE `klient`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `loomad`
--
ALTER TABLE `loomad`
  MODIFY `loomadID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
