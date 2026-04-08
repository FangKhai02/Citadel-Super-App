use citadel;

-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: localhost    Database: citadel
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `agency`
--

DROP TABLE IF EXISTS `agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency` (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `agency_code` varchar(255) DEFAULT NULL,
                          `agency_name` varchar(255) DEFAULT NULL,
                          `company_reg_number` varchar(255) DEFAULT NULL,
                          `contact_number` varchar(255) DEFAULT NULL,
                          `email_address` varchar(255) DEFAULT NULL,
                          `office_address` varchar(255) DEFAULT NULL,
                          `representative_name` varchar(255) DEFAULT NULL,
                          `representative_nric_passport` varchar(255) DEFAULT NULL,
                          `representative_contact_number` varchar(255) DEFAULT NULL,
                          `representative_email` varchar(255) DEFAULT NULL,
                          `recruited_by` bigint DEFAULT NULL,
                          `cms_credentials_id` bigint DEFAULT NULL,
                          `bank_name` varchar(255) DEFAULT NULL,
                          `bank_address` varchar(255) DEFAULT NULL,
                          `account_holder_name` varchar(255) DEFAULT NULL,
                          `account_number` varchar(255) DEFAULT NULL,
                          `swift_code` varchar(255) DEFAULT NULL,
                          `status` tinyint(1) DEFAULT NULL,
                          `agency_agreement` text,
                          `strategic_alliance_partnership_form` text,
                          `agency_type` enum('citadel','other') DEFAULT NULL,
                          `created_at` timestamp NULL DEFAULT NULL,
                          `updated_at` timestamp NULL DEFAULT NULL,
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agency`
--

LOCK TABLES `agency` WRITE;
/*!40000 ALTER TABLE `agency` DISABLE KEYS */;
INSERT INTO `agency` VALUES (1,'AG001','Citadel Agency',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'[]','[]','citadel','2024-09-26 10:03:04','2024-10-01 19:52:26'),(2,'AG002','Other Agency',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'[]','[]','other','2024-09-26 10:03:04','2024-10-01 19:52:34');
/*!40000 ALTER TABLE `agency` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agency_product`
--

DROP TABLE IF EXISTS `agency_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agency_product` (
                                  `id` bigint NOT NULL AUTO_INCREMENT,
                                  `product_id` bigint NOT NULL,
                                  `agency_id` bigint NOT NULL,
                                  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  PRIMARY KEY (`id`),
                                  UNIQUE KEY `unique_agency_product` (`product_id`,`agency_id`),
                                  KEY `agency_id` (`agency_id`),
                                  CONSTRAINT `agency_product_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
                                  CONSTRAINT `agency_product_ibfk_2` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agency_product`
--

LOCK TABLES `agency_product` WRITE;
/*!40000 ALTER TABLE `agency_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `agency_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agent`
--

DROP TABLE IF EXISTS `agent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `agent` (
                         `id` bigint NOT NULL AUTO_INCREMENT,
                         `app_user_id` bigint NOT NULL,
                         `user_detail_id` bigint NOT NULL,
                         `agency_id` bigint DEFAULT NULL,
                         `referral_code` varchar(255) DEFAULT NULL,
                         `recruit_manager` bigint DEFAULT NULL,
                         `bank_details_id` bigint DEFAULT NULL,
                         `status` tinyint(1) NOT NULL DEFAULT '1',
                         `agent_role` enum('mgr','p2p','sm','avp','vp','svp','direct_svp','hos','ceo','ccsb','cwp') DEFAULT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `referral_code` (`referral_code`),
                         KEY `user_id` (`app_user_id`),
                         KEY `user_detail` (`user_detail_id`),
                         KEY `bank_details_id` (`bank_details_id`),
                         KEY `agent_ibfk_agency` (`agency_id`),
                         CONSTRAINT `agent_ibfk_1` FOREIGN KEY (`app_user_id`) REFERENCES `app_users` (`id`),
                         CONSTRAINT `agent_ibfk_2` FOREIGN KEY (`user_detail_id`) REFERENCES `user_details` (`id`),
                         CONSTRAINT `agent_ibfk_3` FOREIGN KEY (`bank_details_id`) REFERENCES `bank_details` (`id`),
                         CONSTRAINT `agent_ibfk_agency` FOREIGN KEY (`agency_id`) REFERENCES `agency` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agent`
--

LOCK TABLES `agent` WRITE;
/*!40000 ALTER TABLE `agent` DISABLE KEYS */;
INSERT INTO `agent` VALUES (1,1,1,1,'REF001',2,1,1,'mgr','2024-09-26 10:04:48','2024-10-01 01:45:16'),(2,2,2,2,'REF002',NULL,2,1,'sm','2024-09-26 10:04:48','2024-09-26 10:04:48'),(3,3,3,NULL,'REF003',NULL,3,1,'avp','2024-09-26 10:04:48','2024-09-26 10:04:48');
/*!40000 ALTER TABLE `agent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_user_sessions`
--

DROP TABLE IF EXISTS `app_user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_user_sessions` (
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `user_id` bigint NOT NULL,
                                     `session_token` varchar(255) NOT NULL,
                                     `created_at` timestamp NULL DEFAULT NULL,
                                     `updated_at` timestamp NULL DEFAULT NULL,
                                     `expires_at` timestamp NOT NULL,
                                     PRIMARY KEY (`id`),
                                     UNIQUE KEY `session_token` (`session_token`),
                                     KEY `user_id` (`user_id`),
                                     CONSTRAINT `app_user_sessions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_user_sessions`
--

LOCK TABLES `app_user_sessions` WRITE;
/*!40000 ALTER TABLE `app_user_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_user_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_users`
--

DROP TABLE IF EXISTS `app_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_users` (
                             `id` bigint NOT NULL AUTO_INCREMENT,
                             `email_address` varchar(255) DEFAULT NULL,
                             `password` varchar(255) DEFAULT NULL,
                             `role` enum('agent','client','guest','admin') NOT NULL,
                             `created_at` timestamp NULL DEFAULT NULL,
                             `updated_at` timestamp NULL DEFAULT NULL,
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `email_address` (`email_address`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_users`
--

LOCK TABLES `app_users` WRITE;
/*!40000 ALTER TABLE `app_users` DISABLE KEYS */;
INSERT INTO `app_users` VALUES (1,'agent1@example.com','password1','agent','2024-09-26 10:03:00','2024-09-26 10:03:00'),(2,'agent2@example.com','password2','agent','2024-09-26 10:03:00','2024-09-26 10:03:00'),(3,'agent3@example.com','password3','agent','2024-09-26 10:03:00','2024-09-26 10:03:00'),(4,'client1@example.com','password1','client','2024-10-02 04:29:24','2024-10-02 04:29:24'),(5,'client2@example.com','password2','client','2024-10-02 04:29:24','2024-10-02 04:29:24'),(6,'client3@example.com','password3','client','2024-10-02 04:29:24','2024-10-02 04:29:24');
/*!40000 ALTER TABLE `app_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `approver`
--

DROP TABLE IF EXISTS `approver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `approver` (
                            `id` bigint NOT NULL AUTO_INCREMENT,
                            `bank_file_upload_id` bigint DEFAULT NULL,
                            `status` enum('Pending Approval','Approved','Failed') NOT NULL,
                            `remark` varchar(255) DEFAULT NULL,
                            `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                            `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `approver`
--

LOCK TABLES `approver` WRITE;
/*!40000 ALTER TABLE `approver` DISABLE KEYS */;
/*!40000 ALTER TABLE `approver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_details`
--

DROP TABLE IF EXISTS `bank_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_details` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `app_user_id` bigint DEFAULT NULL,
                                `bank_name` varchar(255) DEFAULT NULL,
                                `account_number` varchar(255) DEFAULT NULL,
                                `account_holder_name` varchar(255) DEFAULT NULL,
                                `permanent_address` varchar(255) DEFAULT NULL,
                                `postcode` varchar(255) DEFAULT NULL,
                                `city` varchar(255) DEFAULT NULL,
                                `state` varchar(255) DEFAULT NULL,
                                `country` varchar(255) DEFAULT NULL,
                                `swift_code` varchar(255) DEFAULT NULL,
                                `bank_account_proof_key` text,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL,
                                PRIMARY KEY (`id`),
                                KEY `user_id` (`app_user_id`),
                                CONSTRAINT `bank_details_ibfk_1` FOREIGN KEY (`app_user_id`) REFERENCES `app_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_details`
--

LOCK TABLES `bank_details` WRITE;
/*!40000 ALTER TABLE `bank_details` DISABLE KEYS */;
INSERT INTO `bank_details` VALUES (1,1,'CIMB BANK','ACC12492','Agent One','123 Street','12345','City A','State A','Country A','SWIFT1',NULL,'2024-09-26 10:03:09','2024-10-01 02:37:18'),(2,2,'Bank B',NULL,'Agent Two','456 Avenue','67890','City B','State B','Country B','SWIFT2',NULL,'2024-09-26 10:03:09','2024-09-26 10:03:09'),(3,3,'Bank C',NULL,'Agent Three','789 Boulevard','13579','City C','State C','Country C','SWIFT3',NULL,'2024-09-26 10:03:09','2024-09-26 10:03:09'),(4,4,'UOB Bank','ACC56789','Agent Four','987 Road','24680','City D','State D','Country D','SWIFT4',NULL,'2024-10-03 05:03:34','2024-10-03 05:49:13'),(5,4,'Bank Islam','ACC98765','Agent Four','654 Lane','11223','City E','State E','Country E','SWIFT5',NULL,'2024-10-03 05:03:34','2024-10-03 05:49:37');
/*!40000 ALTER TABLE `bank_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_file_upload`
--

DROP TABLE IF EXISTS `bank_file_upload`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_file_upload` (
                                    `id` bigint NOT NULL AUTO_INCREMENT,
                                    `upload_document` varchar(255) DEFAULT NULL,
                                    `description` varchar(255) DEFAULT NULL,
                                    `status` enum('Pending Approval','Approved','Failed') NOT NULL,
                                    `checker_id` bigint DEFAULT NULL,
                                    `approver_id` bigint DEFAULT NULL,
                                    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                    `created_by` bigint DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                    `updated_by` bigint DEFAULT NULL,
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_file_upload`
--

LOCK TABLES `bank_file_upload` WRITE;
/*!40000 ALTER TABLE `bank_file_upload` DISABLE KEYS */;
/*!40000 ALTER TABLE `bank_file_upload` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checker`
--

DROP TABLE IF EXISTS `checker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `checker` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `bank_file_upload_id` bigint DEFAULT NULL,
                           `status` enum('Pending Approval','Approved','Failed') NOT NULL,
                           `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                           `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checker`
--

LOCK TABLES `checker` WRITE;
/*!40000 ALTER TABLE `checker` DISABLE KEYS */;
/*!40000 ALTER TABLE `checker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `client` (
                          `id` bigint NOT NULL AUTO_INCREMENT,
                          `app_user_id` bigint NOT NULL,
                          `user_detail_id` bigint NOT NULL,
                          `agent_id` bigint DEFAULT NULL,
                          `agent_referral_code` varchar(255) DEFAULT NULL,
                          `employment_details_id` bigint DEFAULT NULL,
                          `individual_wealth_income_id` bigint DEFAULT NULL,
                          `created_at` timestamp NULL DEFAULT NULL,
                          `updated_at` timestamp NULL DEFAULT NULL,
                          PRIMARY KEY (`id`),
                          KEY `fk_agent` (`agent_id`),
                          KEY `fk_individual_wealth_income` (`individual_wealth_income_id`),
                          CONSTRAINT `fk_agent` FOREIGN KEY (`agent_id`) REFERENCES `agent` (`id`),
                          CONSTRAINT `fk_individual_wealth_income` FOREIGN KEY (`individual_wealth_income_id`) REFERENCES `individual_wealth_income` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,4,4,1,'REF001',1,1,'2024-10-02 06:48:23','2024-10-03 05:49:37');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corporate_client`
--

DROP TABLE IF EXISTS `corporate_client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corporate_client` (
                                    `id` bigint NOT NULL AUTO_INCREMENT,
                                    `user_id` bigint NOT NULL,
                                    `user_detail_id` bigint NOT NULL,
                                    `referral_code_agent` varchar(255) DEFAULT NULL,
                                    `employment_details_id` bigint DEFAULT NULL,
                                    `corporate_pep_status_id` bigint DEFAULT NULL,
                                    `bank_details_id` bigint DEFAULT NULL,
                                    `created_at` timestamp NULL DEFAULT NULL,
                                    `updated_at` timestamp NULL DEFAULT NULL,
                                    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corporate_client`
--

LOCK TABLES `corporate_client` WRITE;
/*!40000 ALTER TABLE `corporate_client` DISABLE KEYS */;
/*!40000 ALTER TABLE `corporate_client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corporate_shareholders`
--

DROP TABLE IF EXISTS `corporate_shareholders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `corporate_shareholders` (
                                          `id` bigint NOT NULL AUTO_INCREMENT,
                                          `user_id` bigint NOT NULL,
                                          `name` varchar(255) DEFAULT NULL,
                                          `ic_passport` varchar(255) DEFAULT NULL,
                                          `percentage_of_shareholdings` double DEFAULT NULL,
                                          `mobile_number` varchar(255) DEFAULT NULL,
                                          `email` varchar(255) DEFAULT NULL,
                                          `nationality` varchar(255) DEFAULT NULL,
                                          `address` varchar(255) DEFAULT NULL,
                                          `postcode` varchar(255) DEFAULT NULL,
                                          `city` varchar(255) DEFAULT NULL,
                                          `state` varchar(255) DEFAULT NULL,
                                          `country` varchar(255) DEFAULT NULL,
                                          `ic_document_key` text,
                                          `address_proof_key` text,
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL,
                                          PRIMARY KEY (`id`),
                                          KEY `user_id` (`user_id`),
                                          CONSTRAINT `corporate_shareholders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`app_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corporate_shareholders`
--

LOCK TABLES `corporate_shareholders` WRITE;
/*!40000 ALTER TABLE `corporate_shareholders` DISABLE KEYS */;
/*!40000 ALTER TABLE `corporate_shareholders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_rows` (
                             `id` int unsigned NOT NULL AUTO_INCREMENT,
                             `data_type_id` int unsigned NOT NULL,
                             `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                             `required` tinyint(1) NOT NULL DEFAULT '0',
                             `browse` tinyint(1) NOT NULL DEFAULT '1',
                             `read` tinyint(1) NOT NULL DEFAULT '1',
                             `edit` tinyint(1) NOT NULL DEFAULT '1',
                             `add` tinyint(1) NOT NULL DEFAULT '1',
                             `delete` tinyint(1) NOT NULL DEFAULT '1',
                             `details` text COLLATE utf8mb4_unicode_ci,
                             `order` int NOT NULL DEFAULT '1',
                             PRIMARY KEY (`id`),
                             KEY `data_rows_data_type_id_foreign` (`data_type_id`),
                             CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_rows`
--

LOCK TABLES `data_rows` WRITE;
/*!40000 ALTER TABLE `data_rows` DISABLE KEYS */;
INSERT INTO `data_rows` VALUES (1,1,'id','number','ID',1,0,0,0,0,0,NULL,1),(2,1,'name','text','Name',1,1,1,1,1,1,NULL,2),(3,1,'email','text','Email',1,1,1,1,1,1,NULL,3),(4,1,'password','password','Password',1,0,0,1,1,0,NULL,4),(5,1,'remember_token','text','Remember Token',0,0,0,0,0,0,NULL,5),(6,1,'created_at','timestamp','Created At',0,1,1,0,0,0,NULL,6),(7,1,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,7),(8,1,'avatar','image','Avatar',0,1,1,1,1,1,NULL,8),(9,1,'user_belongsto_role_relationship','relationship','Role',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}',10),(10,1,'user_belongstomany_role_relationship','relationship','Roles',0,1,1,1,1,0,'{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}',11),(11,1,'settings','hidden','Settings',0,0,0,0,0,0,NULL,12),(12,2,'id','number','ID',1,0,0,0,0,0,NULL,1),(13,2,'name','text','Name',1,1,1,1,1,1,NULL,2),(14,2,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),(15,2,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),(16,3,'id','number','ID',1,0,0,0,0,0,NULL,1),(17,3,'name','text','Name',1,1,1,1,1,1,NULL,2),(18,3,'created_at','timestamp','Created At',0,0,0,0,0,0,NULL,3),(19,3,'updated_at','timestamp','Updated At',0,0,0,0,0,0,NULL,4),(20,3,'display_name','text','Display Name',1,1,1,1,1,1,NULL,5),(21,1,'role_id','text','Role',1,1,1,1,1,1,NULL,9),(56,8,'id','text','Agent ID',1,1,0,0,0,0,'{}',1),(62,8,'recruit_manager','text','Recruit Manager',0,0,0,0,0,0,'{}',33),(63,8,'referral_code','text','Referral Code',0,0,0,0,0,0,'{}',34),(64,8,'bank_details_id','text','Bank Details Id',0,0,0,0,0,0,'{}',18),(65,8,'created_at','timestamp','Created Datetime',0,1,0,0,0,0,'{}',35),(66,8,'updated_at','timestamp','Updated Datetime',0,1,0,0,0,0,'{}',36),(67,8,'agent_belongsto_user_detail_relationship','relationship','Full Name',0,1,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"agent\",\"pivot\":\"0\",\"taggable\":\"0\"}',4),(68,8,'agency_id','text','Agency Id',0,1,0,0,0,0,'{}',15),(69,8,'agent_belongsto_user_detail_relationship_1','relationship','NRIC / Passport No.',0,1,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"ic_passport\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',5),(70,8,'agent_belongsto_user_detail_relationship_2','relationship','Mobile Number',0,1,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"mobile_number\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',7),(71,8,'status','checkbox','Status',1,1,0,0,0,0,'{\"on\":\"Active\",\"off\":\"Inactive\",\"checked\":true}',32),(72,8,'agent_belongsto_agency_relationship','relationship','Agency Name',0,1,0,0,0,0,'{\"model\":\"App\\\\Models\\\\Agency\",\"table\":\"agency\",\"type\":\"belongsTo\",\"column\":\"agency_id\",\"key\":\"id\",\"label\":\"agency_name\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',17),(73,8,'agent_role','select_dropdown','Agent Role',0,0,0,0,0,0,'{\"options\":{\"mgr\":\"Manager\",\"p2p\":\"Peer to Peer\",\"sm\":\"Sales Manager\",\"avp\":\"Assistant Vice President\",\"vp\":\"Vice President\",\"svp\":\"Senior Vice President \",\"direct_svp\":\"Director Senior Vice President\",\"hos\":\"Head of Service\",\"ceo\":\"Chief Executive Officer\",\"ccsb\":\"Chief Customer Service Boss\",\"cwp\":\"Chief Workforce Planner\"}}',16),(74,8,'agent_hasone_user_detail_relationship','relationship','Gender',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"gender\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',9),(75,8,'agent_belongsto_app_user_relationship','relationship','Email',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"id\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',8),(76,8,'agent_belongsto_user_detail_relationship_3','relationship','Date of Birth',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"dob\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',6),(77,8,'agent_belongsto_user_detail_relationship_4','relationship','Permanent Address',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"address\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',10),(78,8,'agent_belongsto_user_detail_relationship_5','relationship','Postcode',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"postcode\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',11),(79,8,'agent_belongsto_user_detail_relationship_6','relationship','City',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"city\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',12),(80,8,'agent_hasone_user_detail_relationship_1','relationship','State',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"state\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',13),(81,8,'agent_hasone_user_detail_relationship_2','relationship','Country',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"country\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',14),(83,8,'agent_belongsto_user_detail_relationship_7','relationship','IC Document',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"id\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',19),(84,8,'agent_belongsto_user_detail_relationship_8','relationship','Address Proof',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"selfie_document_key\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',20),(85,8,'agent_hasone_user_detail_relationship_3','relationship','Selfie Document',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"selfie_document_key\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',21),(86,8,'agent_belongsto_bank_detail_relationship','relationship','Bank Name',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"bank_name\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',22),(87,8,'agent_belongsto_bank_detail_relationship_1','relationship','Account Holder Name',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"account_holder_name\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',24),(88,8,'agent_belongsto_bank_detail_relationship_2','relationship','Permanent Address',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"permanent_address\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',25),(89,8,'agent_hasone_bank_detail_relationship','relationship','Postcode',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"postcode\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',26),(90,8,'agent_belongsto_bank_detail_relationship_3','relationship','City',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"city\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',27),(91,8,'agent_belongsto_bank_detail_relationship_4','relationship','State',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"state\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',28),(92,8,'agent_belongsto_bank_detail_relationship_5','relationship','Country',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"country\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',30),(93,8,'agent_belongsto_bank_detail_relationship_6','relationship','SWIFT Code',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"swift_code\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',29),(94,8,'agent_belongsto_bank_detail_relationship_7','relationship','Bank Account Proof',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"bank_account_proof_key\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',31),(95,8,'user_detail_id','text','User Detail Id',1,1,0,0,0,0,'{}',3),(96,9,'id','text','Client ID',1,1,0,0,0,0,'{}',1),(98,9,'user_detail_id','text','User Detail Id',1,1,0,0,0,0,'{}',4),(100,9,'employment_details_id','text','Employment Details Id',0,0,0,0,0,0,'{}',10),(103,9,'created_at','timestamp','Created Datetime',0,1,0,0,0,0,'{}',11),(104,9,'updated_at','timestamp','Updated Datetime',0,1,0,0,0,0,'{}',12),(105,10,'id','text','Agency ID',1,1,1,0,0,0,'{}',1),(106,10,'agency_code','text','Agency Code',0,0,0,0,0,0,'{}',2),(107,10,'agency_name','text','Agency Name',0,1,1,1,1,0,'{}',4),(108,10,'company_reg_number','text','Company Reg No.',0,1,1,1,1,0,'{}',5),(109,10,'contact_number','text','Contact Number',0,0,1,1,1,0,'{}',6),(110,10,'email_address','text','Email Address',0,0,1,1,1,0,'{}',7),(111,10,'office_address','text_area','Office Address',0,0,1,1,1,0,'{}',8),(112,10,'representative_name','text','Representative Name',0,0,1,1,1,0,'{}',9),(113,10,'representative_nric_passport','text','Representative NRIC/Passport',0,0,1,1,1,0,'{}',10),(114,10,'representative_contact_number','text','Representative Contact Number',0,0,1,1,1,0,'{}',11),(115,10,'representative_email','text','Representative Email',0,0,1,1,1,0,'{}',12),(116,10,'recruited_by','text','Recruited By',0,0,0,0,0,0,'{}',13),(117,10,'cms_credentials_id','text','CMS Credentials Id',0,0,0,0,0,0,'{}',14),(118,10,'bank_name','text','Bank Name',0,0,1,1,1,0,'{}',15),(119,10,'bank_address','text','Bank Address',0,0,1,1,1,0,'{}',16),(120,10,'account_holder_name','text','Account Holder Name',0,0,1,1,1,0,'{}',17),(121,10,'account_number','text','Account Number',0,0,1,1,1,0,'{}',18),(122,10,'swift_code','text','Swift Code',0,0,1,1,1,0,'{}',19),(123,10,'status','checkbox','Status',0,1,1,1,1,0,'{\"on\":\"Active\",\"off\":\"Inactive\",\"checked\":false}',20),(124,10,'agency_agreement','file','Agency Agreement',0,0,1,1,1,0,'{}',21),(125,10,'strategic_alliance_partnership_form','file','Strategic Alliance Partnership Form',0,0,1,1,1,0,'{}',22),(126,10,'agency_type','select_dropdown','Agency Type',0,0,1,1,1,0,'{\"default\":\"citadel\",\"options\":{\"citadel\":\"Citadel Agency\",\"other\":\"Other Agency\"}}',3),(127,10,'created_at','timestamp','Created Datetime',0,1,1,0,0,0,'{}',23),(128,10,'updated_at','timestamp','Updated Datetime',0,1,1,0,0,0,'{}',24),(130,12,'id','text','Id',1,0,0,0,0,0,'{}',1),(131,12,'product_type_name','text','Product Type Name',1,1,1,1,1,0,'{}',2),(132,12,'image','text','Image',0,1,1,1,1,0,'{}',3),(133,12,'status','text','Status',0,1,1,1,1,0,'{}',4),(134,12,'created_at','timestamp','Created At',0,1,1,0,0,0,'{}',5),(135,12,'updated_at','timestamp','Updated At',0,1,1,0,0,0,'{}',6),(136,13,'id','text','Id',1,1,1,0,0,0,'{}',1),(137,13,'product_name','text','Product Name',1,1,1,1,1,1,'{}',2),(138,13,'product_type_id','text','Product Type Id',1,1,1,1,1,1,'{}',3),(139,13,'product_description','text','Product Description',0,0,1,1,1,1,'{}',4),(140,13,'dividend_rate','text','Dividend Rate',0,0,1,1,1,1,'{}',5),(141,13,'incremental','text','Incremental',0,0,1,1,1,1,'{}',6),(142,13,'investment_tenure_month','text','Investment Tenure Month',0,0,1,1,1,1,'{}',7),(143,13,'risk_level','text','Risk Level',0,1,1,1,1,1,'{}',8),(144,13,'product_agreement_id','text','Product Agreement Id',1,0,1,1,1,1,'{}',9),(145,13,'product_catalogue_url','text','Product Catalogue Url',0,0,1,1,1,1,'{}',10),(146,13,'image_of_product_url','text','Image Of Product Url',0,0,1,1,1,1,'{}',11),(147,13,'status','text','Status',1,1,1,1,1,1,'{}',12),(148,13,'display_on_app','text','Display On App',0,0,1,1,1,1,'{}',13),(149,13,'created_at','timestamp','Created At',0,1,1,0,0,0,'{}',14),(150,13,'updated_at','timestamp','Updated At',0,1,1,0,0,0,'{}',15),(151,14,'id','text','Id',1,0,0,0,0,0,'{}',1),(152,14,'name','text','Name',1,1,1,1,1,0,'{}',2),(153,14,'status','text','Status',1,1,1,1,1,0,'{}',3),(154,14,'created_at','timestamp','Created Datetime',0,1,1,0,0,0,'{}',4),(155,14,'updated_at','timestamp','Updated Datetime',0,1,1,0,0,0,'{}',5),(167,18,'id','text','Id',1,0,0,0,0,0,'{}',1),(168,18,'document_type_id','text','Document Type Id',1,0,0,0,0,0,'{}',2),(169,18,'name','text','Product Agreement Name',1,1,1,1,1,1,'{}',4),(170,18,'description','text','Product Agreement Description',0,1,1,1,1,1,'{}',5),(171,18,'upload_document','image','Upload Document',0,0,1,1,1,1,'{}',6),(172,18,'document_editor','rich_text_box','Document Editor',0,0,1,1,1,1,'{}',7),(173,18,'valid_from','timestamp','Valid From',0,1,1,1,1,1,'{}',8),(174,18,'valid_until','timestamp','Valid Until',0,1,1,1,1,1,'{}',9),(175,18,'status','text','Status',1,1,1,1,1,1,'{}',10),(176,18,'created_at','timestamp','Created At',0,1,1,0,0,0,'{}',11),(177,18,'updated_at','timestamp','Updated At',0,1,1,0,0,0,'{}',12),(178,18,'use_document_editor','text','Use Document Editor',0,0,1,1,1,1,'{}',13),(180,8,'agent_belongsto_bank_detail_relationship_8','relationship','Account Number',0,0,0,0,0,0,'{\"model\":\"App\\\\Models\\\\BankDetails\",\"table\":\"bank_details\",\"type\":\"belongsTo\",\"column\":\"bank_details_id\",\"key\":\"id\",\"label\":\"account_number\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',23),(181,9,'client_belongsto_user_detail_relationship','relationship','Full Name',0,1,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',3),(182,9,'client_belongsto_user_detail_relationship_1','relationship','NRIC / Passport',0,1,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"ic_passport\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',5),(183,9,'client_belongsto_user_detail_relationship_2','relationship','Mobile Number',0,1,0,0,0,0,'{\"model\":\"App\\\\Models\\\\UserDetails\",\"table\":\"user_details\",\"type\":\"belongsTo\",\"column\":\"user_detail_id\",\"key\":\"id\",\"label\":\"mobile_number\",\"pivot_table\":\"agency\",\"pivot\":\"0\",\"taggable\":\"0\"}',9),(191,8,'app_user_id','text','App User Id',1,0,0,0,0,0,'{}',2),(192,9,'app_user_id','text','App User Id',1,0,0,0,0,0,'{}',2),(194,9,'agent_id','text','Agent',0,1,0,0,0,0,'{}',6),(195,9,'agent_referral_code','text','Agent Referral Code',0,0,0,0,0,0,'{}',8);
/*!40000 ALTER TABLE `data_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_types` (
                              `id` int unsigned NOT NULL AUTO_INCREMENT,
                              `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
                              `server_side` tinyint NOT NULL DEFAULT '0',
                              `details` text COLLATE utf8mb4_unicode_ci,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL,
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `data_types_name_unique` (`name`),
                              UNIQUE KEY `data_types_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_types`
--

LOCK TABLES `data_types` WRITE;
/*!40000 ALTER TABLE `data_types` DISABLE KEYS */;
INSERT INTO `data_types` VALUES (1,'users','users','User','Users','voyager-person','TCG\\Voyager\\Models\\User','TCG\\Voyager\\Policies\\UserPolicy','TCG\\Voyager\\Http\\Controllers\\VoyagerUserController','',1,0,NULL,'2024-09-25 19:11:15','2024-09-25 19:11:15'),(2,'menus','menus','Menu','Menus','voyager-list','TCG\\Voyager\\Models\\Menu',NULL,'','',1,0,NULL,'2024-09-25 19:11:15','2024-09-25 19:11:15'),(3,'roles','roles','Role','Roles','voyager-lock','TCG\\Voyager\\Models\\Role',NULL,'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController','',1,0,NULL,'2024-09-25 19:11:15','2024-09-25 19:11:15'),(8,'agent','agent','Agent','Agents',NULL,'App\\Models\\Agent',NULL,'App\\Http\\Controllers\\AgentController',NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2024-09-25 20:34:58','2024-10-01 22:31:29'),(9,'client','client','Client','Clients',NULL,'App\\Models\\Client',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2024-09-25 20:37:20','2024-10-01 22:57:50'),(10,'agency','agency','Agency','Agencies',NULL,'App\\Models\\Agency',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2024-09-30 00:01:10','2024-10-01 19:49:51'),(12,'product_type','product-type','Product Type','Product Types',NULL,'App\\Models\\ProductType',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2024-09-30 00:12:49','2024-09-30 00:12:49'),(13,'product','product','Product','Products',NULL,'App\\Models\\Product',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2024-09-30 00:26:46','2024-09-30 00:26:46'),(14,'document_type','document-type','Document Type','Document Types',NULL,'App\\Models\\DocumentType',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2024-09-30 00:39:39','2024-09-30 00:39:39'),(18,'product_agreement','product-agreement','Product Agreement','Product Agreements',NULL,'App\\Models\\ProductAgreement',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}','2024-09-30 00:51:50','2024-09-30 18:31:58'),(19,'product_order_individual','product-order-individual','Product Order Individual','Product Order Individuals',NULL,'App\\Models\\ProductOrderIndividual',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2024-09-30 01:42:56','2024-09-30 01:42:56'),(20,'bank_file_upload','bank-file-upload','Bank File Upload','Bank File Uploads',NULL,'App\\Models\\BankFileUpload',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2024-09-30 01:44:31','2024-09-30 01:44:31'),(21,'checker','checker','Checker','Checkers',NULL,'App\\Models\\Checker',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2024-09-30 01:45:07','2024-09-30 01:45:07'),(22,'approver','approver','Approver','Approvers',NULL,'App\\Models\\Approver',NULL,NULL,NULL,1,0,'{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}','2024-09-30 01:45:20','2024-09-30 01:45:20');
/*!40000 ALTER TABLE `data_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document_type`
--

DROP TABLE IF EXISTS `document_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document_type` (
                                 `id` bigint NOT NULL AUTO_INCREMENT,
                                 `name` varchar(255) NOT NULL,
                                 `status` tinyint(1) NOT NULL DEFAULT '1',
                                 `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                 `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document_type`
--

LOCK TABLES `document_type` WRITE;
/*!40000 ALTER TABLE `document_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employment_details`
--

DROP TABLE IF EXISTS `employment_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employment_details` (
                                      `id` bigint NOT NULL AUTO_INCREMENT,
                                      `client_id` bigint DEFAULT NULL,
                                      `employment_type` varchar(255) DEFAULT NULL,
                                      `employer_name` varchar(255) DEFAULT NULL,
                                      `industry_type` varchar(255) DEFAULT NULL,
                                      `job_title` varchar(255) DEFAULT NULL,
                                      `employer_address` varchar(255) DEFAULT NULL,
                                      `employer_postcode` varchar(255) DEFAULT NULL,
                                      `employer_city` varchar(255) DEFAULT NULL,
                                      `employer_state` varchar(255) DEFAULT NULL,
                                      `employer_country` varchar(255) DEFAULT NULL,
                                      `created_at` timestamp NULL DEFAULT NULL,
                                      `updated_at` timestamp NULL DEFAULT NULL,
                                      PRIMARY KEY (`id`),
                                      KEY `employment_details_fk_client_id` (`client_id`),
                                      CONSTRAINT `employment_details_fk_client_id` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employment_details`
--

LOCK TABLES `employment_details` WRITE;
/*!40000 ALTER TABLE `employment_details` DISABLE KEYS */;
INSERT INTO `employment_details` VALUES (1,1,'Part-time','Mr Client Ones','Technology','Software Engineer','456 Business Rd','67890','Business City','Business State','Business Country','2024-10-02 06:46:58','2024-10-02 01:42:43');
/*!40000 ALTER TABLE `employment_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
                               `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                               `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
                               `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
                               `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
                               `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
                               `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_beneficiaries`
--

DROP TABLE IF EXISTS `individual_beneficiaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_beneficiaries` (
                                            `id` bigint NOT NULL AUTO_INCREMENT,
                                            `client_id` bigint DEFAULT NULL,
                                            `guardian_id` bigint NOT NULL,
                                            `relationship_to_settlor` varchar(255) DEFAULT NULL,
                                            `full_name` varchar(255) DEFAULT NULL,
                                            `ic_passport` varchar(255) DEFAULT NULL,
                                            `dob` date DEFAULT NULL,
                                            `gender` enum('male','female') DEFAULT NULL,
                                            `nationality` varchar(255) DEFAULT NULL,
                                            `address` text,
                                            `postcode` varchar(255) DEFAULT NULL,
                                            `city` varchar(255) DEFAULT NULL,
                                            `state` varchar(255) DEFAULT NULL,
                                            `country` varchar(255) DEFAULT NULL,
                                            `residential_status` varchar(255) DEFAULT NULL,
                                            `marital_status` varchar(255) DEFAULT NULL,
                                            `mobile_number` varchar(255) DEFAULT NULL,
                                            `email` varchar(255) DEFAULT NULL,
                                            `ic_document_key` text,
                                            `address_proof_key` text,
                                            `created_at` timestamp NULL DEFAULT NULL,
                                            `updated_at` timestamp NULL DEFAULT NULL,
                                            PRIMARY KEY (`id`),
                                            KEY `guardian_id` (`guardian_id`),
                                            KEY `fk_beneficiary_client_id` (`client_id`),
                                            CONSTRAINT `fk_beneficiary_client_id` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`),
                                            CONSTRAINT `individual_beneficiaries_ibfk_2` FOREIGN KEY (`guardian_id`) REFERENCES `individual_guardian` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_beneficiaries`
--

LOCK TABLES `individual_beneficiaries` WRITE;
/*!40000 ALTER TABLE `individual_beneficiaries` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_beneficiaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_client_wealth_source`
--

DROP TABLE IF EXISTS `individual_client_wealth_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_client_wealth_source` (
                                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                                   `client_id` bigint DEFAULT NULL,
                                                   `annual_income_declaration` decimal(15,2) DEFAULT NULL,
                                                   `source_of_income` varchar(255) DEFAULT NULL,
                                                   `other_sources_of_income_remark` varchar(255) DEFAULT NULL,
                                                   `created_at` timestamp NULL DEFAULT NULL,
                                                   `updated_at` timestamp NULL DEFAULT NULL,
                                                   PRIMARY KEY (`id`),
                                                   KEY `fk_client_id` (`client_id`),
                                                   CONSTRAINT `fk_client_id` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_client_wealth_source`
--

LOCK TABLES `individual_client_wealth_source` WRITE;
/*!40000 ALTER TABLE `individual_client_wealth_source` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_client_wealth_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_guardian`
--

DROP TABLE IF EXISTS `individual_guardian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_guardian` (
                                       `id` bigint NOT NULL AUTO_INCREMENT,
                                       `beneficiary_id` bigint NOT NULL,
                                       `relationship_to_beneficiary` varchar(255) DEFAULT NULL,
                                       `full_name` varchar(255) DEFAULT NULL,
                                       `ic_passport` varchar(255) DEFAULT NULL,
                                       `dob` date DEFAULT NULL,
                                       `gender` enum('male','female') DEFAULT NULL,
                                       `nationality` varchar(255) DEFAULT NULL,
                                       `address` text,
                                       `postcode` varchar(255) DEFAULT NULL,
                                       `city` varchar(255) DEFAULT NULL,
                                       `state` varchar(255) DEFAULT NULL,
                                       `country` varchar(255) DEFAULT NULL,
                                       `residential_status` varchar(255) DEFAULT NULL,
                                       `marital_status` varchar(255) DEFAULT NULL,
                                       `mobile_number` varchar(255) DEFAULT NULL,
                                       `email` varchar(255) DEFAULT NULL,
                                       `ic_document_key` text,
                                       `address_proof_key` text,
                                       `created_at` timestamp NULL DEFAULT NULL,
                                       `updated_at` timestamp NULL DEFAULT NULL,
                                       PRIMARY KEY (`id`),
                                       KEY `beneficiary_id` (`beneficiary_id`),
                                       CONSTRAINT `individual_guardian_ibfk_1` FOREIGN KEY (`beneficiary_id`) REFERENCES `individual_beneficiaries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_guardian`
--

LOCK TABLES `individual_guardian` WRITE;
/*!40000 ALTER TABLE `individual_guardian` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_guardian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_pep_info`
--

DROP TABLE IF EXISTS `individual_pep_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_pep_info` (
                                       `id` bigint NOT NULL AUTO_INCREMENT,
                                       `client_id` bigint DEFAULT NULL,
                                       `pep` tinyint(1) DEFAULT NULL,
                                       `pep_type` enum('self','family','associate') DEFAULT NULL,
                                       `pep_immediate_family_name` varchar(255) DEFAULT NULL,
                                       `pep_position` varchar(255) DEFAULT NULL,
                                       `pep_organisation` varchar(255) DEFAULT NULL,
                                       `pep_supporting_documents_key` text,
                                       `created_at` timestamp NULL DEFAULT NULL,
                                       `updated_at` timestamp NULL DEFAULT NULL,
                                       PRIMARY KEY (`id`),
                                       KEY `fk_pep_status_client_id` (`client_id`),
                                       CONSTRAINT `fk_pep_status_client_id` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_pep_info`
--

LOCK TABLES `individual_pep_info` WRITE;
/*!40000 ALTER TABLE `individual_pep_info` DISABLE KEYS */;
INSERT INTO `individual_pep_info` VALUES (1,1,1,'self','John Does','Member of Parliament','Government of Example',NULL,'2024-10-02 08:41:16','2024-10-02 00:47:50');
/*!40000 ALTER TABLE `individual_pep_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_wealth_income`
--

DROP TABLE IF EXISTS `individual_wealth_income`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_wealth_income` (
                                            `id` bigint NOT NULL AUTO_INCREMENT,
                                            `client_id` bigint NOT NULL,
                                            `annual_income_declaration` varchar(255) NOT NULL,
                                            `source_of_income` varchar(255) NOT NULL,
                                            `source_of_income_remark` text,
                                            `created_at` timestamp NULL DEFAULT NULL,
                                            `updated_at` timestamp NULL DEFAULT NULL,
                                            PRIMARY KEY (`id`),
                                            KEY `client_id` (`client_id`),
                                            CONSTRAINT `individual_wealth_income_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_wealth_income`
--

LOCK TABLES `individual_wealth_income` WRITE;
/*!40000 ALTER TABLE `individual_wealth_income` DISABLE KEYS */;
INSERT INTO `individual_wealth_income` VALUES (1,1,'RM200,001 - RM300,000','Employment/Business Income','Shopee Reseller',NULL,'2024-10-02 01:41:12');
/*!40000 ALTER TABLE `individual_wealth_income` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_items` (
                              `id` int unsigned NOT NULL AUTO_INCREMENT,
                              `menu_id` int unsigned DEFAULT NULL,
                              `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
                              `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `parent_id` int DEFAULT NULL,
                              `order` int NOT NULL,
                              `created_at` timestamp NULL DEFAULT NULL,
                              `updated_at` timestamp NULL DEFAULT NULL,
                              `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                              `parameters` text COLLATE utf8mb4_unicode_ci,
                              PRIMARY KEY (`id`),
                              KEY `menu_items_menu_id_foreign` (`menu_id`),
                              CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_items`
--

LOCK TABLES `menu_items` WRITE;
/*!40000 ALTER TABLE `menu_items` DISABLE KEYS */;
INSERT INTO `menu_items` VALUES (1,1,'Dashboard','','_self','voyager-boat',NULL,NULL,1,'2024-09-25 19:11:15','2024-09-25 19:11:15','voyager.dashboard',NULL),(2,1,'Media','','_self','voyager-images',NULL,NULL,3,'2024-09-25 19:11:15','2024-09-25 22:14:26','voyager.media.index',NULL),(3,1,'CMS Users','','_self','voyager-people','#000000',16,2,'2024-09-25 19:11:16','2024-09-25 22:13:10','voyager.users.index','null'),(4,1,'Roles','','_self','voyager-lock',NULL,16,1,'2024-09-25 19:11:16','2024-09-25 22:12:32','voyager.roles.index',NULL),(5,1,'Tools','','_self','voyager-tools',NULL,NULL,7,'2024-09-25 19:11:16','2024-09-25 22:14:26',NULL,NULL),(6,1,'Menu Builder','','_self','voyager-list',NULL,5,1,'2024-09-25 19:11:16','2024-09-25 22:12:12','voyager.menus.index',NULL),(7,1,'Database','','_self','voyager-data',NULL,5,2,'2024-09-25 19:11:16','2024-09-25 22:12:12','voyager.database.index',NULL),(8,1,'Compass','','_self','voyager-compass',NULL,5,3,'2024-09-25 19:11:16','2024-09-25 22:12:12','voyager.compass.index',NULL),(9,1,'BREAD','','_self','voyager-bread',NULL,5,4,'2024-09-25 19:11:16','2024-09-25 22:12:12','voyager.bread.index',NULL),(10,1,'Settings','','_self','voyager-settings',NULL,NULL,8,'2024-09-25 19:11:16','2024-09-25 22:14:26','voyager.settings.index',NULL),(14,1,'Agent','','_self','voyager-list','#000000',17,1,'2024-09-25 20:34:58','2024-09-25 22:15:01','voyager.agent.index','null'),(15,1,'Clients','','_self','voyager-list','#000000',17,2,'2024-09-25 20:37:20','2024-09-25 22:15:11','voyager.client.index','null'),(16,1,'Admin','','_self','voyager-person','#000000',NULL,9,'2024-09-25 22:11:58','2024-09-25 22:14:27',NULL,''),(17,1,'App User','','_self','voyager-group','#000000',NULL,2,'2024-09-25 22:14:02','2024-09-25 22:14:14',NULL,''),(18,1,'Agencies','','_self',NULL,NULL,NULL,10,'2024-09-30 00:01:10','2024-09-30 00:01:10','voyager.agency.index',NULL),(19,1,'Product Types','','_self',NULL,NULL,NULL,11,'2024-09-30 00:12:49','2024-09-30 00:12:49','voyager.product-type.index',NULL),(20,1,'Products','','_self',NULL,NULL,NULL,12,'2024-09-30 00:26:47','2024-09-30 00:26:47','voyager.product.index',NULL),(21,1,'Document Types','','_self',NULL,NULL,NULL,13,'2024-09-30 00:39:39','2024-09-30 00:39:39','voyager.document-type.index',NULL),(22,1,'Product Agreements','','_self',NULL,NULL,NULL,14,'2024-09-30 00:51:50','2024-09-30 00:51:50','voyager.product-agreement.index',NULL),(23,1,'Product Order Individuals','','_self',NULL,NULL,NULL,15,'2024-09-30 01:42:56','2024-09-30 01:42:56','voyager.product-order-individual.index',NULL),(24,1,'Bank File Uploads','','_self',NULL,NULL,NULL,16,'2024-09-30 01:44:31','2024-09-30 01:44:31','voyager.bank-file-upload.index',NULL),(25,1,'Checkers','','_self',NULL,NULL,NULL,17,'2024-09-30 01:45:07','2024-09-30 01:45:07','voyager.checker.index',NULL),(26,1,'Approvers','','_self',NULL,NULL,NULL,18,'2024-09-30 01:45:20','2024-09-30 01:45:20','voyager.approver.index',NULL);
/*!40000 ALTER TABLE `menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menus` (
                         `id` int unsigned NOT NULL AUTO_INCREMENT,
                         `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `menus_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menus`
--

LOCK TABLES `menus` WRITE;
/*!40000 ALTER TABLE `menus` DISABLE KEYS */;
INSERT INTO `menus` VALUES (1,'admin','2024-09-25 19:11:15','2024-09-25 19:11:15');
/*!40000 ALTER TABLE `menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
                              `id` int unsigned NOT NULL AUTO_INCREMENT,
                              `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                              `batch` int NOT NULL,
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'2014_10_12_000000_create_users_table',1),(2,'2014_10_12_100000_create_password_resets_table',1),(3,'2016_01_01_000000_add_voyager_user_fields',1),(4,'2016_01_01_000000_create_data_types_table',1),(5,'2016_05_19_173453_create_menu_table',1),(6,'2016_10_21_190000_create_roles_table',1),(7,'2016_10_21_190000_create_settings_table',1),(8,'2016_11_30_135954_create_permission_table',1),(9,'2016_11_30_141208_create_permission_role_table',1),(10,'2016_12_26_201236_data_types__add__server_side',1),(11,'2017_01_13_000000_add_route_to_menu_items_table',1),(12,'2017_01_14_005015_create_translations_table',1),(13,'2017_01_15_000000_make_table_name_nullable_in_permissions_table',1),(14,'2017_03_06_000000_add_controller_to_data_types_table',1),(15,'2017_04_21_000000_add_order_to_data_rows_table',1),(16,'2017_07_05_210000_add_policyname_to_data_types_table',1),(17,'2017_08_05_000000_add_group_to_settings_table',1),(18,'2017_11_26_013050_add_user_role_relationship',1),(19,'2017_11_26_015000_create_user_roles_table',1),(20,'2018_03_11_000000_add_user_settings',1),(21,'2018_03_14_000000_add_details_to_data_types_table',1),(22,'2018_03_16_000000_make_settings_value_nullable',1),(23,'2019_08_19_000000_create_failed_jobs_table',1),(24,'2019_12_14_000001_create_personal_access_tokens_table',1),(25,'2016_01_01_000000_create_pages_table',2),(26,'2016_01_01_000000_create_posts_table',2),(27,'2016_02_15_204651_create_categories_table',2),(28,'2017_04_11_000000_alter_post_nullable_fields_table',2);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_resets`
--

DROP TABLE IF EXISTS `password_resets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_resets` (
                                   `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_resets`
--

LOCK TABLES `password_resets` WRITE;
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `user_id` bigint NOT NULL,
                           `amount` decimal(15,2) DEFAULT NULL,
                           `payment_method` enum('online_banking','manual_transfer') DEFAULT NULL,
                           `payment_status` enum('pending','completed','failed') DEFAULT NULL,
                           `bank_receipt` text,
                           `created_at` timestamp NULL DEFAULT NULL,
                           `updated_at` timestamp NULL DEFAULT NULL,
                           PRIMARY KEY (`id`),
                           KEY `user_id` (`user_id`),
                           CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user_details` (`app_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_transaction`
--

DROP TABLE IF EXISTS `payment_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_transaction` (
                                       `id` bigint NOT NULL AUTO_INCREMENT,
                                       `client_id` varchar(255) NOT NULL,
                                       `payment_type` enum('Manual','Online Banking') NOT NULL,
                                       `bank_trx_id` varchar(255) NOT NULL,
                                       `payment_method` varchar(255) NOT NULL,
                                       `transaction_type` enum('Debit','Credit') NOT NULL,
                                       `refer_to` varchar(255) DEFAULT NULL,
                                       `amount` decimal(10,2) NOT NULL,
                                       `status` enum('Success','Pending','Failed') NOT NULL,
                                       `status_remarks` text,
                                       `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                       `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_transaction`
--

LOCK TABLES `payment_transaction` WRITE;
/*!40000 ALTER TABLE `payment_transaction` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permission_role`
--

DROP TABLE IF EXISTS `permission_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permission_role` (
                                   `permission_id` bigint unsigned NOT NULL,
                                   `role_id` bigint unsigned NOT NULL,
                                   PRIMARY KEY (`permission_id`,`role_id`),
                                   KEY `permission_role_permission_id_index` (`permission_id`),
                                   KEY `permission_role_role_id_index` (`role_id`),
                                   CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
                                   CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permission_role`
--

LOCK TABLES `permission_role` WRITE;
/*!40000 ALTER TABLE `permission_role` DISABLE KEYS */;
INSERT INTO `permission_role` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1),(10,1),(11,1),(12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(24,1),(25,1),(41,1),(46,1),(51,1),(52,1),(53,1),(54,1),(55,1),(56,1),(57,1),(58,1),(59,1),(60,1),(61,1),(62,1),(63,1),(64,1),(65,1),(66,1),(67,1),(68,1),(69,1),(70,1),(71,1),(72,1),(73,1),(74,1),(75,1),(76,1),(77,1),(78,1),(79,1),(80,1),(81,1),(82,1),(83,1),(84,1),(85,1),(86,1),(87,1),(88,1),(89,1),(90,1),(91,1),(92,1),(93,1),(94,1),(95,1);
/*!40000 ALTER TABLE `permission_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `permissions` (
                               `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                               `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                               `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                               `created_at` timestamp NULL DEFAULT NULL,
                               `updated_at` timestamp NULL DEFAULT NULL,
                               PRIMARY KEY (`id`),
                               KEY `permissions_key_index` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'browse_admin',NULL,'2024-09-25 19:11:16','2024-09-25 19:11:16'),(2,'browse_bread',NULL,'2024-09-25 19:11:16','2024-09-25 19:11:16'),(3,'browse_database',NULL,'2024-09-25 19:11:16','2024-09-25 19:11:16'),(4,'browse_media',NULL,'2024-09-25 19:11:16','2024-09-25 19:11:16'),(5,'browse_compass',NULL,'2024-09-25 19:11:16','2024-09-25 19:11:16'),(6,'browse_menus','menus','2024-09-25 19:11:16','2024-09-25 19:11:16'),(7,'read_menus','menus','2024-09-25 19:11:16','2024-09-25 19:11:16'),(8,'edit_menus','menus','2024-09-25 19:11:16','2024-09-25 19:11:16'),(9,'add_menus','menus','2024-09-25 19:11:16','2024-09-25 19:11:16'),(10,'delete_menus','menus','2024-09-25 19:11:16','2024-09-25 19:11:16'),(11,'browse_roles','roles','2024-09-25 19:11:16','2024-09-25 19:11:16'),(12,'read_roles','roles','2024-09-25 19:11:16','2024-09-25 19:11:16'),(13,'edit_roles','roles','2024-09-25 19:11:16','2024-09-25 19:11:16'),(14,'add_roles','roles','2024-09-25 19:11:16','2024-09-25 19:11:16'),(15,'delete_roles','roles','2024-09-25 19:11:16','2024-09-25 19:11:16'),(16,'browse_users','users','2024-09-25 19:11:16','2024-09-25 19:11:16'),(17,'read_users','users','2024-09-25 19:11:16','2024-09-25 19:11:16'),(18,'edit_users','users','2024-09-25 19:11:16','2024-09-25 19:11:16'),(19,'add_users','users','2024-09-25 19:11:16','2024-09-25 19:11:16'),(20,'delete_users','users','2024-09-25 19:11:16','2024-09-25 19:11:16'),(21,'browse_settings','settings','2024-09-25 19:11:16','2024-09-25 19:11:16'),(22,'read_settings','settings','2024-09-25 19:11:16','2024-09-25 19:11:16'),(23,'edit_settings','settings','2024-09-25 19:11:16','2024-09-25 19:11:16'),(24,'add_settings','settings','2024-09-25 19:11:16','2024-09-25 19:11:16'),(25,'delete_settings','settings','2024-09-25 19:11:16','2024-09-25 19:11:16'),(41,'browse_agent','agent','2024-09-25 20:34:58','2024-09-25 20:34:58'),(42,'read_agent','agent','2024-09-25 20:34:58','2024-09-25 20:34:58'),(43,'edit_agent','agent','2024-09-25 20:34:58','2024-09-25 20:34:58'),(44,'add_agent','agent','2024-09-25 20:34:58','2024-09-25 20:34:58'),(45,'delete_agent','agent','2024-09-25 20:34:58','2024-09-25 20:34:58'),(46,'browse_client','client','2024-09-25 20:37:20','2024-09-25 20:37:20'),(47,'read_client','client','2024-09-25 20:37:20','2024-09-25 20:37:20'),(48,'edit_client','client','2024-09-25 20:37:20','2024-09-25 20:37:20'),(49,'add_client','client','2024-09-25 20:37:20','2024-09-25 20:37:20'),(50,'delete_client','client','2024-09-25 20:37:20','2024-09-25 20:37:20'),(51,'browse_agency','agency','2024-09-30 00:01:10','2024-09-30 00:01:10'),(52,'read_agency','agency','2024-09-30 00:01:10','2024-09-30 00:01:10'),(53,'edit_agency','agency','2024-09-30 00:01:10','2024-09-30 00:01:10'),(54,'add_agency','agency','2024-09-30 00:01:10','2024-09-30 00:01:10'),(55,'delete_agency','agency','2024-09-30 00:01:10','2024-09-30 00:01:10'),(56,'browse_product_type','product_type','2024-09-30 00:12:49','2024-09-30 00:12:49'),(57,'read_product_type','product_type','2024-09-30 00:12:49','2024-09-30 00:12:49'),(58,'edit_product_type','product_type','2024-09-30 00:12:49','2024-09-30 00:12:49'),(59,'add_product_type','product_type','2024-09-30 00:12:49','2024-09-30 00:12:49'),(60,'delete_product_type','product_type','2024-09-30 00:12:49','2024-09-30 00:12:49'),(61,'browse_product','product','2024-09-30 00:26:47','2024-09-30 00:26:47'),(62,'read_product','product','2024-09-30 00:26:47','2024-09-30 00:26:47'),(63,'edit_product','product','2024-09-30 00:26:47','2024-09-30 00:26:47'),(64,'add_product','product','2024-09-30 00:26:47','2024-09-30 00:26:47'),(65,'delete_product','product','2024-09-30 00:26:47','2024-09-30 00:26:47'),(66,'browse_document_type','document_type','2024-09-30 00:39:39','2024-09-30 00:39:39'),(67,'read_document_type','document_type','2024-09-30 00:39:39','2024-09-30 00:39:39'),(68,'edit_document_type','document_type','2024-09-30 00:39:39','2024-09-30 00:39:39'),(69,'add_document_type','document_type','2024-09-30 00:39:39','2024-09-30 00:39:39'),(70,'delete_document_type','document_type','2024-09-30 00:39:39','2024-09-30 00:39:39'),(71,'browse_product_agreement','product_agreement','2024-09-30 00:51:50','2024-09-30 00:51:50'),(72,'read_product_agreement','product_agreement','2024-09-30 00:51:50','2024-09-30 00:51:50'),(73,'edit_product_agreement','product_agreement','2024-09-30 00:51:50','2024-09-30 00:51:50'),(74,'add_product_agreement','product_agreement','2024-09-30 00:51:50','2024-09-30 00:51:50'),(75,'delete_product_agreement','product_agreement','2024-09-30 00:51:50','2024-09-30 00:51:50'),(76,'browse_product_order_individual','product_order_individual','2024-09-30 01:42:56','2024-09-30 01:42:56'),(77,'read_product_order_individual','product_order_individual','2024-09-30 01:42:56','2024-09-30 01:42:56'),(78,'edit_product_order_individual','product_order_individual','2024-09-30 01:42:56','2024-09-30 01:42:56'),(79,'add_product_order_individual','product_order_individual','2024-09-30 01:42:56','2024-09-30 01:42:56'),(80,'delete_product_order_individual','product_order_individual','2024-09-30 01:42:56','2024-09-30 01:42:56'),(81,'browse_bank_file_upload','bank_file_upload','2024-09-30 01:44:31','2024-09-30 01:44:31'),(82,'read_bank_file_upload','bank_file_upload','2024-09-30 01:44:31','2024-09-30 01:44:31'),(83,'edit_bank_file_upload','bank_file_upload','2024-09-30 01:44:31','2024-09-30 01:44:31'),(84,'add_bank_file_upload','bank_file_upload','2024-09-30 01:44:31','2024-09-30 01:44:31'),(85,'delete_bank_file_upload','bank_file_upload','2024-09-30 01:44:31','2024-09-30 01:44:31'),(86,'browse_checker','checker','2024-09-30 01:45:07','2024-09-30 01:45:07'),(87,'read_checker','checker','2024-09-30 01:45:07','2024-09-30 01:45:07'),(88,'edit_checker','checker','2024-09-30 01:45:07','2024-09-30 01:45:07'),(89,'add_checker','checker','2024-09-30 01:45:07','2024-09-30 01:45:07'),(90,'delete_checker','checker','2024-09-30 01:45:07','2024-09-30 01:45:07'),(91,'browse_approver','approver','2024-09-30 01:45:20','2024-09-30 01:45:20'),(92,'read_approver','approver','2024-09-30 01:45:20','2024-09-30 01:45:20'),(93,'edit_approver','approver','2024-09-30 01:45:20','2024-09-30 01:45:20'),(94,'add_approver','approver','2024-09-30 01:45:20','2024-09-30 01:45:20'),(95,'delete_approver','approver','2024-09-30 01:45:20','2024-09-30 01:45:20');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
                                          `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                                          `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `tokenable_id` bigint unsigned NOT NULL,
                                          `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
                                          `abilities` text COLLATE utf8mb4_unicode_ci,
                                          `last_used_at` timestamp NULL DEFAULT NULL,
                                          `created_at` timestamp NULL DEFAULT NULL,
                                          `updated_at` timestamp NULL DEFAULT NULL,
                                          PRIMARY KEY (`id`),
                                          UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
                                          KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
                           `id` bigint NOT NULL AUTO_INCREMENT,
                           `product_name` varchar(255) NOT NULL,
                           `product_type_id` bigint NOT NULL,
                           `product_description` text,
                           `dividend_rate` int DEFAULT NULL,
                           `incremental` double DEFAULT NULL,
                           `investment_tenure_month` int DEFAULT NULL,
                           `risk_level` enum('high','medium','low') DEFAULT NULL,
                           `product_agreement_id` bigint NOT NULL,
                           `product_catalogue_url` text,
                           `image_of_product_url` text,
                           `status` enum('active','inactive') NOT NULL,
                           `display_on_app` tinyint(1) DEFAULT '1',
                           `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                           `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_agreement`
--

DROP TABLE IF EXISTS `product_agreement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_agreement` (
                                     `id` bigint NOT NULL AUTO_INCREMENT,
                                     `document_type_id` bigint NOT NULL,
                                     `name` varchar(255) NOT NULL,
                                     `description` text,
                                     `upload_document` text,
                                     `document_editor` text,
                                     `valid_from` date DEFAULT NULL,
                                     `valid_until` date DEFAULT NULL,
                                     `status` tinyint(1) NOT NULL DEFAULT '1',
                                     `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                     `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                     `use_document_editor` tinyint(1) DEFAULT '0',
                                     PRIMARY KEY (`id`),
                                     KEY `document_type_id` (`document_type_id`),
                                     CONSTRAINT `product_agreement_ibfk_1` FOREIGN KEY (`document_type_id`) REFERENCES `document_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_agreement`
--

LOCK TABLES `product_agreement` WRITE;
/*!40000 ALTER TABLE `product_agreement` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_agreement` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_order_individual`
--

DROP TABLE IF EXISTS `product_order_individual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_order_individual` (
                                            `id` bigint NOT NULL AUTO_INCREMENT,
                                            `client_id` bigint NOT NULL,
                                            `product_id` bigint NOT NULL,
                                            `user_detail_id` bigint NOT NULL,
                                            `referral_code_agent` varchar(255) DEFAULT NULL,
                                            `employment_details_id` bigint DEFAULT NULL,
                                            `individual_pep_status_id` bigint DEFAULT NULL,
                                            `bank_details_id` bigint DEFAULT NULL,
                                            `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                            `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                            PRIMARY KEY (`id`),
                                            KEY `client_id` (`client_id`),
                                            KEY `product_id` (`product_id`),
                                            KEY `user_detail_id` (`user_detail_id`),
                                            KEY `employment_details_id` (`employment_details_id`),
                                            KEY `individual_pep_status_id` (`individual_pep_status_id`),
                                            KEY `bank_details_id` (`bank_details_id`),
                                            CONSTRAINT `product_order_individual_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE,
                                            CONSTRAINT `product_order_individual_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
                                            CONSTRAINT `product_order_individual_ibfk_3` FOREIGN KEY (`user_detail_id`) REFERENCES `user_details` (`id`) ON DELETE CASCADE,
                                            CONSTRAINT `product_order_individual_ibfk_4` FOREIGN KEY (`employment_details_id`) REFERENCES `employment_details` (`id`) ON DELETE SET NULL,
                                            CONSTRAINT `product_order_individual_ibfk_5` FOREIGN KEY (`individual_pep_status_id`) REFERENCES `individual_pep_info` (`id`) ON DELETE SET NULL,
                                            CONSTRAINT `product_order_individual_ibfk_6` FOREIGN KEY (`bank_details_id`) REFERENCES `bank_details` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_order_individual`
--

LOCK TABLES `product_order_individual` WRITE;
/*!40000 ALTER TABLE `product_order_individual` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_order_individual` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_type`
--

DROP TABLE IF EXISTS `product_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_type` (
                                `id` bigint NOT NULL AUTO_INCREMENT,
                                `product_type_name` varchar(255) NOT NULL,
                                `image` varchar(255) DEFAULT NULL,
                                `status` enum('active','inactive') DEFAULT 'active',
                                `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
                                `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_type`
--

LOCK TABLES `product_type` WRITE;
/*!40000 ALTER TABLE `product_type` DISABLE KEYS */;
INSERT INTO `product_type` VALUES (1,'tttt','ttt','active','2024-09-30 18:30:05','2024-09-30 18:30:05');
/*!40000 ALTER TABLE `product_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
                         `id` bigint unsigned NOT NULL AUTO_INCREMENT,
                         `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                         `created_at` timestamp NULL DEFAULT NULL,
                         `updated_at` timestamp NULL DEFAULT NULL,
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'admin','Administrator','2024-09-25 19:11:16','2024-09-25 19:11:16'),(2,'user','Normal User','2024-09-25 19:11:16','2024-09-25 19:11:16');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
                            `id` int unsigned NOT NULL AUTO_INCREMENT,
                            `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
                            `details` text COLLATE utf8mb4_unicode_ci,
                            `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                            `order` int NOT NULL DEFAULT '1',
                            `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `settings_key_unique` (`key`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES (1,'site.title','Site Title','Site Title','','text',1,'Site'),(2,'site.description','Site Description','Site Description','','text',2,'Site'),(3,'site.logo','Site Logo','','','image',3,'Site'),(4,'site.google_analytics_tracking_id','Google Analytics Tracking ID','','','text',4,'Site'),(5,'admin.bg_image','Admin Background Image','','','image',5,'Admin'),(6,'admin.title','Admin Title','Voyager','','text',1,'Admin'),(7,'admin.description','Admin Description','Welcome to Voyager. The Missing Admin for Laravel','','text',2,'Admin'),(8,'admin.loader','Admin Loader','','','image',3,'Admin'),(9,'admin.icon_image','Admin Icon Image','','','image',4,'Admin'),(10,'admin.google_analytics_client_id','Google Analytics Client ID (used for admin dashboard)','','','text',1,'Admin');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sign_up_history`
--

DROP TABLE IF EXISTS `sign_up_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sign_up_history` (
                                   `id` bigint NOT NULL AUTO_INCREMENT,
                                   `user_type` enum('corporate_client','agent','client') NOT NULL,
                                   `agency_type` enum('citadel','other') DEFAULT NULL,
                                   `full_name` varchar(255) NOT NULL,
                                   `identity_card_number` varchar(255) NOT NULL,
                                   `dob` timestamp NOT NULL,
                                   `address` varchar(255) DEFAULT NULL,
                                   `postcode` varchar(255) DEFAULT NULL,
                                   `city` varchar(255) DEFAULT NULL,
                                   `state` varchar(255) DEFAULT NULL,
                                   `country` varchar(255) DEFAULT NULL,
                                   `country_code` varchar(255) NOT NULL,
                                   `mobile_number` varchar(255) NOT NULL,
                                   `marital_status` varchar(255) DEFAULT NULL,
                                   `email` varchar(255) NOT NULL,
                                   `referral_code_agent` varchar(255) DEFAULT NULL,
                                   `identity_card_image_key` text,
                                   `selfie_image_key` text,
                                   `digital_signature_key` text,
                                   `pep` tinyint(1) DEFAULT NULL,
                                   `pep_type` enum('self','family','associate') DEFAULT NULL,
                                   `pep_immediate_family_name` varchar(255) DEFAULT NULL,
                                   `pep_position` varchar(255) DEFAULT NULL,
                                   `pep_organisation` varchar(255) DEFAULT NULL,
                                   `pep_supporting_documents_key` text,
                                   `employment_type` varchar(255) DEFAULT NULL,
                                   `employer_name` varchar(255) DEFAULT NULL,
                                   `industry_type` varchar(255) DEFAULT NULL,
                                   `job_title` varchar(255) DEFAULT NULL,
                                   `employer_address` varchar(255) DEFAULT NULL,
                                   `employer_postcode` varchar(255) DEFAULT NULL,
                                   `employer_city` varchar(255) DEFAULT NULL,
                                   `employer_state` varchar(255) DEFAULT NULL,
                                   `employer_country` varchar(255) DEFAULT NULL,
                                   `agency_code` varchar(255) DEFAULT NULL,
                                   `agency_name` varchar(255) DEFAULT NULL,
                                   `recruit_manager` varchar(255) DEFAULT NULL,
                                   `bank_name` varchar(255) DEFAULT NULL,
                                   `bank_address` varchar(255) DEFAULT NULL,
                                   `swift_code` varchar(255) DEFAULT NULL,
                                   `account_holder_name` varchar(255) DEFAULT NULL,
                                   `account_number` varchar(255) DEFAULT NULL,
                                   `proof_of_bank_account_key` varchar(255) DEFAULT NULL,
                                   `created_at` timestamp NULL DEFAULT NULL,
                                   `updated_at` timestamp NULL DEFAULT NULL,
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sign_up_history`
--

LOCK TABLES `sign_up_history` WRITE;
/*!40000 ALTER TABLE `sign_up_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `sign_up_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `translations`
--

DROP TABLE IF EXISTS `translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `translations` (
                                `id` int unsigned NOT NULL AUTO_INCREMENT,
                                `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `foreign_key` int unsigned NOT NULL,
                                `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
                                `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
                                `created_at` timestamp NULL DEFAULT NULL,
                                `updated_at` timestamp NULL DEFAULT NULL,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `translations`
--

LOCK TABLES `translations` WRITE;
/*!40000 ALTER TABLE `translations` DISABLE KEYS */;
INSERT INTO `translations` VALUES (1,'data_types','display_name_singular',5,'pt','Post','2024-09-25 19:12:42','2024-09-25 19:12:42'),(2,'data_types','display_name_singular',6,'pt','Página','2024-09-25 19:12:42','2024-09-25 19:12:42'),(3,'data_types','display_name_singular',1,'pt','Utilizador','2024-09-25 19:12:42','2024-09-25 19:12:42'),(4,'data_types','display_name_singular',4,'pt','Categoria','2024-09-25 19:12:42','2024-09-25 19:12:42'),(5,'data_types','display_name_singular',2,'pt','Menu','2024-09-25 19:12:42','2024-09-25 19:12:42'),(6,'data_types','display_name_singular',3,'pt','Função','2024-09-25 19:12:42','2024-09-25 19:12:42'),(7,'data_types','display_name_plural',5,'pt','Posts','2024-09-25 19:12:42','2024-09-25 19:12:42'),(8,'data_types','display_name_plural',6,'pt','Páginas','2024-09-25 19:12:42','2024-09-25 19:12:42'),(9,'data_types','display_name_plural',1,'pt','Utilizadores','2024-09-25 19:12:42','2024-09-25 19:12:42'),(10,'data_types','display_name_plural',4,'pt','Categorias','2024-09-25 19:12:42','2024-09-25 19:12:42'),(11,'data_types','display_name_plural',2,'pt','Menus','2024-09-25 19:12:42','2024-09-25 19:12:42'),(12,'data_types','display_name_plural',3,'pt','Funções','2024-09-25 19:12:42','2024-09-25 19:12:42'),(13,'categories','slug',1,'pt','categoria-1','2024-09-25 19:12:42','2024-09-25 19:12:42'),(14,'categories','name',1,'pt','Categoria 1','2024-09-25 19:12:42','2024-09-25 19:12:42'),(15,'categories','slug',2,'pt','categoria-2','2024-09-25 19:12:42','2024-09-25 19:12:42'),(16,'categories','name',2,'pt','Categoria 2','2024-09-25 19:12:42','2024-09-25 19:12:42'),(17,'pages','title',1,'pt','Olá Mundo','2024-09-25 19:12:42','2024-09-25 19:12:42'),(18,'pages','slug',1,'pt','ola-mundo','2024-09-25 19:12:42','2024-09-25 19:12:42'),(19,'pages','body',1,'pt','<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>','2024-09-25 19:12:42','2024-09-25 19:12:42'),(20,'menu_items','title',1,'pt','Painel de Controle','2024-09-25 19:12:42','2024-09-25 19:12:42'),(21,'menu_items','title',2,'pt','Media','2024-09-25 19:12:42','2024-09-25 19:12:42'),(22,'menu_items','title',12,'pt','Publicações','2024-09-25 19:12:42','2024-09-25 19:12:42'),(23,'menu_items','title',3,'pt','Utilizadores','2024-09-25 19:12:42','2024-09-25 19:12:42'),(24,'menu_items','title',11,'pt','Categorias','2024-09-25 19:12:42','2024-09-25 19:12:42'),(25,'menu_items','title',13,'pt','Páginas','2024-09-25 19:12:42','2024-09-25 19:12:42'),(26,'menu_items','title',4,'pt','Funções','2024-09-25 19:12:42','2024-09-25 19:12:42'),(27,'menu_items','title',5,'pt','Ferramentas','2024-09-25 19:12:42','2024-09-25 19:12:42'),(28,'menu_items','title',6,'pt','Menus','2024-09-25 19:12:42','2024-09-25 19:12:42'),(29,'menu_items','title',7,'pt','Base de dados','2024-09-25 19:12:42','2024-09-25 19:12:42'),(30,'menu_items','title',10,'pt','Configurações','2024-09-25 19:12:42','2024-09-25 19:12:42');
/*!40000 ALTER TABLE `translations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_user_id` bigint DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `ic_passport` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `postcode` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `full_name_of_immediate_family` varchar(255) DEFAULT NULL,
  `country_code` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `resident_status` enum('resident','non-resident') DEFAULT NULL,
  `marital_status` enum('single','married') DEFAULT NULL,
  `ic_document` text,
  `selfie_document` text,
  `proof_of_address` text,
  `onboarding_agreement` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`app_user_id`),
  CONSTRAINT `user_details_ibfk_1` FOREIGN KEY (`app_user_id`) REFERENCES `app_users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_details`
--

LOCK TABLES `user_details` WRITE;
/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
INSERT INTO `user_details` VALUES (1,1,'Agent 1','01123456789','agent1@example.com','952111115509','321 Street','54321','City D','State D','Country D',NULL,'MY','1996-02-11','male','Malaysian','resident','single',NULL,NULL,NULL,NULL,'2024-09-26 10:04:43','2024-10-02 00:02:07'),(2,2,'Agent Two','9876543210',NULL,'B7654321','456 Avenue','67890','City B','State B','Country B',NULL,'MY','1991-02-02','female','Malaysian','resident','married',NULL,NULL,NULL,NULL,'2024-09-26 10:04:43','2024-09-26 10:04:43'),(3,3,'Agent Three','0192837465',NULL,'C1928374','789 Boulevard','13579','City C','State C','Country C',NULL,'MY','1992-03-03','male','Malaysian','resident','single',NULL,NULL,NULL,NULL,'2024-09-26 10:04:43','2024-09-26 10:04:43'),(4,4,'Client Ones','01123456789','client1@example.com','D1234567','321 Street','54321','City D','State D','Country D',NULL,'MY','1995-01-01','female','Malaysian','resident','single',NULL,NULL,NULL,NULL,'2024-10-02 04:31:26','2024-10-02 00:01:27'),(5,5,'Client Two','01234567890','client2@example.com','E7654321','654 Avenue','67890','City E','State E','Country E',NULL,'MY','1996-02-02','male','Malaysian','resident','married',NULL,NULL,NULL,NULL,'2024-10-02 04:31:26','2024-10-02 04:31:26'),(6,6,'Client Three','01345678901','client3@example.com','F1928374','987 Boulevard','13579','City F','State F','Country F',NULL,'MY','1997-03-03','female','Malaysian','resident','single',NULL,NULL,NULL,NULL,'2024-10-02 04:31:26','2024-10-02 04:31:26');
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_roles` (
  `user_id` bigint unsigned NOT NULL,
  `role_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `user_roles_user_id_index` (`user_id`),
  KEY `user_roles_role_id_index` (`role_id`),
  CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Admin','admin@admin.com','users/default.png',NULL,'$2y$10$pBR7GpSVCYPyOummIp56/O5EbQL8xf0fGBsFOjClgRGYb1lNxyHZq','TSctcsgO3HIy82zzfGXbhkPjAw53C8KyMM4bIbPkXrKrKxDeGyoZmdvkIzHS',NULL,'2024-09-25 19:12:42','2024-09-25 19:12:42');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-10-03 15:11:01
