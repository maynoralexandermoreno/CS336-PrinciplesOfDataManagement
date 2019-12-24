CREATE DATABASE  IF NOT EXISTS `TravelReservations` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `TravelReservations`;
-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: cs336db.ct13jztniefj.us-east-2.rds.amazonaws.com    Database: TravelReservations
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Aircraft`
--

DROP TABLE IF EXISTS `Aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Aircraft` (
  `airlineID` varchar(2) DEFAULT NULL,
  `aircraftID` int(11) NOT NULL,
  `model` varchar(20) NOT NULL,
  `firstSeats` int(11) NOT NULL,
  `buisnessSeats` int(11) NOT NULL,
  `economySeats` int(11) NOT NULL,
  PRIMARY KEY (`aircraftID`),
  KEY `airlineID` (`airlineID`),
  CONSTRAINT `Aircraft_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `Airline` (`airlineID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Airline`
--

DROP TABLE IF EXISTS `Airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airline` (
  `airlineID` varchar(2) NOT NULL,
  PRIMARY KEY (`airlineID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Airline_Airport`
--

DROP TABLE IF EXISTS `Airline_Airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airline_Airport` (
  `airlineID` varchar(2) NOT NULL,
  `airportID` varchar(3) NOT NULL,
  PRIMARY KEY (`airlineID`,`airportID`),
  KEY `airportID` (`airportID`),
  CONSTRAINT `Airline_Airport_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `Airline` (`airlineID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Airline_Airport_ibfk_2` FOREIGN KEY (`airportID`) REFERENCES `Airport` (`airportID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Airport`
--

DROP TABLE IF EXISTS `Airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Airport` (
  `airportID` varchar(3) NOT NULL,
  `city` varchar(30) NOT NULL,
  PRIMARY KEY (`airportID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `accountID` varchar(20) NOT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`accountID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Employee`
--

DROP TABLE IF EXISTS `Employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employee` (
  `employeeID` varchar(20) NOT NULL,
  `isAdmin` tinyint(1) DEFAULT NULL,
  `firstName` varchar(20) DEFAULT NULL,
  `lastName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`employeeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Flight`
--

DROP TABLE IF EXISTS `Flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight` (
  `airlineID` varchar(2) NOT NULL,
  `flightID` int(11) NOT NULL,
  `aircraftID` int(11) NOT NULL,
  `isDomestic` tinyint(1) NOT NULL,
  `departureAirport` varchar(3) DEFAULT NULL,
  `departureDateTime` datetime DEFAULT NULL,
  `arrivalAirport` varchar(3) DEFAULT NULL,
  `arrivalDateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`airlineID`,`flightID`),
  KEY `departureAirport` (`departureAirport`),
  KEY `arrivalAirport` (`arrivalAirport`),
  KEY `airlineID` (`airlineID`,`aircraftID`),
  CONSTRAINT `Flight_ibfk_1` FOREIGN KEY (`airlineID`) REFERENCES `Airline` (`airlineID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Flight_ibfk_2` FOREIGN KEY (`departureAirport`) REFERENCES `Airport` (`airportID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Flight_ibfk_3` FOREIGN KEY (`arrivalAirport`) REFERENCES `Airport` (`airportID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Flight_ibfk_4` FOREIGN KEY (`airlineID`, `aircraftID`) REFERENCES `Aircraft` (`airlineID`, `aircraftID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Flight_Days`
--

DROP TABLE IF EXISTS `Flight_Days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight_Days` (
  `airlineID` varchar(2) NOT NULL,
  `flightID` int(11) NOT NULL,
  `flightDay` varchar(9) NOT NULL,
  PRIMARY KEY (`airlineID`,`flightID`,`flightDay`),
  CONSTRAINT `Flight_Days_ibfk_1` FOREIGN KEY (`airlineID`, `flightID`) REFERENCES `Flight` (`airlineID`, `flightID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Flight_Price`
--

DROP TABLE IF EXISTS `Flight_Price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight_Price` (
  `airlineID` varchar(2) NOT NULL,
  `flightID` int(11) NOT NULL,
  `firstPrice` double DEFAULT NULL,
  `businessPrice` double DEFAULT NULL,
  `economyPrice` double DEFAULT NULL,
  PRIMARY KEY (`airlineID`,`flightID`),
  CONSTRAINT `Flight_Price_ibfk_1` FOREIGN KEY (`airlineID`, `flightID`) REFERENCES `Flight` (`airlineID`, `flightID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Flight_Ticket`
--

DROP TABLE IF EXISTS `Flight_Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Flight_Ticket` (
  `ticketID` int(11) NOT NULL,
  `airlineID` varchar(2) NOT NULL,
  `flightID` int(11) NOT NULL,
  `seatID` int(11) DEFAULT NULL,
  `class` varchar(20) NOT NULL,
  PRIMARY KEY (`ticketID`,`airlineID`,`flightID`),
  KEY `airlineID` (`airlineID`,`flightID`),
  CONSTRAINT `Flight_Ticket_ibfk_1` FOREIGN KEY (`airlineID`, `flightID`) REFERENCES `Flight` (`airlineID`, `flightID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Flight_Ticket_ibfk_2` FOREIGN KEY (`ticketID`) REFERENCES `Ticket` (`ticketID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Ticket`
--

DROP TABLE IF EXISTS `Ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ticket` (
  `ticketID` int(11) NOT NULL AUTO_INCREMENT,
  `accountID` varchar(20) DEFAULT NULL,
  `ticketPrice` double DEFAULT NULL,
  `bookingFee` double DEFAULT NULL,
  `cancelFee` double DEFAULT NULL,
  `isOneWay` tinyint(1) DEFAULT NULL,
  `purchaseDateTime` datetime DEFAULT NULL,
  `travelDateTime` datetime DEFAULT NULL,
  `meal` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ticketID`),
  KEY `accountID` (`accountID`),
  CONSTRAINT `Ticket_ibfk_1` FOREIGN KEY (`accountID`) REFERENCES `Customer` (`accountID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=977795942 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-12-11 18:29:50
