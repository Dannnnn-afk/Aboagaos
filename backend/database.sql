/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Create database
CREATE DATABASE IF NOT EXISTS aboagaos_db;

USE aboagaos_db;

--
-- Table structure for table `tipo`
--

DROP TABLE IF EXISTS `tipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipo` (
  `tipo_id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipo`
--

LOCK TABLES `tipo` WRITE;
/*!40000 ALTER TABLE `tipo` DISABLE KEYS */;
INSERT INTO `tipo` VALUES (1,'civil'),(2,'mercantil'),(3,'penal');
/*!40000 ALTER TABLE `tipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `priority`
--

DROP TABLE IF EXISTS `priority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `priority` (
  `priority_id` int(11) NOT NULL AUTO_INCREMENT,
  `priority_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`priority_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `priority`
--

LOCK TABLES `priority` WRITE;
/*!40000 ALTER TABLE `priority` DISABLE KEYS */;
INSERT INTO `priority` VALUES (1,'Muy alta'),(2,'Alta'),(3,'Media'),(4,'Baja'),(5,'Muy baja');
/*!40000 ALTER TABLE `priority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `estado_id` int(11) NOT NULL AUTO_INCREMENT,
  `estado_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`estado_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES (1,'placeholder_1'),(2,'placeholder_2'),(3,'placeholder_3'),(4,'placeholder_4'),(5,'placeholder_5');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `intent`
--

DROP TABLE IF EXISTS `intent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intent` (
  `intent_id` int(11) NOT NULL AUTO_INCREMENT,
  `intent_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`intent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `intent`
--

LOCK TABLES `intent` WRITE;
/*!40000 ALTER TABLE `intent` DISABLE KEYS */;
INSERT INTO `intent` VALUES (1,'reconciliar'),(2,'demandar'),(3,'placeholder_A'),(4,'placeholder_B'),(5,'placeholder_C');
/*!40000 ALTER TABLE `intent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'México'),(2,'Estados Unidos') ;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `region`
--

DROP TABLE IF EXISTS `region`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `region` (
  `region_id` int(11) NOT NULL AUTO_INCREMENT,
  `region_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `country_id_fk` int(11) DEFAULT NULL,
  FOREIGN KEY (country_id_fk) REFERENCES country(country_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `region`
--

LOCK TABLES `region` WRITE;
/*!40000 ALTER TABLE `region` DISABLE KEYS */;
INSERT INTO `region` VALUES (1,'Jalisco',1),(2,'Colima',1),(3,'Guanajuato',1),(4,'California',2) ;
/*!40000 ALTER TABLE `region` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `city`
--

DROP TABLE IF EXISTS `city`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `city` (
  `city_id` int(11) NOT NULL AUTO_INCREMENT,
  `city_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `region_id_fk` int(11) DEFAULT NULL,
  FOREIGN KEY (region_id_fk) REFERENCES region(region_id) 
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
  PRIMARY KEY (`city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `city`
--

LOCK TABLES `city` WRITE;
/*!40000 ALTER TABLE `city` DISABLE KEYS */;
INSERT INTO `city` VALUES (1,'Guadalajara',1),(2,'Zapopan',1),(3,'Bakersfield',4),(4,'Tonalá',1) ;
/*!40000 ALTER TABLE `city` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `usuario_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_email` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `usuario_password` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `usuario_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `usuario_phone` varchar(15) NOT NULL DEFAULT '0',
  PRIMARY KEY (`usuario_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'corre1@correo.com','blabla','Erasmo','9189677889'),(2,'correo2@correo.com','sabe','Pedro','9289677889'),(3,'correo3@correo.com','nose','Ana Bertha','9389677889'),(4,'correo4@correo.com','sepa','Gabriela','9489677889');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

---
-- Table structure for table `abogado`
--

DROP TABLE IF EXISTS `abogado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `abogado` (
  `abogado_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `abogado_email` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `abogado_password` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `abogado_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `abogado_phone` varchar(15) NOT NULL DEFAULT '0',
  `abogado_username` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `abogado_ranking` int(10) unsigned NOT NULL DEFAULT '0',

  PRIMARY KEY (`abogado_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `abogado`
--

LOCK TABLES `abogado` WRITE;
/*!40000 ALTER TABLE `abogado` DISABLE KEYS */;
INSERT INTO `abogado` VALUES (1,'corre1@correocheck.com','blabla','Irasmo','9089673879', 'IrasmoXD', 10 ),(2,'correo2@correocheck.com','sabe','Chuy','9089377879', 'Chuyon', 7),(3,'correo3@correocheck.com','nose','Ana Berthita','9089617879', 'JesusEsAmor', 9 ),(4,'correo4@correocheck.com','sepa','Gerardo','9389677879', 'Gerardo69', 4 );
/*!40000 ALTER TABLE `abogado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `caso`
--

DROP TABLE IF EXISTS `caso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caso` (
  `caso_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `caso_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `caso_conflicto` text COLLATE utf8_spanish_ci,
  `caso_contraparte` text COLLATE utf8_spanish_ci,
  `caso_hechos` text COLLATE utf8_spanish_ci,
  `caso_objetivo` text COLLATE utf8_spanish_ci,
  `caso_condiciones` text COLLATE utf8_spanish_ci,
  `tipo_id_fk` int(11) unsigned DEFAULT NULL,
  `priority_id_fk` int(11) unsigned DEFAULT NULL,
  `intent_id_fk` int(11) unsigned DEFAULT NULL,
  `estado_id_fk` int(11) unsigned DEFAULT NULL,
  FOREIGN KEY (tipo_id_fk) REFERENCES tipo(tipo_id) 
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  
  FOREIGN KEY (priority_id_fk) REFERENCES priority(priority_id)
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  
  FOREIGN KEY (intent_id_fk) REFERENCES intent(intent_id) 
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  
  FOREIGN KEY (estado_id_fk) REFERENCES estado(estado_id)
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  
  PRIMARY KEY (`caso_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caso`
--

LOCK TABLES `caso` WRITE;
/*!40000 ALTER TABLE `caso` DISABLE KEYS */;
INSERT INTO `caso` VALUES (1,'Demanda por: Faux pas','Je sais quoi dire','Ils sont tres mechant','sai pas','Fini mon souffrance sil te plait ', 'Je veux juste les demander un peu de fric ',1,1,2,2),(2,'Demanda por: Ich weiss es nicht','Ich weiss es nicht was ich sagen sollte','Er will mich umbringen ','Entscheidung','Ich werde dieses rechtsanwalt nicht verbieten','Naja',2,2,1,1) ;
/*!40000 ALTER TABLE `caso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fecha_imp`
--

DROP TABLE IF EXISTS `fecha_imp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fecha_imp` (
  `fecha_imp_id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_imp_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `fecha_imp` date NOT NULL,
  `caso_id_fk` int(11) DEFAULT NULL,
  FOREIGN KEY (caso_id_fk) REFERENCES caso(caso_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
  PRIMARY KEY (`fecha_imp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fecha_imp`
--

LOCK TABLES `fecha_imp` WRITE;
/*!40000 ALTER TABLE `fecha_imp` DISABLE KEYS */;
INSERT INTO `fecha_imp` VALUES (1,'evicción','2023-10-23',1),(2,'confrontación','2022-10-23',1),(3,'placeholder_A','2021-10-23',2),(4,'placeholder_B','2022-10-23',2),(5,'placeholder_C','2024-11-23',2);
/*!40000 ALTER TABLE `fecha_imp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `status_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `status_fecha` date NOT NULL,
  `caso_id_fk` int(11) DEFAULT NULL,
  FOREIGN KEY (caso_id_fk) REFERENCES caso(caso_id) 
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'En espera','2023-10-23',1),(2,'Asignado','2022-03-23',1),(3,'En revisión','2021-03-25',2),(4,'En proceso','2022-01-23',2),(5,'Resuelto','2024-02-23',2);
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documento`
--

DROP TABLE IF EXISTS `documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documento` (
  `documento_id` int(11) NOT NULL AUTO_INCREMENT,
  `documento_name` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `documento_link` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `caso_id_fk` int(11) DEFAULT NULL,
  FOREIGN KEY (caso_id_fk) REFERENCES caso(caso_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  
  PRIMARY KEY (`documento_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documento`
--

LOCK TABLES `documento` WRITE;
/*!40000 ALTER TABLE `documento` DISABLE KEYS */;
INSERT INTO `documento` VALUES (1,'Acta','link_placeholder_1',1),(2,'RFC','link_placeholder_2',1),(3,'CURP','link_placeholder_3',2),(4,'Defunción','link_placeholder_4',2),(5,'Seguro social','link_placeholder_5',2);
/*!40000 ALTER TABLE `documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `testigo`
--

DROP TABLE IF EXISTS `testigo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `testigo` (
  `testigo_id` int(11) NOT NULL AUTO_INCREMENT,
  `testigo_name` varchar(60) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `testigo_calle` varchar(60) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  `testigo_postal_code` varchar(10) NOT NULL DEFAULT '0',
  `testigo_phone` varchar(15) NOT NULL DEFAULT '0',
  `caso_id_fk` int(11) DEFAULT NULL,
  `country_id_fk` int(11) DEFAULT NULL,
  FOREIGN KEY (caso_id_fk) REFERENCES caso(caso_id)
  ON DELETE CASCADE
  ON UPDATE CASCADE,
  FOREIGN KEY (country_id_fk) REFERENCES country(country_id) 
  ON DELETE SET NULL
  ON UPDATE CASCADE,
  
  PRIMARY KEY (`testigo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `testigo`
--

LOCK TABLES `testigo` WRITE;
/*!40000 ALTER TABLE `testigo` DISABLE KEYS */;
INSERT INTO `testigo` VALUES (1,'Juanita','Calle durazno #65','45809','3389675534',1,1),(2,'Juan','Calle melocotón #63','45609','3489675534',1,1),(3,'Pedro','Holly St #45','43809','3589675534',2,2),(4,'Ana','Calle cardamomo #61','46809','3789675534',2,1),(5,'Pedrito','Calle cardamomo #61','55809','3989675534',2,1);
/*!40000 ALTER TABLE `testigo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `team_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `abogado_id_fk` int(11) DEFAULT NULL,
  `caso_id_fk` int(11) DEFAULT NULL,
   FOREIGN KEY (abogado_id_fk) REFERENCES abogado(abogado_id)
   ON DELETE SET NULL
   ON UPDATE CASCADE,
   FOREIGN KEY (caso_id_fk) REFERENCES caso(caso_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
  `identificador` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,1,1,'jajaja'),(2,2,1,'no'),(3,3,2,'mire este w'),(4,4,1,'llamen a mi asistente'),(5,2,2,'ontá mi matcha?') ;
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `colectiva`
--

DROP TABLE IF EXISTS `colectiva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `colectiva` (
  `colectiva_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `usuario_id_fk` int(11) DEFAULT NULL,
  `caso_id_fk` int(11) DEFAULT NULL,
   FOREIGN KEY (usuario_id_fk) REFERENCES usuario(usuario_id)
   ON DELETE SET NULL
   ON UPDATE CASCADE,
   FOREIGN KEY (caso_id_fk) REFERENCES caso(caso_id)
   ON DELETE CASCADE
   ON UPDATE CASCADE,
  `identificador` varchar(45) COLLATE utf8_spanish_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`colectiva_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `colectiva`
--

LOCK TABLES `colectiva` WRITE;
/*!40000 ALTER TABLE `colectiva` DISABLE KEYS */;
INSERT INTO `colectiva` VALUES (1,1,1,'turbio'),(2,2,1,'no'),(3,3,2,'ok'),(4,4,1,'llamen a dios') ;
/*!40000 ALTER TABLE `colectiva` ENABLE KEYS */;
UNLOCK TABLES;



/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=utf8 */;
/*!40101 SET CHARACTER_SET_RESULTS=utf8 */;
/*!40101 SET COLLATION_CONNECTION=utf8_spanish_ci */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-20 10:50:07