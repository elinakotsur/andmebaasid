-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Aprill 30, 2026 kell 10:04 EL
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
-- Andmebaas: `hotellkotsurbaas`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `guest`
--

CREATE TABLE `guest` (
  `guestID` int(11) NOT NULL,
  `first_name` varchar(80) DEFAULT NULL,
  `last_name` varchar(80) NOT NULL,
  `member_since` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Andmete tõmmistamine tabelile `guest`
--

INSERT INTO `guest` (`guestID`, `first_name`, `last_name`, `member_since`) VALUES
(1, '\'elina\'', '\'kotsur\'', '2026-04-08'),
(2, 'dasa', 'kovalenko', '2024-08-14'),
(3, 'dima', 'pozekov', '2024-08-15');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `hosted_at`
--

CREATE TABLE `hosted_at` (
  `hosted_atID` int(11) NOT NULL,
  `guestID` int(11) DEFAULT NULL,
  `occupied_roomID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Andmete tõmmistamine tabelile `hosted_at`
--

INSERT INTO `hosted_at` (`hosted_atID`, `guestID`, `occupied_roomID`) VALUES
(1, 1, 1),
(2, 2, 3),
(3, 3, 2);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `occupied_room`
--

CREATE TABLE `occupied_room` (
  `occupied_roomID` int(11) NOT NULL,
  `check_in` date DEFAULT NULL,
  `check_out` date DEFAULT NULL,
  `roomID` int(11) DEFAULT NULL,
  `reservationID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Andmete tõmmistamine tabelile `occupied_room`
--

INSERT INTO `occupied_room` (`occupied_roomID`, `check_in`, `check_out`, `roomID`, `reservationID`) VALUES
(1, '2026-01-01', '2026-02-01', 1, 1),
(2, '2025-12-01', '2026-05-12', 2, 2),
(3, '2024-01-13', '2026-02-01', 3, 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `reservation`
--

CREATE TABLE `reservation` (
  `reservationID` int(11) NOT NULL,
  `date_in` date DEFAULT NULL,
  `date_out` date DEFAULT NULL,
  `made_by` varchar(20) DEFAULT NULL,
  `guestID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Andmete tõmmistamine tabelile `reservation`
--

INSERT INTO `reservation` (`reservationID`, `date_in`, `date_out`, `made_by`, `guestID`) VALUES
(1, '2025-03-04', '2025-07-04', 'admin', 1),
(2, '2023-06-04', '2025-07-04', 'admin1', 2),
(3, '2024-12-05', '2024-12-06', 'admin2', 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `reserved_room`
--

CREATE TABLE `reserved_room` (
  `reserved_roomID` int(11) NOT NULL,
  `number_of_rooms` int(11) DEFAULT NULL,
  `room_typeID` int(11) DEFAULT NULL,
  `reservationID` int(11) DEFAULT NULL,
  `reserved_room_status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Andmete tõmmistamine tabelile `reserved_room`
--

INSERT INTO `reserved_room` (`reserved_roomID`, `number_of_rooms`, `room_typeID`, `reservationID`, `reserved_room_status`) VALUES
(1, 4, 1, 1, 'kõik korras'),
(2, 2, 3, 2, 'hästi'),
(3, 1, 2, 3, 'kõik korras');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `room`
--

CREATE TABLE `room` (
  `roomID` int(11) NOT NULL,
  `number` varchar(10) DEFAULT NULL,
  `room_name` varchar(40) DEFAULT NULL,
  `room_status` varchar(10) DEFAULT NULL,
  `smoke` bit(1) DEFAULT NULL,
  `room_typeID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Andmete tõmmistamine tabelile `room`
--

INSERT INTO `room` (`roomID`, `number`, `room_name`, `room_status`, `smoke`, `room_typeID`) VALUES
(1, 'A123', 'good_room1', 'vaba', b'0', 1),
(2, 'B113', 'super_room', 'vaba', b'1', 2),
(3, 'B333', 'premium_room', 'vaba', b'1', 3);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `room_type`
--

CREATE TABLE `room_type` (
  `room_typeID` int(11) NOT NULL,
  `room_description` varchar(80) DEFAULT NULL,
  `max_capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Andmete tõmmistamine tabelile `room_type`
--

INSERT INTO `room_type` (`room_typeID`, `room_description`, `max_capacity`) VALUES
(1, 'good', 5),
(2, 'vip', 10),
(3, 'for_millioner', 150);

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `guest`
--
ALTER TABLE `guest`
  ADD PRIMARY KEY (`guestID`);

--
-- Indeksid tabelile `hosted_at`
--
ALTER TABLE `hosted_at`
  ADD PRIMARY KEY (`hosted_atID`),
  ADD KEY `guestID` (`guestID`),
  ADD KEY `occupied_roomID` (`occupied_roomID`);

--
-- Indeksid tabelile `occupied_room`
--
ALTER TABLE `occupied_room`
  ADD PRIMARY KEY (`occupied_roomID`),
  ADD KEY `roomID` (`roomID`),
  ADD KEY `reservationID` (`reservationID`);

--
-- Indeksid tabelile `reservation`
--
ALTER TABLE `reservation`
  ADD PRIMARY KEY (`reservationID`),
  ADD KEY `guestID` (`guestID`);

--
-- Indeksid tabelile `reserved_room`
--
ALTER TABLE `reserved_room`
  ADD PRIMARY KEY (`reserved_roomID`),
  ADD KEY `room_typeID` (`room_typeID`),
  ADD KEY `reservationID` (`reservationID`);

--
-- Indeksid tabelile `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`roomID`),
  ADD KEY `room_typeID` (`room_typeID`);

--
-- Indeksid tabelile `room_type`
--
ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_typeID`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `guest`
--
ALTER TABLE `guest`
  MODIFY `guestID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `hosted_at`
--
ALTER TABLE `hosted_at`
  MODIFY `hosted_atID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `occupied_room`
--
ALTER TABLE `occupied_room`
  MODIFY `occupied_roomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `reservation`
--
ALTER TABLE `reservation`
  MODIFY `reservationID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `reserved_room`
--
ALTER TABLE `reserved_room`
  MODIFY `reserved_roomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `room`
--
ALTER TABLE `room`
  MODIFY `roomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `room_type`
--
ALTER TABLE `room_type`
  MODIFY `room_typeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `hosted_at`
--
ALTER TABLE `hosted_at`
  ADD CONSTRAINT `hosted_at_ibfk_1` FOREIGN KEY (`guestID`) REFERENCES `guest` (`guestID`),
  ADD CONSTRAINT `hosted_at_ibfk_2` FOREIGN KEY (`occupied_roomID`) REFERENCES `occupied_room` (`occupied_roomID`);

--
-- Piirangud tabelile `occupied_room`
--
ALTER TABLE `occupied_room`
  ADD CONSTRAINT `occupied_room_ibfk_1` FOREIGN KEY (`roomID`) REFERENCES `room` (`roomID`),
  ADD CONSTRAINT `occupied_room_ibfk_2` FOREIGN KEY (`reservationID`) REFERENCES `reservation` (`reservationID`);

--
-- Piirangud tabelile `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`guestID`) REFERENCES `guest` (`guestID`);

--
-- Piirangud tabelile `reserved_room`
--
ALTER TABLE `reserved_room`
  ADD CONSTRAINT `reserved_room_ibfk_1` FOREIGN KEY (`room_typeID`) REFERENCES `room_type` (`room_typeID`),
  ADD CONSTRAINT `reserved_room_ibfk_2` FOREIGN KEY (`reservationID`) REFERENCES `reservation` (`reservationID`);

--
-- Piirangud tabelile `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`room_typeID`) REFERENCES `room_type` (`room_typeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
