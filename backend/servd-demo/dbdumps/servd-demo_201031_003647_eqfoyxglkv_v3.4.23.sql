-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for Linux (x86_64)
--
-- Host: master-database    Database: secret_polecat_staging
-- ------------------------------------------------------
-- Server version	10.4.15-MariaDB-1:10.4.15+maria~focal-log

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
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
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
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `categorygroups_sites`
--

DROP TABLE IF EXISTS `categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `message` text DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `notes` text DEFAULT NULL,
  `trackChanges` tinyint(1) NOT NULL DEFAULT 0,
  `dateLastMerged` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drafts_creatorId_fk` (`creatorId`),
  KEY `drafts_sourceId_fk` (`sourceId`),
  CONSTRAINT `drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `elementindexsettings`
--

DROP TABLE IF EXISTS `elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
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
  `required` tinyint(1) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `gqlschemas`
--

DROP TABLE IF EXISTS `gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `scope` text DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
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
-- Table structure for table `info`
--

DROP TABLE IF EXISTS `info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=169 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(255) NOT NULL DEFAULT 'queue',
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `queue_channel_fail_timeUpdated_timePushed_idx` (`channel`,`fail`,`timeUpdated`,`timePushed`),
  KEY `queue_channel_fail_timeUpdated_delay_idx` (`channel`,`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
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
-- Table structure for table `sections_sites`
--

DROP TABLE IF EXISTS `sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
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
-- Table structure for table `sequences`
--

DROP TABLE IF EXISTS `sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
-- Table structure for table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
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
-- Table structure for table `userpreferences`
--

DROP TABLE IF EXISTS `userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'secret_polecat_staging'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-31  0:36:47
-- MariaDB dump 10.17  Distrib 10.4.13-MariaDB, for Linux (x86_64)
--
-- Host: master-database    Database: secret_polecat_staging
-- ------------------------------------------------------
-- Server version	10.4.15-MariaDB-1:10.4.15+maria~focal-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `assettransforms`
--

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups`
--

LOCK TABLES `categorygroups` WRITE;
/*!40000 ALTER TABLE `categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `categorygroups_sites`
--

LOCK TABLES `categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedattributes`
--

LOCK TABLES `changedattributes` WRITE;
/*!40000 ALTER TABLE `changedattributes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedattributes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `changedfields`
--

LOCK TABLES `changedfields` WRITE;
/*!40000 ALTER TABLE `changedfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `changedfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `content`
--

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `content` VALUES (1,1,1,'Home','2020-10-31 00:35:47','2020-10-31 00:35:47','a7489294-997f-4446-a3e8-db745ef61327'),(2,2,1,NULL,'2020-10-31 00:35:47','2020-10-31 00:35:47','249649f9-3712-4af9-86fe-4b0d195ac9f0');
/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craftidtokens`
--

LOCK TABLES `craftidtokens` WRITE;
/*!40000 ALTER TABLE `craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `deprecationerrors`
--

LOCK TABLES `deprecationerrors` WRITE;
/*!40000 ALTER TABLE `deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `drafts`
--

LOCK TABLES `drafts` WRITE;
/*!40000 ALTER TABLE `drafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elementindexsettings`
--

LOCK TABLES `elementindexsettings` WRITE;
/*!40000 ALTER TABLE `elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements`
--

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2020-10-31 00:35:47','2020-10-31 00:35:47',NULL,'a0e78a38-fe50-4747-b39b-db25825d232d'),(2,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2020-10-31 00:35:47','2020-10-31 00:35:47',NULL,'74ad3fe3-a789-49f1-82d1-5569ec8d7e66');
/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `elements_sites`
--

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `elements_sites` VALUES (1,1,1,'home','__home__',1,'2020-10-31 00:35:47','2020-10-31 00:35:47','e2761637-c785-4182-9b9e-34ac8f575bd0'),(2,2,1,NULL,NULL,1,'2020-10-31 00:35:47','2020-10-31 00:35:47','1da5fab9-a0fb-47ab-81ff-3495b9653e67');
/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entries`
--

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entries` VALUES (1,1,NULL,1,NULL,'2020-10-31 00:35:00',NULL,NULL,'2020-10-31 00:35:47','2020-10-31 00:35:47','0b5e9dd6-2d46-4a52-abec-ac18777a907b');
/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `entrytypes`
--

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `entrytypes` VALUES (1,1,NULL,'Home','home',0,NULL,'{section.name|raw}',1,'2020-10-31 00:35:47','2020-10-31 00:35:47',NULL,'eff33001-900c-4d66-8603-109687a40252');
/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldgroups`
--

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `fieldgroups` VALUES (1,'Common','2020-10-31 00:35:47','2020-10-31 00:35:47','41f0085a-91c4-4de0-8a54-a5d6419bb7a8');
/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayoutfields`
--

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouts`
--

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fieldlayouttabs`
--

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `fields`
--

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `globalsets`
--

LOCK TABLES `globalsets` WRITE;
/*!40000 ALTER TABLE `globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqlschemas`
--

LOCK TABLES `gqlschemas` WRITE;
/*!40000 ALTER TABLE `gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `gqltokens`
--

LOCK TABLES `gqltokens` WRITE;
/*!40000 ALTER TABLE `gqltokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `gqltokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `info`
--

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `info` VALUES (1,'3.4.23','3.4.10',0,'{\"dateModified\":\"@config/project.yaml\",\"email\":\"@config/project.yaml\",\"fieldGroups\":\"@config/project.yaml\",\"plugins\":\"@config/project.yaml\",\"sections\":\"@config/project.yaml\",\"siteGroups\":\"@config/project.yaml\",\"sites\":\"@config/project.yaml\",\"system\":\"@config/project.yaml\",\"users\":\"@config/project.yaml\",\"volumes\":\"@config/project.yaml\"}','ABOqNyMDxPr5','2020-10-31 00:35:47','2020-10-31 00:35:48','3cccfd22-4b09-4756-857d-9bf381cceb76');
/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocks`
--

LOCK TABLES `matrixblocks` WRITE;
/*!40000 ALTER TABLE `matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `matrixblocktypes`
--

LOCK TABLES `matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `migrations` VALUES (1,1,'plugin','m180430_204710_remove_old_plugins','2020-10-31 00:35:47','2020-10-31 00:35:47','2020-10-31 00:35:47','928cc9cd-596b-4d65-99bf-6cbe20e7fed0'),(2,1,'plugin','Install','2020-10-31 00:35:47','2020-10-31 00:35:47','2020-10-31 00:35:47','67fc7eca-2585-400c-af4d-d58c5e9ec7c9'),(3,1,'plugin','m190225_003922_split_cleanup_html_settings','2020-10-31 00:35:47','2020-10-31 00:35:47','2020-10-31 00:35:47','2ada53a9-3e73-4f19-a1a5-5147eeca1a3d'),(4,NULL,'app','Install','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','85bbc14f-3bd3-4041-9214-403f8de35344'),(5,NULL,'app','m150403_183908_migrations_table_changes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','28f19f04-48e4-4bd5-aa5e-9edab206b8f2'),(6,NULL,'app','m150403_184247_plugins_table_changes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','54b55030-2066-4006-b812-94fb90e1d4c2'),(7,NULL,'app','m150403_184533_field_version','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','971adb21-a6ad-4a67-96d6-489c1e7bed90'),(8,NULL,'app','m150403_184729_type_columns','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b970f806-87a7-46f6-855b-ab7d9ae81c7b'),(9,NULL,'app','m150403_185142_volumes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','f12541c1-75a4-45f2-9b90-0a2d96fc6b5e'),(10,NULL,'app','m150428_231346_userpreferences','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','76134ae1-9c91-41a4-8d57-347e9d00d1b1'),(11,NULL,'app','m150519_150900_fieldversion_conversion','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','26a82c16-e920-43d9-9bfb-fa838def871a'),(12,NULL,'app','m150617_213829_update_email_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','15976ebc-b0df-4a5d-9254-7d825a8cb14e'),(13,NULL,'app','m150721_124739_templatecachequeries','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','bcc251b8-d909-489a-9ab1-b689ca2fcd15'),(14,NULL,'app','m150724_140822_adjust_quality_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a206b032-ad55-4f1f-bd5f-6d935d78a34e'),(15,NULL,'app','m150815_133521_last_login_attempt_ip','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','f1fb3e03-2ab0-4ce6-8a2e-a22ae96b0fcb'),(16,NULL,'app','m151002_095935_volume_cache_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','ac1644f8-ad1a-4c7c-bca8-d3feaba17e88'),(17,NULL,'app','m151005_142750_volume_s3_storage_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','54c01442-fdb4-4af1-9705-219ae404f480'),(18,NULL,'app','m151016_133600_delete_asset_thumbnails','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','0a7e3c55-194c-4ac9-818c-8be3e0de7810'),(19,NULL,'app','m151209_000000_move_logo','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','cff4e5ed-5750-4439-a22d-a4f32c2e9e09'),(20,NULL,'app','m151211_000000_rename_fileId_to_assetId','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','83301fe7-8bf4-43e1-bb8d-f14a58fcbda4'),(21,NULL,'app','m151215_000000_rename_asset_permissions','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','20559c05-5caa-4f7e-b446-0040c911c348'),(22,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','bba517cc-179b-4508-8fc6-9a3c0e5e90bd'),(23,NULL,'app','m160708_185142_volume_hasUrls_setting','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','2adff298-8432-47b9-9a32-f90f36e3f400'),(24,NULL,'app','m160714_000000_increase_max_asset_filesize','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','c8458a96-1ce7-4e19-b097-7bfb8ae2b16a'),(25,NULL,'app','m160727_194637_column_cleanup','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','cb49a33a-2735-44f8-b400-299bb0768ea7'),(26,NULL,'app','m160804_110002_userphotos_to_assets','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','0791d0d6-aee1-41b9-b323-41417b3f27cc'),(27,NULL,'app','m160807_144858_sites','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','101d4062-324c-425b-be54-3297c16b1c22'),(28,NULL,'app','m160829_000000_pending_user_content_cleanup','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','3312916b-d769-492e-b62e-201789d431d9'),(29,NULL,'app','m160830_000000_asset_index_uri_increase','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','3e0a712f-df0d-4cbe-8c45-0cc4e1e09792'),(30,NULL,'app','m160912_230520_require_entry_type_id','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','6292e554-b48c-40e3-befc-807c1bf7116d'),(31,NULL,'app','m160913_134730_require_matrix_block_type_id','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','9fbf54cd-b053-4191-be9e-d63d5bfc08b6'),(32,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','2d519536-d3eb-4b2c-b880-8dddcfdfd88b'),(33,NULL,'app','m160920_231045_usergroup_handle_title_unique','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','911deab9-c3ff-4d73-bd2e-15e22a5f5af7'),(34,NULL,'app','m160925_113941_route_uri_parts','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','be17383a-0b16-49de-bf4e-227ccd0b6576'),(35,NULL,'app','m161006_205918_schemaVersion_not_null','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','06b82d19-96f2-47b9-98c4-8e301559b2ab'),(36,NULL,'app','m161007_130653_update_email_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','0230d81a-7c73-455c-bc33-260b14170590'),(37,NULL,'app','m161013_175052_newParentId','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','36e39f4d-74b1-4bda-a122-2729c87be4ba'),(38,NULL,'app','m161021_102916_fix_recent_entries_widgets','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d5293145-e488-4822-9a37-1657418fef1a'),(39,NULL,'app','m161021_182140_rename_get_help_widget','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','cb8ba23c-8fa3-40e3-b47f-f425ae1c1dbe'),(40,NULL,'app','m161025_000000_fix_char_columns','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','7d41431a-6720-45c1-9318-344484df4e59'),(41,NULL,'app','m161029_124145_email_message_languages','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','3252ba6d-cac8-448e-940b-7a48fed7dc61'),(42,NULL,'app','m161108_000000_new_version_format','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','e4bcb412-ca8e-4735-b22d-ed87c9377ef9'),(43,NULL,'app','m161109_000000_index_shuffle','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','1b7b3c29-1de0-4d07-8f48-4dfd8742e057'),(44,NULL,'app','m161122_185500_no_craft_app','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','39e0d411-4ec4-4443-bad3-1085ee627c47'),(45,NULL,'app','m161125_150752_clear_urlmanager_cache','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','78b1ac5e-8170-466e-a6a7-f073cb4036ba'),(46,NULL,'app','m161220_000000_volumes_hasurl_notnull','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','2d0279f6-4f19-4599-83a1-93445d4488c5'),(47,NULL,'app','m170114_161144_udates_permission','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','bd11d627-0c6d-4891-83de-8e254e2f35b0'),(48,NULL,'app','m170120_000000_schema_cleanup','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b5fc6957-d046-4694-b2bc-d2d955b5273d'),(49,NULL,'app','m170126_000000_assets_focal_point','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','448f3e91-ae10-48ec-ac87-9bf522edaa26'),(50,NULL,'app','m170206_142126_system_name','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','cebf0133-d58a-42dc-8df9-a4930d418995'),(51,NULL,'app','m170217_044740_category_branch_limits','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','3932359f-d429-49b9-bef5-104deca15a8a'),(52,NULL,'app','m170217_120224_asset_indexing_columns','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','59b995c6-5139-4806-9328-70329f7d4bc1'),(53,NULL,'app','m170223_224012_plain_text_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a0a0ea4b-8d6d-4e47-9a63-2e57ff82ed51'),(54,NULL,'app','m170227_120814_focal_point_percentage','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','5b6b63a3-f35a-4e72-bab0-d07892f04ce7'),(55,NULL,'app','m170228_171113_system_messages','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','13caf76e-1c45-4844-8a0c-c05c1617b1ef'),(56,NULL,'app','m170303_140500_asset_field_source_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','bd98b438-9a1a-45e4-83ad-2852a35766b9'),(57,NULL,'app','m170306_150500_asset_temporary_uploads','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','ec3bfd0c-8cab-49d4-a64d-f95baa4d02bd'),(58,NULL,'app','m170523_190652_element_field_layout_ids','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','85830f65-a3d1-4cc1-9fc9-6300e840b382'),(59,NULL,'app','m170612_000000_route_index_shuffle','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','f13e8bb4-ca12-41e8-ba31-47a4e17590d6'),(60,NULL,'app','m170621_195237_format_plugin_handles','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','87ce9f69-9005-4461-9ee9-95a97c7f1619'),(61,NULL,'app','m170630_161027_deprecation_line_nullable','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','72132838-26e2-4267-9d0f-818ad2fb605f'),(62,NULL,'app','m170630_161028_deprecation_changes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','2f39a2e1-da70-4ec7-a418-661dff098f3d'),(63,NULL,'app','m170703_181539_plugins_table_tweaks','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','829cf92e-4b0d-4a14-b5ce-04c50afe9cd0'),(64,NULL,'app','m170704_134916_sites_tables','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','10e062f8-0222-47d1-bc9f-08f4dd6155a5'),(65,NULL,'app','m170706_183216_rename_sequences','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','09185ebb-6c16-4cda-b10c-f867fd68da25'),(66,NULL,'app','m170707_094758_delete_compiled_traits','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','0dfa026b-1a3c-4209-9c3d-a8d08753107a'),(67,NULL,'app','m170731_190138_drop_asset_packagist','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','ba8db66e-6f46-466d-851b-5f6d0af83aff'),(68,NULL,'app','m170810_201318_create_queue_table','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','966e89b2-2256-4eb7-9d43-0bfa9d0afb32'),(69,NULL,'app','m170903_192801_longblob_for_queue_jobs','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a56f2622-903c-4e04-a2a4-e62b33c9f775'),(70,NULL,'app','m170914_204621_asset_cache_shuffle','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','34cb04c9-1369-45dd-b764-2d3fb22f5190'),(71,NULL,'app','m171011_214115_site_groups','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','7db31ba5-458b-4b16-9af1-b937b867f477'),(72,NULL,'app','m171012_151440_primary_site','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b2115569-5348-4cdb-b7f3-ad11f9dca6dc'),(73,NULL,'app','m171013_142500_transform_interlace','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b969c22b-db97-45f4-b924-a75adbbe7879'),(74,NULL,'app','m171016_092553_drop_position_select','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','92e0987b-237d-4c54-8d69-198a69992b65'),(75,NULL,'app','m171016_221244_less_strict_translation_method','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','c328c4c1-28ea-4f04-a390-447d85a71d91'),(76,NULL,'app','m171107_000000_assign_group_permissions','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','1de3f232-a09f-4967-bead-4bece054e072'),(77,NULL,'app','m171117_000001_templatecache_index_tune','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','e1e60aa1-33b3-48bf-b437-4678f6d4cb66'),(78,NULL,'app','m171126_105927_disabled_plugins','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','dc8267e3-cd58-4b74-b87e-79c7622c1180'),(79,NULL,'app','m171130_214407_craftidtokens_table','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a733df93-0920-42df-b6ca-ea670721b781'),(80,NULL,'app','m171202_004225_update_email_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','e5210b1e-b225-49f2-9caf-ff6cccb0e250'),(81,NULL,'app','m171204_000001_templatecache_index_tune_deux','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b4f4fd85-0387-44fa-aa2a-cbe7e0a34684'),(82,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','14f4fb10-864b-453e-84c9-4a6c4f0eb76a'),(83,NULL,'app','m171218_143135_longtext_query_column','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b5f9a6d2-5695-42bd-8fc6-d3606ed9ad7d'),(84,NULL,'app','m171231_055546_environment_variables_to_aliases','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','0148a69f-5d60-471a-9d8f-77d88c7cecad'),(85,NULL,'app','m180113_153740_drop_users_archived_column','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','cf8ccb9f-c1c7-4b54-aeb2-f7f656507baf'),(86,NULL,'app','m180122_213433_propagate_entries_setting','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','6e4a851a-9be5-4b8f-bd37-1015ad726e9a'),(87,NULL,'app','m180124_230459_fix_propagate_entries_values','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','957bdb28-d55a-439c-8a00-5468f063eddc'),(88,NULL,'app','m180128_235202_set_tag_slugs','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','23ff9657-4b58-4555-bbf3-ede0b2107e47'),(89,NULL,'app','m180202_185551_fix_focal_points','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','048d0d57-cfeb-47a3-b3b0-19af7800e6b4'),(90,NULL,'app','m180217_172123_tiny_ints','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','e944c5cc-2144-4a65-ab95-37b7f1d9594d'),(91,NULL,'app','m180321_233505_small_ints','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','4913d32f-0c3d-45e1-976d-f446b4b72216'),(92,NULL,'app','m180328_115523_new_license_key_statuses','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','eae2b5f1-b25d-4ac8-a8d4-7e19e481dca1'),(93,NULL,'app','m180404_182320_edition_changes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','3d339cd5-50e7-4326-8dc3-e9863d6feaf4'),(94,NULL,'app','m180411_102218_fix_db_routes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','102e0dc3-152e-4d31-b9f8-952f2e46587a'),(95,NULL,'app','m180416_205628_resourcepaths_table','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','c79b5321-0203-49c2-92f1-d04657345a34'),(96,NULL,'app','m180418_205713_widget_cleanup','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','7238e114-a8ab-4fa7-aa16-2c6ffa6d578e'),(97,NULL,'app','m180425_203349_searchable_fields','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b7ae12ee-25e7-4e34-969d-169ab6636c8e'),(98,NULL,'app','m180516_153000_uids_in_field_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','38fda9ef-20c6-4a57-950e-31f78f18b70e'),(99,NULL,'app','m180517_173000_user_photo_volume_to_uid','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','33bfe8c7-4727-4308-8104-d09037f2d5ab'),(100,NULL,'app','m180518_173000_permissions_to_uid','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','301dbfe4-16fb-421c-b620-65fc9742879b'),(101,NULL,'app','m180520_173000_matrix_context_to_uids','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','abaf1311-1bb5-45e0-8a16-86111ed8b322'),(102,NULL,'app','m180521_172900_project_config_table','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','eeaa8159-4c74-4b37-9fec-cbcba2c68871'),(103,NULL,'app','m180521_173000_initial_yml_and_snapshot','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','16073de2-05c0-4de2-ad7a-807e7d555648'),(104,NULL,'app','m180731_162030_soft_delete_sites','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b9d8a1c4-6e6d-4523-a210-4ce99019e516'),(105,NULL,'app','m180810_214427_soft_delete_field_layouts','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a396b373-0556-419a-af1d-75f1193ffefd'),(106,NULL,'app','m180810_214439_soft_delete_elements','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','4eed54a0-5d63-4a87-b812-72d3efb0721d'),(107,NULL,'app','m180824_193422_case_sensitivity_fixes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','b59770c5-3cea-43ad-91dd-d26db2106964'),(108,NULL,'app','m180901_151639_fix_matrixcontent_tables','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','6bb6cad1-2d5e-43e3-b9e5-4645eb474f77'),(109,NULL,'app','m180904_112109_permission_changes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','56d58188-97fe-409a-8118-29d0388ecfef'),(110,NULL,'app','m180910_142030_soft_delete_sitegroups','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','041e3f04-5492-4a5c-aa41-203992d6dcc0'),(111,NULL,'app','m181011_160000_soft_delete_asset_support','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a2bf3219-0409-4911-be51-ab76b7a48086'),(112,NULL,'app','m181016_183648_set_default_user_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','5b90fc38-c3b3-40c0-9a79-388c8563e1c4'),(113,NULL,'app','m181017_225222_system_config_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','5d2bc6b7-17c5-41de-8565-cc5ffa5732b3'),(114,NULL,'app','m181018_222343_drop_userpermissions_from_config','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a01aff2f-06fc-46eb-a6ff-850e01b957a7'),(115,NULL,'app','m181029_130000_add_transforms_routes_to_config','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d1731952-e6a9-4ffa-aa1f-2ad5569c79d2'),(116,NULL,'app','m181112_203955_sequences_table','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','31ab6174-befa-43cb-b9c0-cd2898ce60a1'),(117,NULL,'app','m181121_001712_cleanup_field_configs','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','c9209203-b58f-4b59-b806-1d01ac706b4f'),(118,NULL,'app','m181128_193942_fix_project_config','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','f2a252f5-260c-453e-b5a5-eeabba34725b'),(119,NULL,'app','m181130_143040_fix_schema_version','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d8118539-c084-40b4-aff6-63f0edf2771a'),(120,NULL,'app','m181211_143040_fix_entry_type_uids','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','872e8604-d969-484d-a337-e5d0024aa4dc'),(121,NULL,'app','m181213_102500_config_map_aliases','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','92759094-508e-4ca4-b4bb-14e965d834c3'),(122,NULL,'app','m181217_153000_fix_structure_uids','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','8419721c-b240-479d-b36a-9d8458d8e531'),(123,NULL,'app','m190104_152725_store_licensed_plugin_editions','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','428dd9b1-dd6b-459f-8f4c-b8e142c495e8'),(124,NULL,'app','m190108_110000_cleanup_project_config','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','af3de2d3-aa04-4337-a414-ff541c90a283'),(125,NULL,'app','m190108_113000_asset_field_setting_change','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','7a6c24b8-6695-4ed7-8f1c-13df2749366a'),(126,NULL,'app','m190109_172845_fix_colspan','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','0ea424f4-a3cd-410b-a7d1-576cf810ccd5'),(127,NULL,'app','m190110_150000_prune_nonexisting_sites','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','fa01a41d-7cc8-446e-9bd1-90f5141e0723'),(128,NULL,'app','m190110_214819_soft_delete_volumes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','27294001-3113-4557-8dd4-177b379fa595'),(129,NULL,'app','m190112_124737_fix_user_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','6a1a965a-8d17-4535-a74f-b355e8be5eff'),(130,NULL,'app','m190112_131225_fix_field_layouts','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','59763939-d4db-44e5-816e-c625ff0df3b0'),(131,NULL,'app','m190112_201010_more_soft_deletes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','49a6c337-1c11-4c59-884e-48e8d53942cd'),(132,NULL,'app','m190114_143000_more_asset_field_setting_changes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','ca4ffc1a-8772-49bc-a016-34aaf5def75a'),(133,NULL,'app','m190121_120000_rich_text_config_setting','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','30ebe558-1504-402c-bca7-5158704a0e68'),(134,NULL,'app','m190125_191628_fix_email_transport_password','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','57d1c4a9-8fbf-4954-ba02-a8741e4285ca'),(135,NULL,'app','m190128_181422_cleanup_volume_folders','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','54a7b2f6-0d52-440d-952e-210a7975e820'),(136,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','e779d40d-b79c-418f-ab49-1481f13c7e42'),(137,NULL,'app','m190208_140000_reset_project_config_mapping','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a3ef901d-7f56-436b-812e-2c117b7ff8f8'),(138,NULL,'app','m190218_143000_element_index_settings_uid','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','18a9e360-9a26-443e-82ca-ed0a80d68f7a'),(139,NULL,'app','m190312_152740_element_revisions','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','fab7621c-6baa-4790-b659-24724f1a1ad8'),(140,NULL,'app','m190327_235137_propagation_method','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','5afd44f7-fad5-409f-a433-91e9a72e9310'),(141,NULL,'app','m190401_223843_drop_old_indexes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','ee35d394-0025-4632-8e1d-e20123e5fc8a'),(142,NULL,'app','m190416_014525_drop_unique_global_indexes','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','a55c318c-6175-4ef5-a23a-c990ecbde067'),(143,NULL,'app','m190417_085010_add_image_editor_permissions','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d2f4db9d-a359-4e38-9fea-63c8649156ca'),(144,NULL,'app','m190502_122019_store_default_user_group_uid','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d820fdf9-dea6-46cc-be73-32a554ccf7b6'),(145,NULL,'app','m190504_150349_preview_targets','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','794889ba-d5a7-405f-9a57-3b917694fefc'),(146,NULL,'app','m190516_184711_job_progress_label','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d4e149e0-b9cb-4dcc-bd09-eb7103f2d129'),(147,NULL,'app','m190523_190303_optional_revision_creators','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','cbcd3094-bcdf-4413-b501-8aa03d8ba7d4'),(148,NULL,'app','m190529_204501_fix_duplicate_uids','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','ac5142d7-cbc0-43c6-9a6c-8d9fdb639b31'),(149,NULL,'app','m190605_223807_unsaved_drafts','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','879f2889-6aca-4e2f-bcbb-88208b947a33'),(150,NULL,'app','m190607_230042_entry_revision_error_tables','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d2e05e13-32ec-459d-a35f-cce70ec0f045'),(151,NULL,'app','m190608_033429_drop_elements_uid_idx','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','1336ba30-6896-4ad7-a156-4d0452595150'),(152,NULL,'app','m190617_164400_add_gqlschemas_table','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','0c4e14f7-7c27-4137-b1c3-f1d2cb97697a'),(153,NULL,'app','m190624_234204_matrix_propagation_method','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d4ca7e4d-c15c-41ad-b653-465fb0b90f1b'),(154,NULL,'app','m190711_153020_drop_snapshots','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','6576edbc-667a-4534-b0d5-04c3647462d7'),(155,NULL,'app','m190712_195914_no_draft_revisions','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','93838110-1e37-4107-9a70-1b74d698fc68'),(156,NULL,'app','m190723_140314_fix_preview_targets_column','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','d829ec1a-b307-46ed-b51b-d230440962bb'),(157,NULL,'app','m190820_003519_flush_compiled_templates','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','e6481501-a388-45d4-bff5-80ac53388da1'),(158,NULL,'app','m190823_020339_optional_draft_creators','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','74f166ae-5942-4f20-a8e6-d6afc814efcb'),(159,NULL,'app','m190913_152146_update_preview_targets','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','9225dedc-f1a2-460c-b142-3725e7ab7c5f'),(160,NULL,'app','m191107_122000_add_gql_project_config_support','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','84c152dc-d628-4e40-b0e3-c22d91bc0430'),(161,NULL,'app','m191204_085100_pack_savable_component_settings','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','4a22c919-5a85-4c16-b55a-6868c8b0573d'),(162,NULL,'app','m191206_001148_change_tracking','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','72922b0d-e060-4915-98df-6d36a2d8b78c'),(163,NULL,'app','m191216_191635_asset_upload_tracking','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','417817e9-e5d0-4ce2-a35e-17cbe44bc4c6'),(164,NULL,'app','m191222_002848_peer_asset_permissions','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','de0db28f-fb93-49e5-9dff-3f7e48436755'),(165,NULL,'app','m200127_172522_queue_channels','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','12fa6f70-b58b-4859-8903-058bbbc2ba4d'),(166,NULL,'app','m200211_175048_truncate_element_query_cache','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','86db03c2-e369-42b8-8ad6-21d05ad766fb'),(167,NULL,'app','m200213_172522_new_elements_index','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','5298acf6-11bc-4160-a292-6dd910fe8b93'),(168,NULL,'app','m200228_195211_long_deprecation_messages','2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:48','3bb0177b-6bc3-42a4-954e-461d05317034');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `plugins`
--

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `plugins` VALUES (1,'redactor','2.3.3.2','2.3.0','unknown',NULL,'2020-10-31 00:35:47','2020-10-31 00:35:47','2020-10-31 00:36:17','73f51a65-8eeb-4ac9-a530-ebf33fd5abb5'),(2,'servd-asset-storage','1.3.0','1.0','unknown',NULL,'2020-10-31 00:35:47','2020-10-31 00:35:47','2020-10-31 00:36:17','fc6c64ab-c57b-47b9-ab2c-aa2a9322bf91');
/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `projectconfig`
--

LOCK TABLES `projectconfig` WRITE;
/*!40000 ALTER TABLE `projectconfig` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `projectconfig` VALUES ('email.fromEmail','\"fake@fake-email-address.com\"'),('email.fromName','\"Servd Demo\"'),('email.transportType','\"craft\\\\mail\\\\transportadapters\\\\Sendmail\"'),('fieldGroups.41f0085a-91c4-4de0-8a54-a5d6419bb7a8.name','\"Common\"'),('plugins.redactor.edition','\"standard\"'),('plugins.redactor.enabled','true'),('plugins.redactor.schemaVersion','\"2.3.0\"'),('plugins.servd-asset-storage.edition','\"standard\"'),('plugins.servd-asset-storage.enabled','true'),('plugins.servd-asset-storage.schemaVersion','\"1.0\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.enableVersioning','false'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.handle','\"home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.hasTitleField','false'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.name','\"Home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.sortOrder','1'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.titleFormat','\"{section.name|raw}\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.entryTypes.eff33001-900c-4d66-8603-109687a40252.titleLabel','null'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.handle','\"home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.name','\"Home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.previewTargets.0.label','\"Primary entry page\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.previewTargets.0.urlFormat','\"{url}\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.propagationMethod','\"all\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.enabledByDefault','true'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.hasUrls','true'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.template','\"singles/home\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.siteSettings.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.uriFormat','\"__home__\"'),('sections.7b9fa0a4-623a-43e2-83a8-3d013cc6902e.type','\"single\"'),('siteGroups.30f1acc4-b407-4444-8edc-278ba32bf7c9.name','\"Servd Demo\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.baseUrl','\"http://localhost\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.handle','\"default\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.hasUrls','true'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.language','\"en\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.name','\"Servd Demo\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.primary','true'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.siteGroup','\"30f1acc4-b407-4444-8edc-278ba32bf7c9\"'),('sites.4a08a421-ed5e-4eb5-8dbc-018aed34c7d3.sortOrder','1'),('system.edition','\"solo\"'),('system.live','true'),('system.name','\"Servd Demo\"'),('system.schemaVersion','\"3.4.10\"'),('system.timeZone','\"America/Los_Angeles\"'),('users.allowPublicRegistration','false'),('users.defaultGroup','null'),('users.photoSubpath','\"\"'),('users.photoVolumeUid','null'),('users.requireEmailVerification','true'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.handle','\"servdAssets\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.hasUrls','true'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.name','\"Servd Assets\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.makeUploadsPublic','\"1\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.projectSlug','\"\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.securityKey','\"\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.settings.subfolder','\"\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.sortOrder','1'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.type','\"servd\\\\AssetStorage\\\\Volume\"'),('volumes.2f7839c9-4c87-4bf6-9d3c-2181918ec980.url','\"https://cdn2.assets-servd.host/\"');
/*!40000 ALTER TABLE `projectconfig` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `queue`
--

LOCK TABLES `queue` WRITE;
/*!40000 ALTER TABLE `queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `relations`
--

LOCK TABLES `relations` WRITE;
/*!40000 ALTER TABLE `relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `resourcepaths`
--

LOCK TABLES `resourcepaths` WRITE;
/*!40000 ALTER TABLE `resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `resourcepaths` VALUES ('15867de4','@craft/web/assets/dbbackup/dist'),('1f115ae8','@craft/web/assets/craftsupport/dist'),('200467ac','@craft/web/assets/feed/dist'),('231e2de2','@lib/jquery-ui'),('29c96dab','@lib/axios'),('53a8eacf','@lib/element-resize-detector'),('59474167','@craft/web/assets/dashboard/dist'),('60961e31','@craft/web/assets/updates/dist'),('6db7b647','@lib/velocity'),('719019af','@lib/jquery.payment'),('7c38413a','@bower/jquery/dist'),('8607ee8f','@craft/web/assets/recententries/dist'),('a2c37570','@craft/web/assets/cp/dist'),('a4ec5039','@lib/selectize'),('ae8014b3','@lib/xregexp'),('b8bdace1','@craft/web/assets/updateswidget/dist'),('cd8a4a6a','@lib/garnishjs'),('d8cc9e54','@lib/fabric'),('e87a7c43','@lib/fileupload'),('f0927dbd','@lib/picturefill'),('f736417f','@lib/jquery-touch-events'),('f8314dba','@craft/web/assets/utilities/dist'),('fe375dec','@lib/d3');
/*!40000 ALTER TABLE `resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `revisions`
--

LOCK TABLES `revisions` WRITE;
/*!40000 ALTER TABLE `revisions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `searchindex`
--

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `searchindex` VALUES (1,'slug',0,1,' home '),(1,'title',0,1,' home '),(2,'username',0,1,' therobbrennan '),(2,'firstname',0,1,''),(2,'lastname',0,1,''),(2,'fullname',0,1,''),(2,'email',0,1,' rob therobbrennan com '),(2,'slug',0,1,'');
/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections` VALUES (1,NULL,'Home','home','single',0,'all','[{\"label\":\"Primary entry page\",\"urlFormat\":\"{url}\"}]','2020-10-31 00:35:47','2020-10-31 00:35:47',NULL,'7b9fa0a4-623a-43e2-83a8-3d013cc6902e');
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sections_sites`
--

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sections_sites` VALUES (1,1,1,1,'__home__','singles/home',1,'2020-10-31 00:35:47','2020-10-31 00:35:47','88637bf6-f8aa-4813-ac6a-696e750a451b');
/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sequences`
--

LOCK TABLES `sequences` WRITE;
/*!40000 ALTER TABLE `sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `shunnedmessages`
--

LOCK TABLES `shunnedmessages` WRITE;
/*!40000 ALTER TABLE `shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sitegroups`
--

LOCK TABLES `sitegroups` WRITE;
/*!40000 ALTER TABLE `sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sitegroups` VALUES (1,'Servd Demo','2020-10-31 00:35:47','2020-10-31 00:35:47',NULL,'30f1acc4-b407-4444-8edc-278ba32bf7c9');
/*!40000 ALTER TABLE `sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `sites`
--

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `sites` VALUES (1,1,1,'Servd Demo','default','en',1,'http://localhost',1,'2020-10-31 00:35:47','2020-10-31 00:35:47',NULL,'4a08a421-ed5e-4eb5-8dbc-018aed34c7d3');
/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structureelements`
--

LOCK TABLES `structureelements` WRITE;
/*!40000 ALTER TABLE `structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `structures`
--

LOCK TABLES `structures` WRITE;
/*!40000 ALTER TABLE `structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `systemmessages`
--

LOCK TABLES `systemmessages` WRITE;
/*!40000 ALTER TABLE `systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `taggroups`
--

LOCK TABLES `taggroups` WRITE;
/*!40000 ALTER TABLE `taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `tokens`
--

LOCK TABLES `tokens` WRITE;
/*!40000 ALTER TABLE `tokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups`
--

LOCK TABLES `usergroups` WRITE;
/*!40000 ALTER TABLE `usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `usergroups_users`
--

LOCK TABLES `usergroups_users` WRITE;
/*!40000 ALTER TABLE `usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions`
--

LOCK TABLES `userpermissions` WRITE;
/*!40000 ALTER TABLE `userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_usergroups`
--

LOCK TABLES `userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpermissions_users`
--

LOCK TABLES `userpermissions_users` WRITE;
/*!40000 ALTER TABLE `userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `userpreferences`
--

LOCK TABLES `userpreferences` WRITE;
/*!40000 ALTER TABLE `userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `userpreferences` VALUES (2,'{\"language\":\"en\"}');
/*!40000 ALTER TABLE `userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `users` VALUES (2,'therobbrennan',NULL,NULL,NULL,'rob@therobbrennan.com','$2y$13$QjMQH9ql02FRNNJCl11lUe0OShRhEod8WEFdL3tjtGb3qcnk1jTf.',1,0,0,0,'2020-10-31 00:35:48',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2020-10-31 00:35:48','2020-10-31 00:35:48','2020-10-31 00:35:50','ae2ea35a-3147-4668-9843-f202cf82b544');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumefolders`
--

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumefolders` VALUES (1,NULL,1,'Servd Assets','','2020-10-31 00:35:47','2020-10-31 00:35:47','63f3d3e9-761a-4119-bb3a-1f70003e4d0e');
/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `volumes`
--

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `volumes` VALUES (1,NULL,'Servd Assets','servdAssets','servd\\AssetStorage\\Volume',1,'https://cdn2.assets-servd.host/','{\"makeUploadsPublic\":\"1\",\"projectSlug\":\"\",\"securityKey\":\"\",\"subfolder\":\"\"}',1,'2020-10-31 00:35:47','2020-10-31 00:35:47',NULL,'2f7839c9-4c87-4bf6-9d3c-2181918ec980');
/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `widgets`
--

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `widgets` VALUES (1,2,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2020-10-31 00:35:50','2020-10-31 00:35:50','13826217-0433-4205-af06-70d466579c53'),(2,2,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2020-10-31 00:35:50','2020-10-31 00:35:50','91b0ab06-5e36-4db0-b374-47e24576e5f4'),(3,2,'craft\\widgets\\Updates',3,NULL,'[]',1,'2020-10-31 00:35:50','2020-10-31 00:35:50','658407c7-1823-4972-99ef-fa10ea2474a7'),(4,2,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2020-10-31 00:35:50','2020-10-31 00:35:50','0cfdca9f-bf0c-402a-af22-28edc6882708');
/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'secret_polecat_staging'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-31  0:36:48
