-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: teste
-- ------------------------------------------------------
-- Server version	5.7.32-log

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
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `numero_pedido` int(11) NOT NULL,
  `data_emissao` datetime NOT NULL,
  `codigo_cliente` int(11) NOT NULL,
  `valor_total` decimal(15,2) DEFAULT '0.00',
  PRIMARY KEY (`numero_pedido`),
  UNIQUE KEY `numero_pedido_UNIQUE` (`numero_pedido`),
  KEY `fk_cliente_idx` (`codigo_cliente`),
  CONSTRAINT `fk_cliente` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,'2001-01-20 21:00:00',1,150.00),(2,'2021-01-01 00:00:00',2,22.00),(3,'2021-12-01 00:00:00',3,1.00),(4,'2021-01-12 00:00:00',4,4.00),(5,'2021-12-25 00:00:00',5,5.00),(6,'2021-05-25 00:00:00',6,6.00),(7,'2021-05-25 00:00:00',6,7.00),(8,'2021-05-25 00:00:00',6,6.50),(9,'2021-05-25 00:00:00',6,6.50),(10,'2021-01-06 00:00:00',1,9.00),(12,'2021-01-06 00:00:00',1,1.00),(13,'2021-01-06 00:00:00',1,4.00),(14,'2021-01-06 00:00:00',1,3.00),(15,'2021-01-06 00:00:00',1,1.00),(16,'2021-01-06 00:00:00',2,5.00),(17,'2021-01-06 00:00:00',1,6.00),(18,'2021-01-06 00:00:00',3,17.99),(19,'2021-01-06 00:00:00',1,3.98),(20,'2021-01-06 00:00:00',1,1.00),(21,'2021-01-06 00:00:00',1,3.00),(22,'2021-01-06 00:00:00',2,11.00),(23,'2021-01-06 00:00:00',6,10.00),(24,'2021-01-06 00:00:00',1,2.00),(25,'2021-01-07 00:00:00',2,38.00);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-07  7:57:03