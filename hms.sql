CREATE DATABASE  IF NOT EXISTS `hms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hms`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: hms
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `diagnostic`
--

DROP TABLE IF EXISTS `diagnostic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diagnostic` (
  `did` decimal(9,0) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rate` decimal(9,0) NOT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diagnostic`
--

LOCK TABLES `diagnostic` WRITE;
/*!40000 ALTER TABLE `diagnostic` DISABLE KEYS */;
INSERT INTO `diagnostic` VALUES (1,'X-Ray',1000),(2,'CT Scanning',5000),(3,'MRI',8000),(4,'Genetic Testing',3500),(5,'Liver Function Test',1500),(6,'Skin Test',1200),(7,'Brain Scanning',3200),(8,'Cardiac Magnetic Resonence Imaging',1250),(9,'Tomography',4200),(10,'Ultrasound',3750),(11,'Endoscopy',1500),(12,'Bronchoscopy',1100),(13,'Gynecological Examination',1456),(14,'Palpation',1200),(15,'Semen Analysis',4000);
/*!40000 ALTER TABLE `diagnostic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicine`
--

DROP TABLE IF EXISTS `medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medicine` (
  `mid` decimal(9,0) NOT NULL,
  `name` varchar(50) NOT NULL,
  `qty` decimal(9,0) NOT NULL,
  `rate` decimal(9,0) NOT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicine`
--

LOCK TABLES `medicine` WRITE;
/*!40000 ALTER TABLE `medicine` DISABLE KEYS */;
INSERT INTO `medicine` VALUES (1,'paracetmol',90,20),(2,'Digene',78,19),(3,'Vicks Action 500',137,33),(4,'Nice',172,36),(5,'Lirica',54,128),(6,'Naproxen',110,178),(7,'Ciprofloxacin',171,168),(8,'Benzonatate',82,42),(9,'Januvia',43,20),(10,'Kevzara',28,16),(11,'Amlodipine',72,67),(12,'Otrivin',6,53),(13,'Cyclopham',30,18),(14,'Gelinya',83,72),(15,'Doxycycline',23,173);
/*!40000 ALTER TABLE `medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `ssn_id` decimal(9,0) NOT NULL,
  `id` decimal(9,0) NOT NULL,
  `name` varchar(50) NOT NULL,
  `age` decimal(3,0) NOT NULL,
  `doj` date DEFAULT NULL,
  `bed` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (10000,100000000,'Prem',17,'2020-06-29','Single Room','3-41,PUSAM,L.N.PETA,SRIKAKULAM','Hyderabad','Andhra Pradesh','active'),(10001,100000001,'kumar',22,'2020-06-24','Semi Sharing','7-60 ,SETTIBALIJI PETA','Vijayawada','Telangana','DISCHARGED'),(10002,100000002,'suresh',12,'2020-07-09','Semi Sharing','MAIN ROAD, PUSAM','Hyderabad','Andhra Pradesh','active'),(10003,100000003,'Rajeswari',17,'2020-07-08','Semi Sharing','MAIN ROAD, PUSAM','Visakhapatnam','Andhra Pradesh','active'),(10004,100000004,'Dinesh',19,'2020-07-14','Semi Sharing','3-41,PUSAM,L.N.PETA,SRIKAKULAM','Hyderabad','Andhra Pradesh','DISCHARGED'),(10005,100000005,'ramesh',32,'2020-07-15','Single Room','7-60 ,SETTIBALIJI PETA','Vijayawada','Andhra Pradesh','active'),(10006,100000006,'joseph',11,'2020-07-16','Semi Sharing','MAIN ROAD, PUSAM','Visakhapatnam','Andhra Pradesh','active'),(10007,100000007,'Mouli',21,'2020-07-08','Semi Sharing','7-60 ,SETTIBALIJI PETA','Bhubaneswar','Odisa','DISCHARGED'),(10008,100000008,'Roja',43,'2020-07-03','Single Room','MAIN ROAD, PUSAM','Visakhapatnam','Andhra Pradesh','DISCHARGED'),(10009,100000009,'Latha',40,'2020-07-03','Semi Sharing','7-60 ,SETTIBALIJI PETA','Vijayawada','Andhra Pradesh','DISCHARGED'),(10010,100000010,'Deepak',23,'2020-02-12','Single Room','7-60 ,SETTIBALIJI PETA','Hyderabad','Andhra Pradesh','active'),(10011,100000011,'Raju',32,'2020-07-04','Single Room','MAIN ROAD, PUSAM','Vijayawada','Andhra Pradesh','DISCHARGED'),(10012,100000012,'Vasu Dev',32,'2020-02-10','General Ward','7-60 ,SETTIBALIJI PETA','Vijayawada','Andhra Pradesh','active'),(10013,100000013,'Balaji',43,'2020-02-18','General Ward','3-41,PUSAM,L.N.PETA,SRIKAKULAM','Warangal','Andhra Pradesh','active'),(10014,100000014,'Ramesh',65,'2020-07-27','Semi Sharing','3-13, Sai ram nagar.\r\n','Bhubaneswar','Odisa','active'),(10015,100000015,'Ajith',61,'2020-02-06','General Ward','1-76,G.T.road','Warangal','Telangana','active'),(10016,100000016,'Yogesh',54,'2020-07-28','Single Room','8-21, Jaggayapeta','Vijayawada','Andhra Pradesh','DISCHARGED'),(10017,100000017,'Yeswanth',76,'2020-07-31','Semi Sharing','7-60 ,SETTIBALIJI PETA','Warangal','Telangana','active'),(10018,100000018,'Prasad',65,'2020-03-07','Single Room','6-21, Nayudupeta\r\n','Bhubaneswar','Odisa','active'),(10019,100000019,'Usha',54,'2020-07-03','Semi Sharing','3-12, S.kota','Visakhapatnam','Andhra Pradesh','DISCHARGED'),(10020,100000020,'Sowmya',42,'2020-07-03','Semi Sharing','2-19, Jagadhamba','Visakhapatnam','Andhra Pradesh','active'),(10021,100000021,'Spandana',61,'2020-07-01','General Ward','7-60 ,SETTIBALIJI PETA','Vijayawada','Andhra Pradesh','DISCHARGED'),(10022,100000022,'Babji',46,'2020-07-03','General Ward','1-24, Hiramandalam','Visakhapatnam','Andhra Pradesh','active');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_diagnostic`
--

DROP TABLE IF EXISTS `patient_diagnostic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_diagnostic` (
  `pid` decimal(9,0) NOT NULL,
  `did` decimal(9,0) NOT NULL,
  KEY `Patient Ids` (`pid`),
  KEY `Diagnostic Ids` (`did`),
  CONSTRAINT `Diagnostic Ids` FOREIGN KEY (`did`) REFERENCES `diagnostic` (`did`) ON UPDATE CASCADE,
  CONSTRAINT `Patient Ids` FOREIGN KEY (`pid`) REFERENCES `patient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_diagnostic`
--

LOCK TABLES `patient_diagnostic` WRITE;
/*!40000 ALTER TABLE `patient_diagnostic` DISABLE KEYS */;
INSERT INTO `patient_diagnostic` VALUES (100000002,1),(100000002,2),(100000001,1),(100000001,1),(100000001,1),(100000002,1),(100000000,2),(100000002,5),(100000002,9);
/*!40000 ALTER TABLE `patient_diagnostic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_medicine`
--

DROP TABLE IF EXISTS `patient_medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient_medicine` (
  `pid` decimal(9,0) NOT NULL,
  `mid` decimal(9,0) NOT NULL,
  `qty` decimal(9,0) NOT NULL,
  KEY `Patient Id` (`pid`),
  KEY `Medicine Id` (`mid`),
  CONSTRAINT `Medicine Id` FOREIGN KEY (`mid`) REFERENCES `medicine` (`mid`) ON UPDATE CASCADE,
  CONSTRAINT `Patient Id` FOREIGN KEY (`pid`) REFERENCES `patient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_medicine`
--

LOCK TABLES `patient_medicine` WRITE;
/*!40000 ALTER TABLE `patient_medicine` DISABLE KEYS */;
INSERT INTO `patient_medicine` VALUES (100000001,1,4),(100000002,12,4),(100000002,7,6),(100000000,13,4),(100000000,11,4),(100000002,8,4),(100000002,3,4),(100000009,1,10),(100000011,3,12),(100000011,15,12),(100000013,3,8),(100000002,12,7);
/*!40000 ALTER TABLE `patient_medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userstore`
--

DROP TABLE IF EXISTS `userstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userstore` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Role` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userstore`
--

LOCK TABLES `userstore` WRITE;
/*!40000 ALTER TABLE `userstore` DISABLE KEYS */;
INSERT INTO `userstore` VALUES ('admission','Admission@123','2020-06-27 15:48:51','A'),('pharmacist','Pharmacist@123','2020-06-27 15:49:51','P'),('diagnostic','Diagnostic@123','2020-06-27 15:50:21','D');
/*!40000 ALTER TABLE `userstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hms'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-07-03 20:16:50
