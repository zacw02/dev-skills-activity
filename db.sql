-- MySQL dump 10.13  Distrib 5.7.30, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: craftcms
-- ------------------------------------------------------
-- Server version	5.7.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assetindexdata`
--

DROP TABLE IF EXISTS `assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assetindexdata`
--

LOCK TABLES `assetindexdata` WRITE;
/*!40000 ALTER TABLE `assetindexdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `uploaderId` int(11) DEFAULT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  KEY `assets_uploaderId_fk` (`uploaderId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_uploaderId_fk` FOREIGN KEY (`uploaderId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransformindex`
--

DROP TABLE IF EXISTS `assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransformindex`
--

LOCK TABLES `assettransformindex` WRITE;
/*!40000 ALTER TABLE `assettransformindex` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assettransforms`
--

DROP TABLE IF EXISTS `assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  KEY `categories_parentId_fk` (`parentId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups`
--

DROP TABLE IF EXISTS `categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categorygroups_name_idx` (`name`),
  KEY `categorygroups_handle_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changedattributes`
--

DROP TABLE IF EXISTS `changedattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedattributes` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `attribute` varchar(255) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`attribute`),
  KEY `changedattributes_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedattributes_siteId_fk` (`siteId`),
  KEY `changedattributes_userId_fk` (`userId`),
  CONSTRAINT `changedattributes_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedattributes_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
INSERT INTO `changedattributes` VALUES (2,1,'authorId','2020-05-07 17:08:14',0,1),(2,1,'fieldLayoutId','2020-05-07 17:03:24',0,1),(2,1,'title','2020-05-07 19:33:50',0,1);
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `changedfields`
--

DROP TABLE IF EXISTS `changedfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `changedfields` (
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `propagated` tinyint(1) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  PRIMARY KEY (`elementId`,`siteId`,`fieldId`),
  KEY `changedfields_elementId_siteId_dateUpdated_idx` (`elementId`,`siteId`,`dateUpdated`),
  KEY `changedfields_siteId_fk` (`siteId`),
  KEY `changedfields_fieldId_fk` (`fieldId`),
  KEY `changedfields_userId_fk` (`userId`),
  CONSTRAINT `changedfields_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `changedfields_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
INSERT INTO `changedfields` VALUES (2,1,1,'2020-05-07 19:33:50',0,1);
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `content`
--

DROP TABLE IF EXISTS `content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
INSERT INTO `content` VALUES (1,1,1,NULL,'2020-05-05 17:44:33','2020-05-05 17:44:33','758c3886-31f5-4814-8740-a4216b9a2914'),(2,2,1,'Home','2020-05-07 16:34:47','2020-05-07 19:33:50','de8e7f61-40cd-448e-8917-b395921e0b24'),(3,3,1,'Home','2020-05-07 16:34:47','2020-05-07 16:34:47','fbbde1c6-7a1d-4d31-a5c3-eeafd2320a9d'),(4,4,1,'Home','2020-05-07 16:34:48','2020-05-07 16:34:48','263715a0-6d80-4bd2-99f5-f4866a32c19d'),(5,5,1,'Home','2020-05-07 16:35:33','2020-05-07 16:35:33','b2675ac2-24d9-466c-8372-67ef182b47ea'),(6,6,1,'Home','2020-05-07 17:03:24','2020-05-07 17:03:24','f303da8f-203d-421d-9980-ae236ed4002e'),(7,7,1,NULL,'2020-05-07 17:07:42','2020-05-07 17:07:42','18f0c3fa-46aa-4747-9d20-b653b67749a6');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `craftidtokens`
--

DROP TABLE IF EXISTS `craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deprecationerrors`
--

DROP TABLE IF EXISTS `deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` text,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drafts`
--

DROP TABLE IF EXISTS `drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `trackChanges` tinyint(1) NOT NULL DEFAULT '0',
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements`
--

DROP TABLE IF EXISTS `elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_dateDeleted_idx` (`dateDeleted`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `elements_archived_dateDeleted_draftId_revisionId_idx` (`archived`,`dateDeleted`,`draftId`,`revisionId`),
  KEY `elements_draftId_fk` (`draftId`),
  KEY `elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-05-05 17:44:33','2020-05-05 17:44:33',NULL,'1769f0b5-bac8-4e8c-b065-4256103252fb'),(2,NULL,NULL,1,'craft\\elements\\Entry',1,0,'2020-05-07 16:34:47','2020-05-07 17:07:42',NULL,'682debd3-bd73-4279-8f35-b43ce7737dd3'),(3,NULL,1,NULL,'craft\\elements\\Entry',1,0,'2020-05-07 16:34:47','2020-05-07 16:34:47',NULL,'d4429245-d99f-4f6d-b31b-4d132071ed93'),(4,NULL,2,NULL,'craft\\elements\\Entry',1,0,'2020-05-07 16:34:48','2020-05-07 16:34:48',NULL,'ad02f33d-46df-4229-b142-bbbcd3d849aa'),(5,NULL,3,NULL,'craft\\elements\\Entry',1,0,'2020-05-07 16:35:33','2020-05-07 16:35:33',NULL,'0aaaaf41-945c-440f-8113-4a3aeac6253d'),(6,NULL,4,1,'craft\\elements\\Entry',1,0,'2020-05-07 17:03:24','2020-05-07 17:03:24',NULL,'73b635f5-a878-462e-b955-b7362644368f'),(7,NULL,5,1,'craft\\elements\\Entry',1,0,'2020-05-07 17:07:42','2020-05-07 17:07:42',NULL,'6e6efe3a-0bc1-4797-b352-545476b08f87');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elements_sites`
--

DROP TABLE IF EXISTS `elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  KEY `elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
INSERT INTO `elements_sites` VALUES (1,1,1,NULL,NULL,1,'2020-05-05 17:44:33','2020-05-05 17:44:33','ba06de7d-257a-4514-b378-a761a5ecc092'),(2,2,1,'home','__home__',1,'2020-05-07 16:34:47','2020-05-07 17:08:14','bd995419-a33e-4c93-a370-6e94a2256dc2'),(3,3,1,'home','__home__',1,'2020-05-07 16:34:47','2020-05-07 16:34:47','97c81b09-e57c-4013-91fb-2278734c63a9'),(4,4,1,'home','__home__',1,'2020-05-07 16:34:48','2020-05-07 16:34:48','d3ad4919-7a8c-474d-9d3f-6c6cbe67712f'),(5,5,1,'home','__home__',1,'2020-05-07 16:35:33','2020-05-07 16:35:33','e8d2540f-b4f5-4a03-a776-d93c3a3dadaa'),(6,6,1,'home','__home__',1,'2020-05-07 17:03:24','2020-05-07 17:03:24','a8977f91-412d-4323-a792-ba030b89517d'),(7,7,1,'home','__home__',1,'2020-05-07 17:07:42','2020-05-07 17:07:42','c0088333-1787-448a-a261-2bbf496682f9');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entries`
--

DROP TABLE IF EXISTS `entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  KEY `entries_parentId_fk` (`parentId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
INSERT INTO `entries` VALUES (2,1,NULL,1,1,'2020-05-07 16:34:00',NULL,NULL,'2020-05-07 16:34:47','2020-05-07 17:08:14','703e310c-7e6c-4273-879f-af7e3ab7f1bf'),(3,1,NULL,1,NULL,'2020-05-07 16:34:00',NULL,NULL,'2020-05-07 16:34:47','2020-05-07 16:34:47','da098793-5cb6-49ba-b391-88a69c9408ab'),(4,1,NULL,1,NULL,'2020-05-07 16:34:00',NULL,NULL,'2020-05-07 16:34:48','2020-05-07 16:34:48','f64e3dbe-4c02-46f7-91f5-d04bcf95b227'),(5,1,NULL,1,NULL,'2020-05-07 16:34:00',NULL,NULL,'2020-05-07 16:35:33','2020-05-07 16:35:33','8adb3b8a-2fe1-4769-944d-c7fe1916ef7b'),(6,1,NULL,1,NULL,'2020-05-07 16:34:00',NULL,NULL,'2020-05-07 17:03:24','2020-05-07 17:03:24','f391e079-8bd5-4200-8b57-16a4c4307165'),(7,1,NULL,1,NULL,'2020-05-07 16:34:00',NULL,NULL,'2020-05-07 17:07:42','2020-05-07 17:07:42','962e8db5-3351-4fdb-896b-4ececa177e3e');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrytypes`
--

DROP TABLE IF EXISTS `entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
INSERT INTO `entrytypes` VALUES (1,1,1,'Home','index',0,'','{index.twig}',1,'2020-05-07 16:34:47','2020-05-07 19:33:49',NULL,'dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldgroups`
--

DROP TABLE IF EXISTS `fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-05-05 17:44:33','2020-05-05 17:44:33','659e7ba0-e396-4261-8890-542271e480fe');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayoutfields`
--

DROP TABLE IF EXISTS `fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
INSERT INTO `fieldlayoutfields` VALUES (4,1,4,1,0,1,'2020-05-07 19:34:37','2020-05-07 19:34:37','24c4a416-0f15-45af-9529-c07801e27d04');
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouts`
--

DROP TABLE IF EXISTS `fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
INSERT INTO `fieldlayouts` VALUES (1,'craft\\elements\\Entry','2020-05-07 17:03:24','2020-05-07 17:03:24',NULL,'c8eddf30-41f8-4f5a-9e0e-7fb752d2bd60');
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fieldlayouttabs`
--

DROP TABLE IF EXISTS `fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
INSERT INTO `fieldlayouttabs` VALUES (4,1,'Common',1,'2020-05-07 19:34:37','2020-05-07 19:34:37','4c36ec00-c5b6-442f-bb58-4d124be69e14');
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fields`
--

DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `searchable` tinyint(1) NOT NULL DEFAULT '1',
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
INSERT INTO `fields` VALUES (1,1,'home','home','global','',1,'site',NULL,'craft\\fields\\Entries','{\"limit\":\"\",\"localizeRelations\":false,\"selectionLabel\":\"\",\"source\":null,\"sources\":[\"singles\"],\"targetSiteId\":null,\"validateRelatedElements\":\"\",\"viewMode\":null}','2020-05-07 16:36:48','2020-05-07 17:02:42','cb4e8b45-7443-406f-9a22-03a77ef98341');
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `globalsets`
--

DROP TABLE IF EXISTS `globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `globalsets_name_idx` (`name`),
  KEY `globalsets_handle_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text,
  `isPublic` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gqltokens`
--

DROP TABLE IF EXISTS `gqltokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqltokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `schemaId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `gqltokens_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `gqltokens_name_unq_idx` (`name`),
  KEY `gqltokens_schemaId_fk` (`schemaId`),
  CONSTRAINT `gqltokens_schemaId_fk` FOREIGN KEY (`schemaId`) REFERENCES `gqlschemas` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `configMap` mediumtext,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
INSERT INTO `info` VALUES (1,'3.4.11','3.4.10',0,'[]','QRiDXKyB5lu1','2020-05-05 17:44:33','2020-05-07 17:02:42','3cd9ad67-5982-410e-8a71-fe54e7be3a20');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocks`
--

DROP TABLE IF EXISTS `matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `matrixblocktypes`
--

DROP TABLE IF EXISTS `matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,NULL,'app','Install','2020-05-05 17:44:33','2020-05-05 17:44:33','2020-05-05 17:44:33','04743d43-97ec-46a6-b4b7-4c6161b90ed7'),(2,NULL,'app','m150403_183908_migrations_table_changes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','536b4b3b-99a6-4a99-a1ef-e83d51084728'),(3,NULL,'app','m150403_184247_plugins_table_changes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','5aaa8d38-df19-4914-a99c-0420b72031d3'),(4,NULL,'app','m150403_184533_field_version','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f63f8e16-b64c-4556-b3d5-d20df765e4fa'),(5,NULL,'app','m150403_184729_type_columns','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','79f5c2aa-46e5-4049-844b-2a360818a4ac'),(6,NULL,'app','m150403_185142_volumes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','00be52df-5fe2-4459-9196-2d580368c194'),(7,NULL,'app','m150428_231346_userpreferences','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','8f37ef5b-8c7f-4c7a-9113-56ca7b4b6d05'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f51a4b2e-57e1-42ae-b71f-01b7ba003cf1'),(9,NULL,'app','m150617_213829_update_email_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','d422cb3e-ede9-4c64-8104-410b0ec8d20b'),(10,NULL,'app','m150721_124739_templatecachequeries','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','26e75e50-be0c-4402-99a3-43e4c59bbef3'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','71238828-0476-4b14-aad5-0ce48dd89273'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0a98f713-62b3-4652-ae0b-b6698a218bda'),(13,NULL,'app','m151002_095935_volume_cache_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','b82b51bf-9acf-4369-a63b-e007a357adf2'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','ae6897bf-d6fd-4d8f-9457-111ea4731b4b'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f57471c7-ad55-4000-bf4c-a6312a06dc3a'),(16,NULL,'app','m151209_000000_move_logo','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','a54edd09-4d37-4387-9222-0f83d27b63a7'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','4c0470c2-72aa-4c72-90f3-d7701b4b3faf'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','62836ada-8b2e-41fa-9c85-627e140ab2d7'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f0957649-c58d-4c69-bffb-f051a91e5457'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','c516892c-3d96-4a2c-b0c2-1c97e5e7a0fc'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','c2337a97-25d5-48b6-b108-86db82b38d48'),(22,NULL,'app','m160727_194637_column_cleanup','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','b684c69b-7a94-4f50-92d8-9c1846a03e1c'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','9b819836-225b-42f4-bbfc-857431822214'),(24,NULL,'app','m160807_144858_sites','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','1ae5f890-6b61-4a0e-9667-1cea62dc10aa'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','c4774462-7b19-47cc-8e94-0059aef0905d'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','fe9a18af-8ca6-467b-8418-f256bdbb3169'),(27,NULL,'app','m160912_230520_require_entry_type_id','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0ca188dc-be1c-440d-a4dd-dfa975a94168'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','d8a46465-c865-4722-83a6-7dcb621b39c8'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','bb57e1d7-4cff-42b4-9a8f-5246c95fdff0'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','fbaad5bd-f116-4ec7-9f77-b8a3b358f2c7'),(31,NULL,'app','m160925_113941_route_uri_parts','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','1513d544-3b2f-44f4-8575-8dedd5ec8e48'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','eb978a2a-ad99-4ab2-a13d-ab27b651569e'),(33,NULL,'app','m161007_130653_update_email_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f266601e-4a04-4890-88b3-2a351127e60e'),(34,NULL,'app','m161013_175052_newParentId','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','2eeab844-6e4d-45af-90c3-a4099a1037e6'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','538db48d-d685-4363-8dcb-4c8c0456c65d'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','748dc629-971b-4366-92c8-a35e6e7eb0ba'),(37,NULL,'app','m161025_000000_fix_char_columns','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','94c84a66-4268-4ffb-a363-4201f16ba774'),(38,NULL,'app','m161029_124145_email_message_languages','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','bfdac266-ec59-46c6-b37d-d20d3054133e'),(39,NULL,'app','m161108_000000_new_version_format','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','fc9304b5-4bbc-4c97-b432-2c3b1f3bf32d'),(40,NULL,'app','m161109_000000_index_shuffle','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','072d0958-7ddd-4d16-b228-f65ace19767c'),(41,NULL,'app','m161122_185500_no_craft_app','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','9106ab73-8ce6-49db-985c-64609df410de'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','da770792-f6bd-46e1-9e50-a9639cd2c793'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','3839ab3a-2bb7-4cd5-a978-e46c73a02154'),(44,NULL,'app','m170114_161144_udates_permission','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','5c9a9897-a477-45c3-a919-bdb3014a5d66'),(45,NULL,'app','m170120_000000_schema_cleanup','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','451b9421-69cb-4d2e-b9ab-258e711016fc'),(46,NULL,'app','m170126_000000_assets_focal_point','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','bc270747-0738-4ff7-9985-1905f4828b25'),(47,NULL,'app','m170206_142126_system_name','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','1540cabd-c9ac-41ad-a69d-3596f0ac3445'),(48,NULL,'app','m170217_044740_category_branch_limits','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','baf65fe4-24ca-4595-968d-6bd851e6699b'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','34c20604-0488-45da-ac0a-6e2a40be31f6'),(50,NULL,'app','m170223_224012_plain_text_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','2b2ce44b-969f-46ad-8f1f-bb36ce45027e'),(51,NULL,'app','m170227_120814_focal_point_percentage','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','875efb14-8b7a-4a68-8278-a7ee2c3181e5'),(52,NULL,'app','m170228_171113_system_messages','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','56aaf5ed-1d0b-4048-82ce-b99bc6fb4f8b'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','a4d0a086-69d6-4dd9-b7ca-c410016dec88'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','ae5602ab-949d-4fe4-bc93-67a25968a1f8'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','ebaf273c-5d64-4717-bdb4-01d16f4c62e8'),(56,NULL,'app','m170612_000000_route_index_shuffle','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','3d72b3a7-dadb-4e2c-a1cf-98422848f331'),(57,NULL,'app','m170621_195237_format_plugin_handles','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','b12e43e2-b2a0-482c-bd7c-27c98f6fde0b'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','042c1f17-e6d8-424c-885e-7a5de463fcf7'),(59,NULL,'app','m170630_161028_deprecation_changes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','7f835f50-b00c-4b0c-9f8a-c89e20e1249a'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','64677578-c16d-4eeb-8110-f90d9320ecaa'),(61,NULL,'app','m170704_134916_sites_tables','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','dbadcb0b-9115-4676-a1a8-4e79688fa8eb'),(62,NULL,'app','m170706_183216_rename_sequences','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','50574690-5789-4277-ac00-d7b2d9846648'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','1a9205fa-6457-4a0f-b56e-c6c9eb2ae395'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','44d3f7fb-3d28-486d-8ff5-91a106eeac42'),(65,NULL,'app','m170810_201318_create_queue_table','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','97f8e26b-cc24-4f94-8705-d000d44cc8f9'),(66,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','ab94f0ec-2a71-42f5-8d01-9c77f850543e'),(67,NULL,'app','m170914_204621_asset_cache_shuffle','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','389f3548-444d-4af0-a1bf-958c21047d4d'),(68,NULL,'app','m171011_214115_site_groups','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','5b4baa20-3b2b-4630-a883-1fe679cb001a'),(69,NULL,'app','m171012_151440_primary_site','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','2b6010b9-841a-4815-af7e-2e329e24167b'),(70,NULL,'app','m171013_142500_transform_interlace','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','d61b5ff5-46fa-43ab-aad0-fd487e000bdc'),(71,NULL,'app','m171016_092553_drop_position_select','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','cbf60cae-5d43-4bc0-9bbb-d8a13afffab3'),(72,NULL,'app','m171016_221244_less_strict_translation_method','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','74929c38-d179-4977-974f-082fa1f01331'),(73,NULL,'app','m171107_000000_assign_group_permissions','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','011d1806-bf9f-4a77-adc5-81ec385b2712'),(74,NULL,'app','m171117_000001_templatecache_index_tune','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','b9911e40-b61e-4f78-9892-e68b380b46c0'),(75,NULL,'app','m171126_105927_disabled_plugins','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','8e83780d-fe90-45bd-868e-5d584cbbcaf7'),(76,NULL,'app','m171130_214407_craftidtokens_table','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','fedd8e3c-a241-42dc-8fe4-a35dcca22b81'),(77,NULL,'app','m171202_004225_update_email_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0fc79498-a858-4200-80b8-852a1469c3e8'),(78,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','362ee999-2515-434a-a37d-c29fb9774f68'),(79,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','e8d0f87e-abd4-4eb4-b96e-ad3c871f021f'),(80,NULL,'app','m171218_143135_longtext_query_column','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f6e847e9-0dbc-4590-b78e-7a396a57c31c'),(81,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','457d3abd-77cf-42fe-9f12-56849fd74d64'),(82,NULL,'app','m180113_153740_drop_users_archived_column','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','60b27882-50e5-4bfd-bfc7-407a069b65f5'),(83,NULL,'app','m180122_213433_propagate_entries_setting','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','150ad18d-ebaa-405d-b059-2be3550129e2'),(84,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','a8a2a532-4e0a-493c-b280-24cd9717ced5'),(85,NULL,'app','m180128_235202_set_tag_slugs','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','2af4211b-4d06-4564-953f-8f567fd0516e'),(86,NULL,'app','m180202_185551_fix_focal_points','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','bad2877b-07f2-4b68-b323-4bb5a02264c7'),(87,NULL,'app','m180217_172123_tiny_ints','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','c581e839-805a-499a-831a-892e51d4d07f'),(88,NULL,'app','m180321_233505_small_ints','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','e32d12e9-fee8-4124-ae55-20a57e578146'),(89,NULL,'app','m180328_115523_new_license_key_statuses','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f9d4abe7-c817-4dd6-a15a-58b9c6715115'),(90,NULL,'app','m180404_182320_edition_changes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','a9a64987-c19f-4b9d-87ff-86ba31bf4076'),(91,NULL,'app','m180411_102218_fix_db_routes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','eefa82cf-eb25-432d-bead-5a8eed2c73b9'),(92,NULL,'app','m180416_205628_resourcepaths_table','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','55219a8c-33df-4b5d-8f36-7c48ed15f5f0'),(93,NULL,'app','m180418_205713_widget_cleanup','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','e5644d4a-d0b8-4c93-8304-61a553bae565'),(94,NULL,'app','m180425_203349_searchable_fields','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','07d3c0c6-a6b4-4075-8269-fc3992e2fad6'),(95,NULL,'app','m180516_153000_uids_in_field_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0353ecde-e2e9-4c6e-900b-c1d51182f7d1'),(96,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','597c5205-b67c-4a88-ac02-91577d7897c9'),(97,NULL,'app','m180518_173000_permissions_to_uid','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','bd3ab77a-30c0-4067-b250-55da962a7151'),(98,NULL,'app','m180520_173000_matrix_context_to_uids','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','11a0cc29-2a71-4372-8f3c-50b1d914caed'),(99,NULL,'app','m180521_172900_project_config_table','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','797b0ef2-ccc0-4ab5-9829-f6786a279a30'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','4e0330be-cc7d-4e8f-94d6-d94d43105091'),(101,NULL,'app','m180731_162030_soft_delete_sites','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','33775a96-073e-42f3-8477-13e82ca9b8f6'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','da2f4932-218a-4c98-be01-20227ca1619e'),(103,NULL,'app','m180810_214439_soft_delete_elements','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','c00a4344-64b8-46ba-a1a4-f12d5defa401'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','245b5b8f-475b-4e42-97c6-ceb5cdf2648a'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','8b46ffed-276b-42bd-a9e6-b46382c835ed'),(106,NULL,'app','m180904_112109_permission_changes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','355743a5-3839-49dd-a0dd-98266ef9ea53'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','909939e9-ae94-431d-8fb7-b432a66c6304'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','226753b8-ce2f-4765-b641-844a946b4de5'),(109,NULL,'app','m181016_183648_set_default_user_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','4c9411a9-d9d0-4da6-9416-7859f2a8854d'),(110,NULL,'app','m181017_225222_system_config_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','ffb823e7-2800-4078-a70f-b6e648a8afb5'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','3d63ca42-9028-45ea-95bf-a74c5cce9e3e'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','e8cbd5aa-16dd-48ae-9d1e-b260c706efb5'),(113,NULL,'app','m181112_203955_sequences_table','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','7af433dc-aa5a-44a0-93bb-71998c741c14'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','b24bf1b7-1d5e-492d-b213-1951bd66fb2a'),(115,NULL,'app','m181128_193942_fix_project_config','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','94639381-c924-49cd-aaa3-acab59a78657'),(116,NULL,'app','m181130_143040_fix_schema_version','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','af5ed596-5617-4553-b311-fad44117f338'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','656f2dfc-0f26-4337-b2a1-5ba29d7908bf'),(118,NULL,'app','m181213_102500_config_map_aliases','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0e53cecd-96bf-4afb-8c24-2a887ad86f48'),(119,NULL,'app','m181217_153000_fix_structure_uids','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','d27a791d-804b-46e8-841e-d00bd0bbc3b4'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','2ad0857c-e40e-42dc-9868-fcf794e9bc90'),(121,NULL,'app','m190108_110000_cleanup_project_config','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','e47a56e3-ed91-43f4-af76-3647153e112e'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','ccc51a9f-c9b5-4e97-809b-b5a4e6ec6062'),(123,NULL,'app','m190109_172845_fix_colspan','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','a9678153-d99c-4674-ad10-cb0623f4f78b'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','571ae408-3649-4705-aad7-c39140eb5a32'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','a3cf347f-990b-4fa0-9ca0-4f8b693a1dca'),(126,NULL,'app','m190112_124737_fix_user_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f047e487-e355-472e-8b6f-410204eb1004'),(127,NULL,'app','m190112_131225_fix_field_layouts','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','2b31e371-51a9-4188-98fd-80ac601fbd48'),(128,NULL,'app','m190112_201010_more_soft_deletes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','9176b659-e456-4f69-b436-59dd48b5a681'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','aedfc8d7-b04e-4bfa-aecd-37ad215d0afb'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','5e17809b-d927-4ff1-94f6-78c9b968a96b'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','7721fcd0-e9d9-45e7-a334-7936db6fa1eb'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f0eb4e6a-03db-4e0d-bd27-4a7d2f23ad00'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0079a71b-21ac-41a0-af58-13523d46a7c9'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','eed5668d-da2d-4854-90ee-8f59d5eec430'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','6f4c44b6-714e-43b6-9044-886989752988'),(136,NULL,'app','m190312_152740_element_revisions','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','89f619ff-1726-406b-9109-77e42ca91fc1'),(137,NULL,'app','m190327_235137_propagation_method','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','d0371ed4-d27d-41ca-b698-a9c523928fb3'),(138,NULL,'app','m190401_223843_drop_old_indexes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0523b521-62de-4229-a4db-08038025f656'),(139,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','29c47371-b2ef-4d51-81f6-4d9e39e3ee61'),(140,NULL,'app','m190417_085010_add_image_editor_permissions','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','6a92d018-6d22-4368-8bd4-830f289e2f81'),(141,NULL,'app','m190502_122019_store_default_user_group_uid','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','0608631d-e386-47bd-b2eb-317cb59811e8'),(142,NULL,'app','m190504_150349_preview_targets','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','5e46f20b-607e-4bf6-bd14-91fabf8bea22'),(143,NULL,'app','m190516_184711_job_progress_label','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','45c4c587-51bc-4be6-9cb6-cda132e46861'),(144,NULL,'app','m190523_190303_optional_revision_creators','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','8e2c5a80-8a90-4be8-bb45-5e545ef388bb'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','6611c651-f91d-44dd-8390-dd9dcb7f1288'),(146,NULL,'app','m190605_223807_unsaved_drafts','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','c0e19ad0-53b5-4d41-9b1f-965723c86d49'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','e8e7e95e-5c20-4522-8a3c-7c21e9bb130c'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','69aa1a14-996a-46ee-9b54-44f5d357ad98'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','db889627-641f-4fd6-ad4d-6de31d7800f3'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','de12a581-0bef-4530-8e7f-f2844217c44a'),(151,NULL,'app','m190711_153020_drop_snapshots','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','3f02d8b4-1f62-43ee-bad2-718e854c06a9'),(152,NULL,'app','m190712_195914_no_draft_revisions','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','af74e93a-0728-4994-ba2b-9f8d593832c1'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f11495bc-4583-4d82-9d48-aa7e8143218b'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','a0248911-9457-4923-bc96-0b47bdf5ce9e'),(155,NULL,'app','m190823_020339_optional_draft_creators','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','3307223c-cc74-4e43-b27f-9f2c2701db6a'),(156,NULL,'app','m190913_152146_update_preview_targets','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','ff88e2b9-9af4-4901-8168-c3d96b6825f8'),(157,NULL,'app','m191107_122000_add_gql_project_config_support','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','e9edff26-ca54-4d5f-86eb-b8e9574fde3a'),(158,NULL,'app','m191204_085100_pack_savable_component_settings','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','834a4dd3-22ba-45ef-92d7-b9c25f033152'),(159,NULL,'app','m191206_001148_change_tracking','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','10447aa6-d044-46bb-a8ae-b518571cf3de'),(160,NULL,'app','m191216_191635_asset_upload_tracking','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','5d578e51-3ed4-42d5-946f-3a58bbbc8365'),(161,NULL,'app','m191222_002848_peer_asset_permissions','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f79df597-f95e-4e81-af93-bc50d7ce5be1'),(162,NULL,'app','m200127_172522_queue_channels','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','24276d55-70ee-4d8e-b9b1-020e008cf07c'),(163,NULL,'app','m200211_175048_truncate_element_query_cache','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','f40996db-71bb-42e7-a534-8912e6112cee'),(164,NULL,'app','m200213_172522_new_elements_index','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','17ac50df-ea2c-40b6-ab4c-557f1724d4c9'),(165,NULL,'app','m200228_195211_long_deprecation_messages','2020-05-05 17:44:34','2020-05-05 17:44:34','2020-05-05 17:44:34','7b72d02c-d552-4aa9-8749-65378839c6d9');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugins`
--

DROP TABLE IF EXISTS `plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projectconfig`
--

DROP TABLE IF EXISTS `projectconfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projectconfig` (
  `path` varchar(255) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`path`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
INSERT INTO `projectconfig` VALUES ('dateModified','1588880029'),('email.fromEmail','\"ztwalker02@gmail.com\"'),('email.fromName','\"zacDevSkillsTest\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.659e7ba0-e396-4261-8890-542271e480fe.name','\"Common\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.contentColumnType','\"string\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.fieldGroup','\"659e7ba0-e396-4261-8890-542271e480fe\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.handle','\"home\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.instructions','\"\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.name','\"home\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.searchable','true'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.limit','\"\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.localizeRelations','false'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.selectionLabel','\"\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.source','null'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.sources.0','\"singles\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.targetSiteId','null'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.validateRelatedElements','\"\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.settings.viewMode','null'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.translationKeyFormat','null'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.translationMethod','\"site\"'),('fields.cb4e8b45-7443-406f-9a22-03a77ef98341.type','\"craft\\\\fields\\\\Entries\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.enableVersioning','true'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.fieldLayouts.c8eddf30-41f8-4f5a-9e0e-7fb752d2bd60.tabs.0.fields.cb4e8b45-7443-406f-9a22-03a77ef98341.required','false'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.fieldLayouts.c8eddf30-41f8-4f5a-9e0e-7fb752d2bd60.tabs.0.fields.cb4e8b45-7443-406f-9a22-03a77ef98341.sortOrder','1'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.fieldLayouts.c8eddf30-41f8-4f5a-9e0e-7fb752d2bd60.tabs.0.name','\"Common\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.fieldLayouts.c8eddf30-41f8-4f5a-9e0e-7fb752d2bd60.tabs.0.sortOrder','1'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.handle','\"index\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.hasTitleField','false'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.name','\"Home\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.sortOrder','1'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.titleFormat','\"{index.twig}\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.entryTypes.dc3c2e98-5ea3-45db-80a3-4dca3b0fcd7f.titleLabel','\"\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.handle','\"home\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.name','\"Home\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.propagationMethod','\"all\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.siteSettings.3445d06b-2314-4c4f-a52d-beddb3fcc94f.enabledByDefault','true'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.siteSettings.3445d06b-2314-4c4f-a52d-beddb3fcc94f.hasUrls','true'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.siteSettings.3445d06b-2314-4c4f-a52d-beddb3fcc94f.template','\"index\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.siteSettings.3445d06b-2314-4c4f-a52d-beddb3fcc94f.uriFormat','\"__home__\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.structure.maxLevels','null'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.structure.uid','\"d0720450-765e-47a2-a91d-46364f5f91f1\"'),('sections.9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9.type','\"structure\"'),('siteGroups.a1799f57-e830-4cab-a5bf-0e4439571fcd.name','\"zacDevSkillsTest\"'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.baseUrl','\"$DEFAULT_SITE_URL\"'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.handle','\"default\"'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.hasUrls','true'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.language','\"en-US\"'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.name','\"zacDevSkillsTest\"'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.primary','true'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.siteGroup','\"a1799f57-e830-4cab-a5bf-0e4439571fcd\"'),('sites.3445d06b-2314-4c4f-a52d-beddb3fcc94f.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"zacDevSkillsTest\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('tagGroups.22ff7cf6-88ed-48fd-8f00-6a5e966f8b7a.handle','\"devskills\"'),('tagGroups.22ff7cf6-88ed-48fd-8f00-6a5e966f8b7a.name','\"devskills\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT '0',
  `priority` int(11) unsigned NOT NULL DEFAULT '1024',
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT '0',
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT '0',
  `dateFailed` datetime DEFAULT NULL,
  `error` text,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relations`
--

DROP TABLE IF EXISTS `relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcepaths`
--

DROP TABLE IF EXISTS `resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
INSERT INTO `resourcepaths` VALUES ('2059cd24','@app/web/assets/utilities/dist'),('26a94552','@bower/jquery/dist'),('2973a37b','@app/web/assets/tablesettings/dist'),('2b011dc7','@lib/jquery.payment'),('3726b22f','@lib/velocity'),('3b39c40b','@app/web/assets/feed/dist'),('42228fb5','@app/web/assets/cp/dist'),('461c9acb','@app/web/assets/login/dist'),('591ac29e','@app/web/assets/pluginstore/dist'),('5eb3cab6','@lib/vue'),('5f6fa838','@app/web/assets/recententries/dist'),('61d5ea56','@app/web/assets/updateswidget/dist'),('6f474697','@app/web/assets/craftsupport/dist'),('735869c3','@lib/axios'),('75718647','@app/web/assets/generalsettings/dist'),('77d7ae38','@app/web/assets/installer/dist'),('798f298a','@lib/jquery-ui'),('812fc1f9','@app/web/assets/dashboard/dist'),('825d9a3c','@lib/fabric'),('8648efb7','@app/web/assets/fields/dist'),('939eea7','@lib/element-resize-detector'),('971b4e02','@lib/garnishjs'),('a18903f9','@app/web/assets/editentry/dist'),('a4a65984','@lib/d3'),('aa0379d5','@lib/picturefill'),('ada74517','@lib/jquery-touch-events'),('af39064','@app/web/assets/matrixsettings/dist'),('b2eb782b','@lib/fileupload'),('c9db47d2','@app/web/assets/editsection/dist'),('cbee48ae','@lib/timepicker'),('dfea05a9','@app/web/assets/admintable/dist'),('f41110db','@lib/xregexp'),('fe7d5451','@lib/selectize');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `revisions`
--

DROP TABLE IF EXISTS `revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
INSERT INTO `revisions` VALUES (1,2,1,1,NULL),(2,2,1,2,NULL),(3,2,1,3,NULL),(4,2,1,4,NULL),(5,2,1,5,NULL);
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `searchindex`
--

DROP TABLE IF EXISTS `searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
INSERT INTO `searchindex` VALUES (1,'username',0,1,' zacw02 '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' ztwalker02 gmail com '),(1,'slug',0,1,''),(2,'slug',0,1,' home '),(2,'title',0,1,' home ');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sections_handle_idx` (`handle`),
  KEY `sections_name_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  KEY `sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,1,'Home','home','structure',1,'all',NULL,'2020-05-07 16:34:47','2020-05-07 17:08:13',NULL,'9b98f8ac-bdbb-4ff1-aa08-0e0cc9d253f9');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'__home__','index',1,'2020-05-07 16:34:47','2020-05-07 16:34:47','a0138dba-b582-416a-80fa-1306057f7867');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (3,1,'ga2XKbsQtVMAQn_pStn19AYhnvn8n5h15YP-vMoexWR3OQ_m8R1pIU2ufSKad-oIwca9dBwEkZcygI60ttvvWge91zwNIKDPr9Y2','2020-05-06 02:35:24','2020-05-06 02:35:24','7b590804-8d0d-42f8-be80-af0b49777867'),(4,1,'D9hrAN7-u9z0RFfV8pVRJgPePXAge_WVS_04T9a823k6YKpiaStJ7XbysYRMEuADz5yDdQPgskWybU6BhGxB1rziSnXn10CJEd6_','2020-05-06 02:35:26','2020-05-06 03:26:15','38d86f51-1c40-47ff-9c77-a7a6c75c505e'),(6,1,'_NMgW3wd9Lu_m3y_7grLmGljCLofKH7akKFz_kWlHjjt8NsxRbWvxuMvy3LA5WUQcMoSS3wgSrPmtU-YS1rUT0D6ob_2W0ZKWuK8','2020-05-07 19:33:09','2020-05-07 20:01:29','fae94db0-6ad6-4dc2-bbf1-2d51685692a6');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shunnedmessages`
--

DROP TABLE IF EXISTS `shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sitegroups`
--

DROP TABLE IF EXISTS `sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
INSERT INTO `sitegroups` VALUES (1,'zacDevSkillsTest','2020-05-05 17:44:33','2020-05-05 17:44:33',NULL,'a1799f57-e830-4cab-a5bf-0e4439571fcd');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sites`
--

DROP TABLE IF EXISTS `sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sites_dateDeleted_idx` (`dateDeleted`),
  KEY `sites_handle_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`),
  KEY `sites_groupId_fk` (`groupId`),
  CONSTRAINT `sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
INSERT INTO `sites` VALUES (1,1,1,'zacDevSkillsTest','default','en-US',1,'$DEFAULT_SITE_URL',1,'2020-05-05 17:44:33','2020-05-05 17:44:33',NULL,'3445d06b-2314-4c4f-a52d-beddb3fcc94f');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structureelements`
--

DROP TABLE IF EXISTS `structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
INSERT INTO `structureelements` VALUES (1,1,NULL,1,1,4,0,'2020-05-07 17:08:13','2020-05-07 17:08:13','982a51d5-51cc-4dce-a2ee-a7ce69bd60c0'),(2,1,2,1,2,3,1,'2020-05-07 17:08:13','2020-05-07 17:08:13','2ec1d277-b43d-4fa4-a872-d256fd166ea2');
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `structures`
--

DROP TABLE IF EXISTS `structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
INSERT INTO `structures` VALUES (1,NULL,'2020-05-07 17:08:13','2020-05-07 17:08:13',NULL,'d0720450-765e-47a2-a91d-46364f5f91f1');
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemmessages`
--

DROP TABLE IF EXISTS `systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taggroups`
--

DROP TABLE IF EXISTS `taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `taggroups_name_idx` (`name`),
  KEY `taggroups_handle_idx` (`handle`),
  KEY `taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
INSERT INTO `taggroups` VALUES (1,'devskills','devskills',NULL,'2020-05-07 17:02:08','2020-05-07 17:02:08',NULL,'22ff7cf6-88ed-48fd-8f00-6a5e966f8b7a');
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecacheelements`
--

DROP TABLE IF EXISTS `templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecacheelements`
--

LOCK TABLES `templatecacheelements` WRITE;
/*!40000 ALTER TABLE `templatecacheelements` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecachequeries`
--

DROP TABLE IF EXISTS `templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecachequeries`
--

LOCK TABLES `templatecachequeries` WRITE;
/*!40000 ALTER TABLE `templatecachequeries` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecachequeries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `templatecaches`
--

DROP TABLE IF EXISTS `templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `templatecaches`
--

LOCK TABLES `templatecaches` WRITE;
/*!40000 ALTER TABLE `templatecaches` DISABLE KEYS */;
/*!40000 ALTER TABLE `templatecaches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups`
--

DROP TABLE IF EXISTS `usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroups_users`
--

DROP TABLE IF EXISTS `usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions`
--

DROP TABLE IF EXISTS `userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_usergroups`
--

DROP TABLE IF EXISTS `userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpermissions_users`
--

DROP TABLE IF EXISTS `userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
INSERT INTO `userpreferences` VALUES (1,'{\"language\":\"en-US\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT '0',
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_email_idx` (`email`),
  KEY `users_username_idx` (`username`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'zacw02',NULL,NULL,NULL,'ztwalker02@gmail.com','$2y$13$rziyqVIf4urNmYXG7lN3ieMwNEmAyVNI.mJipdyIJfKo7omen.YmW',1,0,0,0,'2020-05-07 19:33:09',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-05-05 17:44:33','2020-05-05 17:44:33','2020-05-07 19:33:09','bab2a994-71fb-47cb-ae18-9005f3b7d551');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumefolders`
--

DROP TABLE IF EXISTS `volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volumes`
--

DROP TABLE IF EXISTS `volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `volumes_name_idx` (`name`),
  KEY `volumes_handle_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `widgets`
--

DROP TABLE IF EXISTS `widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
INSERT INTO `widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-05-05 17:44:35','2020-05-05 17:44:35','3e07298c-ba18-4a70-8df9-b3e566347bb4'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-05-05 17:44:35','2020-05-05 17:44:35','c3a35e7b-d224-4031-86b8-e76eb608ab2e'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-05-05 17:44:35','2020-05-05 17:44:35','e9a1f188-5bd4-4023-8ec9-58fc0f786f3e'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-05-05 17:44:35','2020-05-05 17:44:35','0015a5ff-1087-40ac-b210-1a01734befc3');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-05-07 20:01:39
