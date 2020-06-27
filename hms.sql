/*
SQLyog Professional v13.1.1 (64 bit)
MySQL - 8.0.11 : Database - hms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `hms`;

/*Table structure for table `diagnostic` */

DROP TABLE IF EXISTS `diagnostic`;

CREATE TABLE `diagnostic` (
  `did` decimal(9,0) NOT NULL,
  `name` varchar(50) NOT NULL,
  `rate` decimal(9,0) NOT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `diagnostic` */

/*Table structure for table `medicine` */

DROP TABLE IF EXISTS `medicine`;

CREATE TABLE `medicine` (
  `mid` decimal(9,0) NOT NULL,
  `name` varchar(50) NOT NULL,
  `qty` decimal(9,0) NOT NULL,
  `rate` decimal(9,0) NOT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `medicine` */

/*Table structure for table `patient` */

DROP TABLE IF EXISTS `patient`;

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

/*Data for the table `patient` */

/*Table structure for table `patient_diagnostic` */

DROP TABLE IF EXISTS `patient_diagnostic`;

CREATE TABLE `patient_diagnostic` (
  `pid` decimal(9,0) NOT NULL,
  `did` decimal(9,0) NOT NULL,
  KEY `Patient Ids` (`pid`),
  KEY `Diagnostic Ids` (`did`),
  CONSTRAINT `Diagnostic Ids` FOREIGN KEY (`did`) REFERENCES `diagnostic` (`did`) ON UPDATE CASCADE,
  CONSTRAINT `Patient Ids` FOREIGN KEY (`pid`) REFERENCES `patient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `patient_diagnostic` */

/*Table structure for table `patient_medicine` */

DROP TABLE IF EXISTS `patient_medicine`;

CREATE TABLE `patient_medicine` (
  `pid` decimal(9,0) NOT NULL,
  `mid` decimal(9,0) NOT NULL,
  `qty` decimal(9,0) NOT NULL,
  KEY `Patient Id` (`pid`),
  KEY `Medicine Id` (`mid`),
  CONSTRAINT `Medicine Id` FOREIGN KEY (`mid`) REFERENCES `medicine` (`mid`) ON UPDATE CASCADE,
  CONSTRAINT `Patient Id` FOREIGN KEY (`pid`) REFERENCES `patient` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `patient_medicine` */

/*Table structure for table `userstore` */

DROP TABLE IF EXISTS `userstore`;

CREATE TABLE `userstore` (
  `Username` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `Timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Role` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `userstore` */

insert  into `userstore`(`Username`,`Password`,`Timestamp`,`Role`) values 
('admission','Admission@123','2020-06-27 15:48:51','A'),
('pharmacist','Pharmacist@123','2020-06-27 15:49:51','P'),
('diagnostic','Diagnostic@123','2020-06-27 15:50:21','D');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
