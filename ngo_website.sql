-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: ngo_website
-- ------------------------------------------------------
-- Server version	8.0.32

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
-- Table structure for table `blog`
--

DROP TABLE IF EXISTS `blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Title` varchar(45) DEFAULT NULL,
  `Script` text,
  `Image` blob,
  `Employee_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `blog_empId_idx` (`Employee_Id`),
  CONSTRAINT `blog_empId` FOREIGN KEY (`Employee_Id`) REFERENCES `employee` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog`
--

LOCK TABLES `blog` WRITE;
/*!40000 ALTER TABLE `blog` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign`
--

DROP TABLE IF EXISTS `campaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `ExecuteTime` date DEFAULT NULL,
  `CompleteTime` date DEFAULT NULL,
  `Category_Id` int DEFAULT NULL,
  `Ngo_Id` int DEFAULT NULL,
  `Emp_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `camp_catId_idx` (`Category_Id`),
  KEY `camp_ngoId_idx` (`Ngo_Id`),
  KEY `camp_empId_idx` (`Emp_Id`),
  CONSTRAINT `camp_catId` FOREIGN KEY (`Category_Id`) REFERENCES `category` (`Id`),
  CONSTRAINT `camp_empId` FOREIGN KEY (`Emp_Id`) REFERENCES `employee` (`Id`),
  CONSTRAINT `camp_ngoId` FOREIGN KEY (`Ngo_Id`) REFERENCES `ngo` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign`
--

LOCK TABLES `campaign` WRITE;
/*!40000 ALTER TABLE `campaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_detail`
--

DROP TABLE IF EXISTS `campaign_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_detail` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Title1` varchar(45) DEFAULT NULL,
  `Description1` text,
  `Image1` blob,
  `Campaign_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `camp_detail_campId_idx` (`Campaign_Id`),
  CONSTRAINT `camp_detail_campId` FOREIGN KEY (`Campaign_Id`) REFERENCES `campaign` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_detail`
--

LOCK TABLES `campaign_detail` WRITE;
/*!40000 ALTER TABLE `campaign_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Overview_Script` text,
  `Overview_Img` blob,
  `Detail_Script` text,
  `Detail_Img` blob,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donor`
--

DROP TABLE IF EXISTS `donor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donor` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `FullName` varchar(45) DEFAULT NULL,
  `Birthday` date DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Phone` int DEFAULT NULL,
  `Username` varchar(15) DEFAULT NULL,
  `Password` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donor`
--

LOCK TABLES `donor` WRITE;
/*!40000 ALTER TABLE `donor` DISABLE KEYS */;
/*!40000 ALTER TABLE `donor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Fullname` varchar(45) DEFAULT NULL,
  `Birthday` date DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Phone` int DEFAULT NULL,
  `Username` varchar(15) DEFAULT NULL,
  `Password` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expense`
--

DROP TABLE IF EXISTS `expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expense` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(60) DEFAULT NULL,
  `Price` double DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expense`
--

LOCK TABLES `expense` WRITE;
/*!40000 ALTER TABLE `expense` DISABLE KEYS */;
/*!40000 ALTER TABLE `expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `function`
--

DROP TABLE IF EXISTS `function`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `function` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `function`
--

LOCK TABLES `function` WRITE;
/*!40000 ALTER TABLE `function` DISABLE KEYS */;
/*!40000 ALTER TABLE `function` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fund`
--

DROP TABLE IF EXISTS `fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fund` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Total` float DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fund`
--

LOCK TABLES `fund` WRITE;
/*!40000 ALTER TABLE `fund` DISABLE KEYS */;
/*!40000 ALTER TABLE `fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ngo`
--

DROP TABLE IF EXISTS `ngo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ngo` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) DEFAULT NULL,
  `Email` varchar(45) DEFAULT NULL,
  `Phone` int DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Image` blob,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ngo`
--

LOCK TABLES `ngo` WRITE;
/*!40000 ALTER TABLE `ngo` DISABLE KEYS */;
/*!40000 ALTER TABLE `ngo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Total` float DEFAULT NULL,
  `Reason` text,
  `Campaign_Id` int DEFAULT NULL,
  `Fund_Id` int DEFAULT NULL,
  `CurrentTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id`),
  KEY `pay_campId_idx` (`Campaign_Id`),
  KEY `pay_fundId_idx` (`Fund_Id`),
  CONSTRAINT `pay_campId` FOREIGN KEY (`Campaign_Id`) REFERENCES `campaign` (`Id`),
  CONSTRAINT `pay_fundId` FOREIGN KEY (`Fund_Id`) REFERENCES `fund` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='phieu chi';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_blog_camp`
--

DROP TABLE IF EXISTS `ref_blog_camp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_blog_camp` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Blog_Id` int DEFAULT NULL,
  `Campaign_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ref_blog_camp_CampId_idx` (`Campaign_Id`),
  KEY `ref_blog_camp_BlogId_idx` (`Blog_Id`),
  CONSTRAINT `ref_blog_camp_BlogId` FOREIGN KEY (`Blog_Id`) REFERENCES `blog` (`Id`),
  CONSTRAINT `ref_blog_camp_CampId` FOREIGN KEY (`Campaign_Id`) REFERENCES `campaign` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_blog_camp`
--

LOCK TABLES `ref_blog_camp` WRITE;
/*!40000 ALTER TABLE `ref_blog_camp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_blog_camp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_donor_fund`
--

DROP TABLE IF EXISTS `ref_donor_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_donor_fund` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Donor_Id` int DEFAULT NULL,
  `Fund_Id` int DEFAULT NULL,
  `Total` float DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ref_donor_fund_donor_idx` (`Donor_Id`),
  KEY `ref_donor_fund_fund_idx` (`Fund_Id`),
  CONSTRAINT `ref_donor_fund_donor` FOREIGN KEY (`Donor_Id`) REFERENCES `donor` (`Id`),
  CONSTRAINT `ref_donor_fund_fund` FOREIGN KEY (`Fund_Id`) REFERENCES `fund` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_donor_fund`
--

LOCK TABLES `ref_donor_fund` WRITE;
/*!40000 ALTER TABLE `ref_donor_fund` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_donor_fund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_donor_fund_camp`
--

DROP TABLE IF EXISTS `ref_donor_fund_camp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_donor_fund_camp` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Donor_Id` int DEFAULT NULL,
  `Fund_Id` int DEFAULT NULL,
  `Campaign_Id` int DEFAULT NULL,
  `Current_Time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Description` text,
  `Total` float DEFAULT NULL,
  `Payment_Method` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ref_donor_fund_camp_campId_idx` (`Campaign_Id`),
  KEY `ref_donor_fund_camp_donorId_idx` (`Donor_Id`),
  KEY `ref_donor_fund_camp_fundId_idx` (`Fund_Id`),
  CONSTRAINT `ref_donor_fund_camp_campId` FOREIGN KEY (`Campaign_Id`) REFERENCES `campaign` (`Id`),
  CONSTRAINT `ref_donor_fund_camp_donorId` FOREIGN KEY (`Donor_Id`) REFERENCES `donor` (`Id`),
  CONSTRAINT `ref_donor_fund_camp_fundId` FOREIGN KEY (`Fund_Id`) REFERENCES `fund` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_donor_fund_camp`
--

LOCK TABLES `ref_donor_fund_camp` WRITE;
/*!40000 ALTER TABLE `ref_donor_fund_camp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_donor_fund_camp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_emp_group`
--

DROP TABLE IF EXISTS `ref_emp_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_emp_group` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Emp_Id` int DEFAULT NULL,
  `Group_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ref_emp_group_group_idx` (`Group_Id`),
  KEY `ref_emp_group_emp_idx` (`Emp_Id`),
  CONSTRAINT `ref_emp_group_emp` FOREIGN KEY (`Emp_Id`) REFERENCES `employee` (`Id`),
  CONSTRAINT `ref_emp_group_group` FOREIGN KEY (`Group_Id`) REFERENCES `group` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_emp_group`
--

LOCK TABLES `ref_emp_group` WRITE;
/*!40000 ALTER TABLE `ref_emp_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_emp_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_group_func`
--

DROP TABLE IF EXISTS `ref_group_func`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_group_func` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Group_Id` int DEFAULT NULL,
  `Function_Id` int DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ref_func_group_group_idx` (`Group_Id`),
  KEY `ref_func_group_func_idx` (`Function_Id`),
  CONSTRAINT `ref_func_group_func` FOREIGN KEY (`Function_Id`) REFERENCES `function` (`Id`),
  CONSTRAINT `ref_func_group_group` FOREIGN KEY (`Group_Id`) REFERENCES `group` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_group_func`
--

LOCK TABLES `ref_group_func` WRITE;
/*!40000 ALTER TABLE `ref_group_func` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_group_func` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_pay_exp`
--

DROP TABLE IF EXISTS `ref_pay_exp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_pay_exp` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `Payment_Id` int DEFAULT NULL,
  `Expense_Id` int DEFAULT NULL,
  `Total` float DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ref_pay_exp_payId_idx` (`Payment_Id`),
  KEY `ref_pay_exp_expId_idx` (`Expense_Id`),
  CONSTRAINT `ref_pay_exp_expId` FOREIGN KEY (`Expense_Id`) REFERENCES `expense` (`Id`),
  CONSTRAINT `ref_pay_exp_payId` FOREIGN KEY (`Payment_Id`) REFERENCES `payment` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_pay_exp`
--

LOCK TABLES `ref_pay_exp` WRITE;
/*!40000 ALTER TABLE `ref_pay_exp` DISABLE KEYS */;
/*!40000 ALTER TABLE `ref_pay_exp` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-08 12:17:15
