CREATE DATABASE  IF NOT EXISTS `cs5200_project` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `cs5200_project`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: cs5200_project
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `athelete_ranking`
--

DROP TABLE IF EXISTS `athelete_ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `athelete_ranking` (
  `rank_id` int NOT NULL AUTO_INCREMENT,
  `world_rank` int NOT NULL,
  `points` int NOT NULL,
  `ranking_date` date NOT NULL,
  `federation` varchar(8) NOT NULL,
  `athlete_id` int DEFAULT NULL,
  `sport_id` int DEFAULT NULL,
  PRIMARY KEY (`rank_id`),
  KEY `athlete_id` (`athlete_id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `athelete_ranking_ibfk_1` FOREIGN KEY (`athlete_id`) REFERENCES `athlete` (`athlete_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `athelete_ranking_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athelete_ranking`
--

LOCK TABLES `athelete_ranking` WRITE;
/*!40000 ALTER TABLE `athelete_ranking` DISABLE KEYS */;
INSERT INTO `athelete_ranking` VALUES (1,1,1500,'2021-12-01','FIBA',1,1),(2,2,1450,'2021-12-01','FIFA',2,2),(3,3,1400,'2021-12-01','FINA',3,3),(4,4,1380,'2021-12-01','IAAF',4,4),(5,5,1350,'2021-12-01','FIG',5,5),(6,6,1320,'2021-12-01','ITF',6,7),(7,7,1280,'2021-12-01','BWF',7,9),(8,8,1250,'2021-12-01','FINA',8,3),(9,9,1200,'2021-12-01','UCI',10,11);
/*!40000 ALTER TABLE `athelete_ranking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `athlete`
--

DROP TABLE IF EXISTS `athlete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `athlete` (
  `athlete_id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(32) NOT NULL,
  `last_name` varchar(32) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `height` float DEFAULT NULL,
  `weight` float DEFAULT NULL,
  `country_id` int NOT NULL,
  `sport_id` int NOT NULL,
  PRIMARY KEY (`athlete_id`),
  KEY `country_id` (`country_id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `athlete_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `athlete_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `athlete_chk_1` CHECK ((`height` > 0)),
  CONSTRAINT `athlete_chk_2` CHECK ((`weight` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athlete`
--

LOCK TABLES `athlete` WRITE;
/*!40000 ALTER TABLE `athlete` DISABLE KEYS */;
INSERT INTO `athlete` VALUES (1,'LeBron','James','1984-12-30','Male',2.03,113.4,1,1),(2,'Megan','Rapinoe','1985-07-05','Female',1.68,57,1,2),(3,'Sun','Yang','1991-12-01','Male',1.98,89.8,3,3),(4,'Usain','Bolt','1986-08-21','Male',1.95,94,8,4),(5,'Simone','Biles','1997-03-14','Female',1.42,47,1,5),(6,'Roger','Federer','1981-08-08','Male',1.85,85,5,7),(7,'PV','Sindhu','1995-07-05','Female',1.79,65,7,9),(8,'Michael','Phelps','1985-06-30','Male',1.93,88,1,3),(9,'Chris','Froome','1985-05-20','Male',1.86,71,11,11),(10,'Nicola','Adams','1982-10-26','Female',1.64,51,12,12);
/*!40000 ALTER TABLE `athlete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `athlete_win_history`
--

DROP TABLE IF EXISTS `athlete_win_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `athlete_win_history` (
  `athlete_id` int NOT NULL,
  `sport_id` int NOT NULL,
  `medal_id` int NOT NULL,
  `win_date` date NOT NULL,
  PRIMARY KEY (`athlete_id`,`sport_id`,`medal_id`,`win_date`),
  KEY `sport_id` (`sport_id`),
  KEY `medal_id` (`medal_id`),
  CONSTRAINT `athlete_win_history_ibfk_1` FOREIGN KEY (`athlete_id`) REFERENCES `athlete` (`athlete_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `athlete_win_history_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `athlete_win_history_ibfk_3` FOREIGN KEY (`medal_id`) REFERENCES `medal` (`medal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `athlete_win_history`
--

LOCK TABLES `athlete_win_history` WRITE;
/*!40000 ALTER TABLE `athlete_win_history` DISABLE KEYS */;
INSERT INTO `athlete_win_history` VALUES (1,1,1,'2021-07-25'),(2,2,2,'2021-07-26'),(3,3,1,'2021-07-27'),(8,3,2,'2008-08-11'),(4,4,1,'2009-08-16'),(9,4,1,'2021-08-06'),(5,5,3,'2021-07-29'),(6,7,1,'2012-07-28'),(7,9,1,'2021-07-30'),(10,11,1,'2020-09-10');
/*!40000 ALTER TABLE `athlete_win_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `broadcasted_`
--

DROP TABLE IF EXISTS `broadcasted_`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `broadcasted_` (
  `broadcaster_id` int NOT NULL,
  `olympic_event_id` int NOT NULL,
  `country_id` int NOT NULL,
  `viewership` bigint DEFAULT NULL,
  PRIMARY KEY (`broadcaster_id`,`olympic_event_id`,`country_id`),
  KEY `olympic_event_id` (`olympic_event_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `broadcasted__ibfk_1` FOREIGN KEY (`broadcaster_id`) REFERENCES `broadcaster` (`broadcaster_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `broadcasted__ibfk_2` FOREIGN KEY (`olympic_event_id`) REFERENCES `olympic_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `broadcasted__ibfk_3` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `broadcasted_`
--

LOCK TABLES `broadcasted_` WRITE;
/*!40000 ALTER TABLE `broadcasted_` DISABLE KEYS */;
INSERT INTO `broadcasted_` VALUES (1,1,1,50000000),(2,1,2,3000000),(3,1,3,70000000),(4,2,4,4000000),(5,3,5,1500000),(6,3,6,20000000),(7,4,7,80000000),(8,5,8,900000),(9,1,9,12000000);
/*!40000 ALTER TABLE `broadcasted_` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `broadcaster`
--

DROP TABLE IF EXISTS `broadcaster`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `broadcaster` (
  `broadcaster_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `type` enum('TV','Radio','Online') NOT NULL,
  PRIMARY KEY (`broadcaster_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `broadcaster`
--

LOCK TABLES `broadcaster` WRITE;
/*!40000 ALTER TABLE `broadcaster` DISABLE KEYS */;
INSERT INTO `broadcaster` VALUES (1,'NBC','TV'),(2,'CBC','TV'),(3,'Tencent','Online'),(4,'NHK','TV'),(5,'ARD','Radio'),(6,'ESPN','Online'),(7,'Sky Sports','TV'),(8,'Fox Sports','Radio'),(9,'Al Jazeera','TV'),(10,'BBC','Radio'),(11,'Eurosport','Online'),(12,'Star Sports','TV');
/*!40000 ALTER TABLE `broadcaster` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `city` (
  `city_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `population` int DEFAULT NULL,
  `latitude` float DEFAULT NULL,
  `longitude` float DEFAULT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`city_id`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `city_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Los Angeles',3970000,34.0522,-118.244,1),(2,'New York',8419600,40.7128,-74.006,1),(3,'Toronto',2731571,43.6511,-79.3837,2),(4,'Tokyo',13929286,35.6895,139.692,4),(5,'Berlin',3644826,52.52,13.405,5),(6,'Sydney',5312163,-33.8688,151.209,6),(7,'Mumbai',20185064,19.076,72.8777,7),(8,'Moscow',12506468,55.7558,37.6173,8),(9,'Rio de Janeiro',6748000,-22.9068,-43.1729,9),(10,'Cape Town',433688,-33.9249,18.4241,10),(11,'Paris',2148327,48.8566,2.3522,11),(12,'Rome',2872800,41.9028,12.4964,12);
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  `continent` varchar(32) DEFAULT NULL,
  `population` bigint DEFAULT NULL,
  `olympic_code` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `olympic_code` (`olympic_code`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'USA','North America',331000000,'USA'),(2,'Canada','North America',38000000,'CAN'),(3,'China','Asia',1441000000,'CHN'),(4,'Japan','Asia',126000000,'JPN'),(5,'Germany','Europe',83000000,'GER'),(6,'Australia','Oceania',25000000,'AUS'),(7,'India','Asia',1391000000,'IND'),(8,'Russia','Europe',146000000,'RUS'),(9,'Brazil','South America',213000000,'BRA'),(10,'South Africa','Africa',59000000,'RSA'),(11,'France','Europe',67000000,'FRA'),(12,'Italy','Europe',60000000,'ITA');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medal`
--

DROP TABLE IF EXISTS `medal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medal` (
  `medal_id` int NOT NULL AUTO_INCREMENT,
  `type` enum('Gold','Silver','Bronze') NOT NULL,
  PRIMARY KEY (`medal_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medal`
--

LOCK TABLES `medal` WRITE;
/*!40000 ALTER TABLE `medal` DISABLE KEYS */;
INSERT INTO `medal` VALUES (1,'Gold'),(2,'Silver'),(3,'Bronze');
/*!40000 ALTER TABLE `medal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `olympic_event`
--

DROP TABLE IF EXISTS `olympic_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `olympic_event` (
  `event_id` int NOT NULL AUTO_INCREMENT,
  `event_name` varchar(64) NOT NULL,
  `event_year` year NOT NULL,
  `edition` varchar(32) DEFAULT NULL,
  `season` enum('Summer','Winter') NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `city_id` int NOT NULL,
  PRIMARY KEY (`event_id`),
  UNIQUE KEY `event_name` (`event_name`),
  KEY `city_id` (`city_id`),
  CONSTRAINT `olympic_event_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `olympic_event`
--

LOCK TABLES `olympic_event` WRITE;
/*!40000 ALTER TABLE `olympic_event` DISABLE KEYS */;
INSERT INTO `olympic_event` VALUES (1,'Summer Olympics 2020',2020,'XXXII','Summer','2021-07-23','2021-08-08',2),(2,'Winter Olympics 2022',2022,'XXIV','Winter','2022-02-04','2022-02-20',5),(3,'Summer Olympics 2016',2016,'XXXI','Summer','2016-08-05','2016-08-21',9),(4,'Summer Olympics 2008',2008,'XXIX','Summer','2008-08-08','2008-08-24',3),(5,'Winter Olympics 2018',2018,'XXIII','Winter','2018-02-09','2018-02-25',8);
/*!40000 ALTER TABLE `olympic_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `olympic_event_sport`
--

DROP TABLE IF EXISTS `olympic_event_sport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `olympic_event_sport` (
  `olympic_event_id` int NOT NULL,
  `sport_id` int NOT NULL,
  PRIMARY KEY (`olympic_event_id`,`sport_id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `olympic_event_sport_ibfk_1` FOREIGN KEY (`olympic_event_id`) REFERENCES `olympic_event` (`event_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `olympic_event_sport_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `olympic_event_sport`
--

LOCK TABLES `olympic_event_sport` WRITE;
/*!40000 ALTER TABLE `olympic_event_sport` DISABLE KEYS */;
INSERT INTO `olympic_event_sport` VALUES (1,1),(3,1),(1,2),(1,3),(3,3),(1,4),(3,4),(4,5),(2,6),(2,7),(5,11);
/*!40000 ALTER TABLE `olympic_event_sport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `record`
--

DROP TABLE IF EXISTS `record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `record` (
  `record_id` int NOT NULL AUTO_INCREMENT,
  `type` enum('WR','OR') NOT NULL,
  `value` varchar(64) NOT NULL,
  `date_achieved` date NOT NULL,
  `sport_id` int NOT NULL,
  PRIMARY KEY (`record_id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `record_ibfk_1` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `record`
--

LOCK TABLES `record` WRITE;
/*!40000 ALTER TABLE `record` DISABLE KEYS */;
INSERT INTO `record` VALUES (1,'WR','9.58s','2009-08-16',4),(2,'OR','19.19s','2012-08-12',4),(3,'WR','2:03:59','2019-09-29',11),(4,'WR','50.58s','2016-08-12',3),(5,'OR','3:29.65','2021-07-24',3),(6,'WR','10.49s','1988-07-16',4),(7,'OR','4:01.73','2017-06-30',11),(8,'WR','15:20.85','2020-09-10',3),(9,'OR','8.90m','1968-10-18',4),(10,'WR','49.38s','1984-08-06',3);
/*!40000 ALTER TABLE `record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sport`
--

DROP TABLE IF EXISTS `sport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sport` (
  `sport_id` int NOT NULL AUTO_INCREMENT,
  `sport_name` varchar(64) NOT NULL,
  `sport_type` enum('Team','Individual') NOT NULL,
  `category` varchar(32) NOT NULL,
  `environment` enum('Indoor','Outdoor') NOT NULL,
  `equipment_required` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`sport_id`),
  UNIQUE KEY `sport_name` (`sport_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sport`
--

LOCK TABLES `sport` WRITE;
/*!40000 ALTER TABLE `sport` DISABLE KEYS */;
INSERT INTO `sport` VALUES (1,'Basketball','Team','Ball Game','Indoor',1),(2,'Soccer','Team','Field Game','Outdoor',1),(3,'Swimming','Individual','Water Sport','Indoor',1),(4,'Athletics','Individual','Track & Field','Outdoor',0),(5,'Gymnastics','Individual','Artistic','Indoor',1),(6,'Hockey','Team','Field Game','Outdoor',1),(7,'Tennis','Individual','Racket Sport','Outdoor',1),(8,'Table Tennis','Individual','Racket Sport','Indoor',1),(9,'Badminton','Individual','Racket Sport','Indoor',1),(10,'Wrestling','Individual','Combat Sport','Indoor',0),(11,'Cycling','Individual','Endurance','Outdoor',1),(12,'Boxing','Individual','Combat Sport','Indoor',0);
/*!40000 ALTER TABLE `sport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team` (
  `team_id` int NOT NULL AUTO_INCREMENT,
  `team_name` varchar(32) NOT NULL,
  `coach_name` varchar(32) DEFAULT NULL,
  `no_of_players` int DEFAULT NULL,
  `establishment_year` int DEFAULT NULL,
  `country_id` int NOT NULL,
  `sport_id` int NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE KEY `team_name` (`team_name`),
  KEY `country_id` (`country_id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `team_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `team_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'Lakers','Frank Vogel',12,1946,1,1),(2,'Maple Leafs','Sheldon Keefe',22,1917,2,6),(3,'Blues','Michael Malone',11,1974,5,1),(4,'Samba Stars','Tite',23,1914,9,2),(5,'Tokyo United','Hajime Moriyasu',23,2000,4,2),(6,'Warriors','Steve Kerr',12,1946,1,1),(7,'Aussie Swimmers','Leigh Nugent',10,1988,6,3),(8,'Berlin Runners','Hans Meier',10,1975,5,4),(9,'Cape Blitz','John Trew',15,2001,10,6),(10,'Mumbai Smashers','Pullela Gopichand',12,2010,7,9),(11,'Paris Cyclists','Louis Blanc',8,1998,11,11),(12,'Rome Fighters','Marco Rossi',12,1985,12,12);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_ranking`
--

DROP TABLE IF EXISTS `team_ranking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_ranking` (
  `rank_id` int NOT NULL AUTO_INCREMENT,
  `world_rank` int NOT NULL,
  `points` int NOT NULL,
  `ranking_date` date NOT NULL,
  `federation` varchar(8) NOT NULL,
  `team_id` int DEFAULT NULL,
  `sport_id` int DEFAULT NULL,
  PRIMARY KEY (`rank_id`),
  KEY `team_id` (`team_id`),
  KEY `sport_id` (`sport_id`),
  CONSTRAINT `team_ranking_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_ranking_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_ranking`
--

LOCK TABLES `team_ranking` WRITE;
/*!40000 ALTER TABLE `team_ranking` DISABLE KEYS */;
INSERT INTO `team_ranking` VALUES (1,1,2500,'2021-12-01','FIBA',1,1),(2,2,2400,'2021-12-01','FIH',2,6),(3,3,2300,'2021-12-01','FINA',7,3),(4,4,2200,'2021-12-01','FIH',2,6),(5,5,2150,'2021-12-01','FIFA',4,2),(6,6,2100,'2021-12-01','UCI',9,11),(7,7,2050,'2021-12-01','FINA',8,3),(8,8,2000,'2021-12-01','IAAF',3,1),(9,9,1950,'2021-12-01','BWF',10,9);
/*!40000 ALTER TABLE `team_ranking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_win_history`
--

DROP TABLE IF EXISTS `team_win_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `team_win_history` (
  `team_id` int NOT NULL,
  `sport_id` int NOT NULL,
  `medal_id` int NOT NULL,
  `win_date` date NOT NULL,
  PRIMARY KEY (`team_id`,`sport_id`,`medal_id`,`win_date`),
  KEY `sport_id` (`sport_id`),
  KEY `medal_id` (`medal_id`),
  CONSTRAINT `team_win_history_ibfk_1` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_win_history_ibfk_2` FOREIGN KEY (`sport_id`) REFERENCES `sport` (`sport_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `team_win_history_ibfk_3` FOREIGN KEY (`medal_id`) REFERENCES `medal` (`medal_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_win_history`
--

LOCK TABLES `team_win_history` WRITE;
/*!40000 ALTER TABLE `team_win_history` DISABLE KEYS */;
INSERT INTO `team_win_history` VALUES (1,1,1,'2021-07-24'),(3,1,3,'2021-07-26'),(4,2,1,'2021-07-28'),(7,3,1,'2021-07-31'),(8,4,2,'2021-08-01'),(2,6,2,'2021-07-25'),(9,6,1,'2021-08-02'),(6,7,2,'2016-08-13'),(5,11,3,'2020-09-10');
/*!40000 ALTER TABLE `team_win_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `role` enum('USER','ADMIN') NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`),
  CONSTRAINT `password_length` CHECK ((length(`password`) >= 8))
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin_user','Admin@1234','ADMIN'),(2,'regular_user','User@1234','USER'),(3,'event_manager','Event@5678','ADMIN'),(4,'viewer1','Viewer#2021','USER'),(5,'sports_enthusiast','Sports123!','USER'),(6,'data_analyst','Data@7890','ADMIN'),(7,'player_view','Play@Pass22','USER'),(8,'team_admin','Team@1234','ADMIN'),(9,'broadcaster_user','Broadcast!21','USER'),(10,'moderator','Mod@4567','ADMIN');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'cs5200_project'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_athelete_ranking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_athelete_ranking`(
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8),
    p_athlete_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM athelete_ranking WHERE p_world_rank = world_rank AND
    p_points  = points AND
    p_ranking_date = ranking_date AND
    p_federation = federation AND
    p_athlete_id = athlete_id AND
    p_sport_id = sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rank record already exists.';
    ELSE
        INSERT INTO athelete_ranking (world_rank, points, ranking_date, federation, athlete_id, sport_id)
        VALUES (p_world_rank, p_points, p_ranking_date, p_federation, p_athlete_id, p_sport_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_athlete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_athlete`(
    p_first_name VARCHAR(32),
    p_last_name VARCHAR(32),
    p_date_of_birth DATE,
    p_gender ENUM('Male', 'Female', 'Other'),
    p_height FLOAT,
    p_weight FLOAT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athlete 
        WHERE first_name = p_first_name AND last_name = p_last_name AND date_of_birth = p_date_of_birth
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Athlete already exists.';
    ELSE
        INSERT INTO athlete (first_name, last_name, date_of_birth, gender, height, weight, country_id, sport_id)
        VALUES (p_first_name, p_last_name, p_date_of_birth, p_gender, p_height, p_weight, p_country_id, p_sport_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_athlete_win_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_athlete_win_record`(
    p_athlete_id INT,
    p_sport_id INT,
    p_medal_id INT,
    p_win_date DATE
)
BEGIN
    IF EXISTS (SELECT 1 FROM athlete_win_history WHERE athlete_id = p_athlete_id AND
    sport_id = p_sport_id AND 
    medal_id = p_medal_id AND
    win_date = p_win_date) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete wrecord already exists.';
    ELSE
        INSERT INTO athlete_win_history (athlete_id, sport_id, medal_id, win_date)
        VALUES (p_athlete_id, p_sport_id, p_medal_id, p_win_date);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_broadcaster_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_broadcaster_details`(
    p_name VARCHAR(64),
    p_BroadcastType ENUM('TV', 'Radio', 'Online')
)
BEGIN
	IF EXISTS (SELECT 1 FROM broadcaster WHERE name = p_name AND type = p_BroadcastType) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Broadcaster already exists.';
    ELSE
		INSERT INTO broadcaster (name, type)
		VALUES (p_name, p_BroadcastType);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_broadcast_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_broadcast_details`(
    p_broadcaster_id INT,
    p_EventID INT,
    p_CountryID INT,
    p_Viewership LONG
)
BEGIN
IF EXISTS (SELECT 1 FROM broadcasted_ WHERE broadcaster_id = p_broadcaster_id AND olympic_event_id = p_EventID AND country_id = p_CountryID) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Broadcast details exists.';
    ELSE
		INSERT INTO broadcasted_(broadcaster_id, olympic_event_id, country_id, viewership)
		VALUES (p_broadcaster_id, p_EventID, p_CountryID, p_Viewership);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_city`(
    p_name VARCHAR(64),
    p_population INT,
    p_latitude FLOAT,
    p_longitude FLOAT,
    p_country_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM city WHERE name = p_name AND country_id = p_country_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'City already exists.';
    ELSE
        INSERT INTO city (name, population, latitude, longitude, country_id)
        VALUES (p_name, p_population, p_latitude, p_longitude, p_country_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_country`(
    p_name VARCHAR(64),
    p_continent VARCHAR(32),
    p_population BIGINT,
    p_olympic_code VARCHAR(8)
)
BEGIN
    IF EXISTS (SELECT 1 FROM country WHERE name = p_name OR olympic_code = p_olympic_code) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Country already exists.';
    ELSE
        INSERT INTO country (name, continent, population, olympic_code)
        VALUES (p_name, p_continent, p_population, p_olympic_code);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_event`(
    p_EventName VARCHAR(64),
    p_Year INT,
    p_edition VARCHAR(32),
    p_Season ENUM('Summer', 'Winter'),
    p_StartDate DATE,
    p_EndDate DATE,
    p_HostCityID INT
)
BEGIN
	IF EXISTS (SELECT 1 FROM olympic_event WHERE event_name = p_EventName AND start_date = p_StartDate AND end_date = p_EndDate AND city_id = p_HostCityID) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Event already exists.';
    ELSE
		INSERT INTO olympic_event (event_name, event_year, edition, season, start_date, end_date, city_id)
		VALUES (p_EventName, p_Year, p_edition, p_Season, p_StartDate, p_EndDate, p_HostCityID);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_record`(
    p_type ENUM('WR', 'OR'),
    p_value VARCHAR(64),
    p_date_achieved DATE,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM record WHERE type = p_type AND
    value = p_value AND 
    date_achieved = p_date_achieved AND
    sport_id = p_sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Record already exists.';
    ELSE
        INSERT INTO record (type, value, date_achieved, sport_id)
        VALUES (p_type, p_value, p_date_achieved, p_sport_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_sport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_sport`(
    p_sport_name VARCHAR(64),
    p_sport_type ENUM('Team', 'Individual'),
    p_category VARCHAR(32),
    p_environment ENUM('Indoor', 'Outdoor'),
    p_equipment_required BOOLEAN
)
BEGIN
    IF EXISTS (SELECT 1 FROM sport WHERE sport_name = p_sport_name AND
    sport_type = p_sport_type AND
    category = p_category AND
    environment = p_environment AND
    equipment_required = p_equipment_required) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport already exists.';
    ELSE
        INSERT INTO sport (sport_name, sport_type, category, environment, equipment_required)
        VALUES (p_sport_name, p_sport_type, p_category, p_environment, p_equipment_required);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_sport_to_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_sport_to_event`(
    p_olympic_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM olympic_event_sport WHERE olympic_event_id = p_olympic_id AND sport_id = p_sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport already exists the event.';
    ELSE
        INSERT INTO olympic_event_sport (olympic_event_id, sport_id)
        VALUES (p_olympic_id, p_sport_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_team` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_team`(
    p_team_name VARCHAR(32),
    p_coach_name VARCHAR(32),
    p_no_of_players INT,
    p_establishment_year INT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM team WHERE team_name = p_team_name AND establishment_year = p_establishment_year AND country_id = p_country_id AND sport_id = p_sport_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Team already exists.';
    ELSE
        INSERT INTO team (team_name, coach_name, no_of_players, establishment_year, country_id, sport_id)
        VALUES (p_team_name, p_coach_name, p_no_of_players, p_establishment_year, p_country_id, p_sport_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_team_ranking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_team_ranking`(
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8),
    p_team_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (SELECT 1 FROM team_ranking WHERE p_world_rank = world_rank AND
    p_points  = points AND
    p_ranking_date = ranking_date AND
    p_federation = federation AND
    p_team_id = team_id AND
    p_sport_id = sport_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Rank record already exists.';
    ELSE
        INSERT INTO team_ranking (world_rank, points, ranking_date, federation, team_id, sport_id)
        VALUES (p_world_rank, p_points, p_ranking_date, p_federation, p_team_id, p_sport_id);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_team_win_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_team_win_record`(
    p_team_id INT,
    p_sport_id INT,
    p_medal_id INT,
    p_win_date DATE
)
BEGIN
    IF EXISTS (SELECT 1 FROM team_win_history WHERE team_id = p_team_id AND
    sport_id = p_sport_id AND 
    medal_id = p_medal_id AND
    win_date = p_win_date) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team wrecord already exists.';
    ELSE
        INSERT INTO team_win_history (team_id, sport_id, medal_id, win_date)
        VALUES (p_team_id, p_sport_id, p_medal_id, p_win_date);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_user`(
    p_username VARCHAR(32),
    p_password VARCHAR(32),
	p_role ENUM('USER', 'ADMIN')
)
BEGIN
    IF EXISTS (SELECT 1 FROM users WHERE username = p_username AND
    password = p_password AND 
    role = p_role) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User already exists.';
    ELSE
        INSERT INTO users (username, password, role)
        VALUES (p_username, p_password, p_role);
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `authenticate_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `authenticate_user`(
    IN p_username VARCHAR(32), 
    IN p_password VARCHAR(32), 
    OUT user_role VARCHAR(10) 
)
BEGIN    
    SELECT role
    INTO user_role
    FROM users
    WHERE username = p_username AND password = p_password
    LIMIT 1;

    IF user_role IS NULL THEN
        SET user_role = NULL;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_athlete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_athlete`(p_athlete_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athlete WHERE athlete_id = p_athlete_id
    ) THEN
        DELETE FROM athlete
        WHERE athlete_id = p_athlete_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_broadcaster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_broadcaster`(p_broadcaster_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM broadcaster WHERE broadcaster_id = p_broadcaster_id
    ) THEN
        DELETE FROM broadcaster
        WHERE broadcaster_id = p_broadcaster_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Broadcaster does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_city`(p_city_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM city WHERE city_id = p_city_id
    ) THEN
        DELETE FROM city
        WHERE city_id = p_city_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'City does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_country`(p_country_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM country WHERE country_id = p_country_id
    ) THEN
        DELETE FROM country
        WHERE country_id = p_country_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Country does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_olympic_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_olympic_event`(p_event_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM olympic_event WHERE event_id = p_event_id
    ) THEN
        DELETE FROM olympic_event
        WHERE event_id = p_event_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Olympic event does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_olympic_sport_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_olympic_sport_event`(p_olympic_event_id INT, p_sport_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM olympic_event_sport 
        WHERE olympic_event_id = p_olympic_event_id AND sport_id = p_sport_id
    ) THEN
        DELETE FROM olympic_event_sport
        WHERE olympic_event_id = p_olympic_event_id AND sport_id = p_sport_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Olympic event sport combination does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_record`(p_record_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM record WHERE record_id = p_record_id
    ) THEN
        DELETE FROM record
        WHERE record_id = p_record_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Record does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_sport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_sport`(p_sport_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM sport WHERE sport_id = p_sport_id
    ) THEN
        DELETE FROM sport
        WHERE sport_id = p_sport_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_team` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_team`(p_team_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM team WHERE team_id = p_team_id
    ) THEN
        DELETE FROM team
        WHERE team_id = p_team_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(p_user_id INT)
BEGIN
    IF EXISTS (
        SELECT 1 FROM users WHERE user_id = p_user_id
    ) THEN
        DELETE FROM users
        WHERE user_id = p_user_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_athletes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_athletes`()
BEGIN
    SELECT 
        a.athlete_id,
        a.first_name,
        a.last_name,
        a.date_of_birth,
        a.gender,
        a.height,
        a.weight,
        c.name AS country_name,
        c.olympic_code AS country_code,
        s.sport_name
    FROM 
        athlete AS a
    INNER JOIN
        country AS c ON a.country_id = c.country_id
    INNER JOIN
        sport AS s ON a.sport_id = s.sport_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_athletes_by_sports` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_athletes_by_sports`(p_sport_id INT)
BEGIN
    SELECT 
        a.athlete_id,
        a.first_name,
        a.last_name,
        a.date_of_birth,
        a.gender,
        a.height,
        a.weight,
        c.name AS country_name,
        s.sport_name
    FROM 
        athlete AS a
    INNER JOIN
        country AS c ON a.country_id = c.country_id
    INNER JOIN
        sport AS s ON a.sport_id = s.sport_id
    WHERE 
        a.sport_id = p_sport_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_athletes_ranking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_athletes_ranking`()
BEGIN
    SELECT 
        ar.rank_id,
        ar.world_rank,
        ar.points,
        ar.ranking_date,
        ar.federation,
        ar.athlete_id,
        CONCAT(a.first_name, ' ', a.last_name) AS athlete_name,
        ar.sport_id,
        s.sport_name
    FROM 
        athelete_ranking AS ar
    INNER JOIN
        athlete AS a ON ar.athlete_id = a.athlete_id
    INNER JOIN
        sport AS s ON ar.sport_id = s.sport_id
    ORDER BY 
        ar.world_rank;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_athlete_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_athlete_details`(p_athlete_id INT)
BEGIN
    SELECT 
        a.athlete_id,
        a.first_name,
        a.last_name,
        a.date_of_birth,
        a.gender,
        a.height,
        a.weight,
        c.name AS country_name,
        s.sport_name
    FROM 
        athlete AS a
    INNER JOIN
        country AS c ON a.country_id = c.country_id
    INNER JOIN
        sport AS s ON a.sport_id = s.sport_id
    WHERE 
        a.athlete_id = p_athlete_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_athlete_win_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_athlete_win_history`()
BEGIN
    SELECT 
        awh.athlete_id,
        CONCAT(a.first_name, ' ', a.last_name) AS athlete_name,
        awh.sport_id,
        s.sport_name,
        awh.medal_id,
        m.type AS medal_type,
        awh.win_date
    FROM 
        athlete_win_history AS awh
    INNER JOIN
        athlete AS a ON awh.athlete_id = a.athlete_id
    INNER JOIN
        sport AS s ON awh.sport_id = s.sport_id
    INNER JOIN
        medal AS m ON awh.medal_id = m.medal_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_broadcasters` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_broadcasters`()
BEGIN
    SELECT * FROM broadcaster;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_broadcast_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_broadcast_details`()
BEGIN
    SELECT 
        bi.broadcaster_id,
        br.name AS broadcaster_name,
        bi.olympic_event_id,
        oe.event_name AS olympic_event_name,
        bi.country_id,
        c.name AS country_name,
        bi.viewership
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_broadcast_details_by_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_broadcast_details_by_event`(p_event_id INT)
BEGIN
    SELECT 
        bi.broadcaster_id,
        br.name AS broadcaster_name,
        bi.olympic_event_id,
        oe.event_name AS olympic_event_name,
        bi.country_id,
        c.name AS country_name,
        bi.viewership
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id
    WHERE 
        bi.olympic_event_id = p_event_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_broadcast_details_by_year` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_broadcast_details_by_year`(p_year INT)
BEGIN
    SELECT 
        bi.broadcaster_id,
        br.name AS broadcaster_name,
        bi.olympic_event_id,
        oe.event_name AS olympic_event_name,
        oe.event_year AS event_year,
        bi.country_id,
        c.name AS country_name,
        bi.viewership
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id
    WHERE 
        oe.event_year = p_year;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_cities` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_cities`()
BEGIN
    SELECT 
        c.city_id,
        c.name AS city_name,
        c.population AS city_population,
        c.latitude,
        c.longitude,
        co.name AS country_name
    FROM 
        city AS c
    INNER JOIN
        country AS co ON c.country_id = co.country_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_countries` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_countries`()
BEGIN
    SELECT * FROM country;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_events_by_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_events_by_country`(p_country_id INT)
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        c.name AS city_name,
        co.name AS country_name
    FROM 
        olympic_event AS e
    INNER JOIN
        city AS c ON e.city_id = c.city_id
    INNER JOIN
        country AS co ON c.country_id = co.country_id
    WHERE 
        co.country_id = p_country_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_events_by_sports` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_events_by_sports`(p_sport_id INT)
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        s.sport_name,
        c.name AS city_name
    FROM 
        olympic_event AS e
    INNER JOIN
        olympic_event_sport AS oes ON e.event_id = oes.olympic_event_id
    INNER JOIN
        sport AS s ON oes.sport_id = s.sport_id
    INNER JOIN
        city AS c ON e.city_id = c.city_id
    WHERE 
        s.sport_id = p_sport_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_events_by_year` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_events_by_year`(p_year INT)
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        c.name AS city_name,
        co.name AS country_name
    FROM 
        olympic_event AS e
    INNER JOIN
        city AS c ON e.city_id = c.city_id
    INNER JOIN
        country AS co ON c.country_id = co.country_id
    WHERE 
        e.event_year = p_year;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_event_with_highest_broadcast_viewership` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_event_with_highest_broadcast_viewership`()
BEGIN
    SELECT 
        oe.event_id,
        oe.event_name,
        SUM(bi.viewership) AS total_viewership,
        br.name AS broadcaster_name,
        c.name AS country_name
    FROM 
        broadcasted_ AS bi
    INNER JOIN
        olympic_event AS oe ON bi.olympic_event_id = oe.event_id
    INNER JOIN
        broadcaster AS br ON bi.broadcaster_id = br.broadcaster_id
    INNER JOIN
        country AS c ON bi.country_id = c.country_id
    GROUP BY 
        oe.event_id, br.name, c.name
    ORDER BY 
        total_viewership DESC
    LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_medals` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_medals`()
BEGIN
    SELECT * FROM medal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_medals_won_by_country_in_indoor_sports` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_medals_won_by_country_in_indoor_sports`()
BEGIN
    SELECT 
        c.name AS country_name,
        m.type AS medal_type,
        COUNT(*) AS total_medals
    FROM (
        SELECT 
            a.country_id,
            awh.medal_id,
            s.environment
        FROM 
            athlete_win_history AS awh
        INNER JOIN
            athlete AS a ON awh.athlete_id = a.athlete_id
        INNER JOIN
            sport AS s ON awh.sport_id = s.sport_id
        UNION ALL
        SELECT 
            t.country_id,
            twh.medal_id,
            s.environment
        FROM 
            team_win_history AS twh
        INNER JOIN
            team AS t ON twh.team_id = t.team_id
        INNER JOIN
            sport AS s ON twh.sport_id = s.sport_id
    ) AS all_wins
    INNER JOIN
        country AS c ON all_wins.country_id = c.country_id
    INNER JOIN
        medal AS m ON all_wins.medal_id = m.medal_id
    WHERE 
        all_wins.environment = 'Indoor'
    GROUP BY 
        c.country_id, m.type
    ORDER BY 
        total_medals DESC, m.type;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_medals_won_by_country_in_outdoor_sports` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_medals_won_by_country_in_outdoor_sports`()
BEGIN
    SELECT 
        c.name AS country_name,
        m.type AS medal_type,
        COUNT(*) AS total_medals
    FROM (
        SELECT 
            a.country_id,
            awh.medal_id,
            s.environment
        FROM 
            athlete_win_history AS awh
        INNER JOIN
            athlete AS a ON awh.athlete_id = a.athlete_id
        INNER JOIN
            sport AS s ON awh.sport_id = s.sport_id
        UNION ALL
        SELECT 
            t.country_id,
            twh.medal_id,
            s.environment
        FROM 
            team_win_history AS twh
        INNER JOIN
            team AS t ON twh.team_id = t.team_id
        INNER JOIN
            sport AS s ON twh.sport_id = s.sport_id
    ) AS all_wins
    INNER JOIN
        country AS c ON all_wins.country_id = c.country_id
    INNER JOIN
        medal AS m ON all_wins.medal_id = m.medal_id
    WHERE 
        all_wins.environment = 'Outdoor'
    GROUP BY 
        c.country_id, m.type
    ORDER BY 
        total_medals DESC, m.type;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_most_medal_winning_countries_by_year` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_most_medal_winning_countries_by_year`(p_year INT)
BEGIN
    SELECT 
        c.name AS country_name,
        m.type AS medal_type,
        COUNT(*) AS total_medals
    FROM (
        -- Combine athlete and team wins
        SELECT 
            a.country_id,
            awh.medal_id
        FROM 
            athlete_win_history AS awh
        INNER JOIN
            athlete AS a ON awh.athlete_id = a.athlete_id
            
        UNION ALL

        SELECT 
            t.country_id,
            twh.medal_id
        FROM 
            team_win_history AS twh
        INNER JOIN
            team AS t ON twh.team_id = t.team_id
    ) AS all_wins
    INNER JOIN
        country AS c ON all_wins.country_id = c.country_id
    INNER JOIN
        medal AS m ON all_wins.medal_id = m.medal_id
    INNER JOIN
        olympic_event AS oe ON oe.event_year = p_year
    WHERE 
        oe.event_year = p_year
    GROUP BY 
        c.country_id, m.type
    ORDER BY 
        total_medals DESC, m.type;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_no_of_sports_participated_by_a_country_per_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_no_of_sports_participated_by_a_country_per_event`(p_country_id INT)
BEGIN
    SELECT 
        c.name AS country_name,
        oe.event_name AS olympic_event_name,
        oe.event_year AS event_year,
        COUNT(DISTINCT all_participation.sport_id) AS total_sports
    FROM (
		SELECT 
            a.country_id,
            a.sport_id,
            oes.olympic_event_id
        FROM 
            athlete AS a
        INNER JOIN
            olympic_event_sport AS oes ON a.sport_id = oes.sport_id
        UNION ALL
        SELECT 
            t.country_id,
            t.sport_id,
            oes.olympic_event_id
        FROM 
            team AS t
        INNER JOIN
            olympic_event_sport AS oes ON t.sport_id = oes.sport_id
    ) AS all_participation
    INNER JOIN
        olympic_event AS oe ON all_participation.olympic_event_id = oe.event_id
    INNER JOIN
        country AS c ON all_participation.country_id = c.country_id
    WHERE 
        c.country_id = p_country_id
    GROUP BY 
        c.country_id, oe.event_id
    ORDER BY 
        oe.event_year;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_olympic_events` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_olympic_events`()
BEGIN
    SELECT 
        e.event_id,
        e.event_name,
        e.event_year,
        e.edition,
        e.season,
        e.start_date,
        e.end_date,
        c.name AS city_name
    FROM 
        olympic_event AS e
    INNER JOIN
        city AS c ON e.city_id = c.city_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_sports` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sports`()
BEGIN
    SELECT * FROM sport;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_sports_in_olympic_events` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sports_in_olympic_events`(p_event_id INT)
BEGIN
    SELECT 
        oes.olympic_event_id,
        oe.event_name,
        s.sport_name
    FROM 
        olympic_event_sport AS oes
    INNER JOIN
        olympic_event AS oe ON oes.olympic_event_id = oe.event_id
    INNER JOIN
        sport AS s ON oes.sport_id = s.sport_id
	WHERE oe.event_id = p_event_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_sport_records` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sport_records`(p_sport_id INT)
BEGIN
    SELECT 
        r.record_id,
        r.type AS record_type,
        r.value AS record_value,
        r.date_achieved,
        s.sport_name
    FROM 
        record AS r
    INNER JOIN
        sport AS s ON r.sport_id = s.sport_id
	WHERE s.sport_id = p_sport_id;        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_teams` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_teams`()
BEGIN
    SELECT 
        t.team_id,
        t.team_name,
        t.coach_name,
        t.no_of_players,
        t.establishment_year,
        c.name AS country_name,
        s.sport_name
    FROM 
        team AS t
    INNER JOIN
        country AS c ON t.country_id = c.country_id
    INNER JOIN
        sport AS s ON t.sport_id = s.sport_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_teams_by_sports` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_teams_by_sports`(p_sport_id INT)
BEGIN
    SELECT 
        t.team_id,
        t.team_name,
        t.coach_name,
        t.no_of_players,
        t.establishment_year,
        c.name AS country_name,
        s.sport_name
    FROM 
        team AS t
    INNER JOIN
        country AS c ON t.country_id = c.country_id
    INNER JOIN
        sport AS s ON t.sport_id = s.sport_id
    WHERE 
        t.sport_id = p_sport_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_teams_ranking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_teams_ranking`()
BEGIN
    SELECT 
        tr.rank_id,
        tr.world_rank,
        tr.points,
        tr.ranking_date,
        tr.federation,
        tr.team_id,
        t.team_name,
        tr.sport_id,
        s.sport_name
    FROM 
        team_ranking AS tr
    INNER JOIN
        team AS t ON tr.team_id = t.team_id
    INNER JOIN
        sport AS s ON tr.sport_id = s.sport_id
    ORDER BY 
        tr.world_rank;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_team_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_team_details`(p_team_id INT)
BEGIN
    SELECT 
        t.team_id,
        t.team_name,
        t.coach_name,
        t.no_of_players,
        t.establishment_year,
        c.name AS country_name,
        s.sport_name
    FROM 
        team AS t
    INNER JOIN
        country AS c ON t.country_id = c.country_id
    INNER JOIN
        sport AS s ON t.sport_id = s.sport_id
    WHERE 
        t.team_id = p_team_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_team_win_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_team_win_history`()
BEGIN
    SELECT 
        twh.team_id,
        t.team_name,
        twh.sport_id,
        s.sport_name,
        twh.medal_id,
        m.type AS medal_type,
        twh.win_date
    FROM 
        team_win_history AS twh
    INNER JOIN
        team AS t ON twh.team_id = t.team_id
    INNER JOIN
        sport AS s ON twh.sport_id = s.sport_id
    INNER JOIN
        medal AS m ON twh.medal_id = m.medal_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_users` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users`()
BEGIN
    SELECT * FROM users;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_athlete` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_athlete`(
    p_athlete_id INT,
    p_first_name VARCHAR(32),
    p_last_name VARCHAR(32),
    p_date_of_birth DATE,
    p_gender ENUM('Male', 'Female', 'Other'),
    p_height FLOAT,
    p_weight FLOAT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athlete WHERE athlete_id = p_athlete_id
    ) THEN
        UPDATE athlete
        SET 
            first_name = p_first_name,
            last_name = p_last_name,
            date_of_birth = p_date_of_birth,
            gender = p_gender,
            height = p_height,
            weight = p_weight,
            country_id = p_country_id,
            sport_id = p_sport_id
        WHERE 
            athlete_id = p_athlete_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_athlete_ranking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_athlete_ranking`(
    p_rank_id INT,
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8)
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM athelete_ranking WHERE rank_id = p_rank_id
    ) THEN
        UPDATE athelete_ranking
        SET 
            world_rank = p_world_rank,
            points = p_points,
            ranking_date = p_ranking_date,
            federation = p_federation
        WHERE 
            rank_id = p_rank_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Athlete ranking does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_city` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_city`(
    p_city_id INT,
    p_name VARCHAR(64),
    p_population INT,
    p_latitude FLOAT,
    p_longitude FLOAT,
    p_country_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM city WHERE city_id = p_city_id
    ) THEN
        UPDATE city
        SET 
            name = p_name,
            population = p_population,
            latitude = p_latitude,
            longitude = p_longitude,
            country_id = p_country_id
        WHERE 
            city_id = p_city_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'City does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_country` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_country`(
    p_country_id INT,
    p_name VARCHAR(64),
    p_continent VARCHAR(32),
    p_population BIGINT,
    p_olympic_code VARCHAR(8)
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM country WHERE country_id = p_country_id
    ) THEN
        UPDATE country
        SET 
            name = p_name,
            continent = p_continent,
            population = p_population,
            olympic_code = p_olympic_code
        WHERE 
            country_id = p_country_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Country does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_olympic_event` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_olympic_event`(
    p_event_id INT,
    p_event_name VARCHAR(64),
    p_year YEAR,
    p_edition VARCHAR(32),
    p_season ENUM('Summer', 'Winter'),
    p_start_date DATE,
    p_end_date DATE,
    p_city_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM olympic_event WHERE event_id = p_event_id
    ) THEN
        UPDATE olympic_event
        SET 
            event_name = p_event_name,
            event_year = p_year,
            edition = p_edition,
            season = p_season,
            start_date = p_start_date,
            end_date = p_end_date,
            city_id = p_city_id
        WHERE 
            event_id = p_event_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Olympic event does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_sport` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_sport`(
    p_sport_id INT,
    p_sport_name VARCHAR(64),
    p_sport_type ENUM('Team', 'Individual'),
    p_category VARCHAR(32),
    p_environment ENUM('Indoor', 'Outdoor'),
    p_equipment_required BOOLEAN
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM sport WHERE sport_id = p_sport_id
    ) THEN
        UPDATE sport
        SET 
            sport_name = p_sport_name,
            sport_type = p_sport_type,
            category = p_category,
            environment = p_environment,
            equipment_required = p_equipment_required
        WHERE 
            sport_id = p_sport_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Sport does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_sport_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_sport_record`(
    p_record_id INT,
    p_type ENUM('WR', 'OR'),
    p_value VARCHAR(64),
    p_date_achieved DATE,
    p_sport_id INT
)
BEGIN
    -- Check if the record exists
    IF EXISTS (
        SELECT 1 FROM record WHERE record_id = p_record_id
    ) THEN
        -- Perform the update if the record exists
        UPDATE record
        SET 
            type = p_type,
            value = p_value,
            date_achieved = p_date_achieved,
            sport_id = p_sport_id
        WHERE 
            record_id = p_record_id;
    ELSE
        -- Signal an error if the record does not exist
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Record does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_team` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_team`(
    p_team_id INT,
    p_team_name VARCHAR(32),
    p_coach_name VARCHAR(32),
    p_no_of_players INT,
    p_establishment_year INT,
    p_country_id INT,
    p_sport_id INT
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM team WHERE team_id = p_team_id
    ) THEN
        UPDATE team
        SET 
            team_name = p_team_name,
            coach_name = p_coach_name,
            no_of_players = p_no_of_players,
            establishment_year = p_establishment_year,
            country_id = p_country_id,
            sport_id = p_sport_id
        WHERE 
            team_id = p_team_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_team_ranking` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_team_ranking`(
    p_rank_id INT,
    p_world_rank INT,
    p_points INT,
    p_ranking_date DATE,
    p_federation VARCHAR(8)
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM team_ranking WHERE rank_id = p_rank_id
    ) THEN
        UPDATE team_ranking
        SET 
            world_rank = p_world_rank,
            points = p_points,
            ranking_date = p_ranking_date,
            federation = p_federation
        WHERE 
            rank_id = p_rank_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Team ranking does not exist.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-06  0:00:33
