-- MySQL dump 10.13  Distrib 5.5.62, for Win64 (AMD64)
--
-- Host: r5-large-cluster.cluster-corrh0fp2kuj.us-east-1.rds.amazonaws.com    Database: global_data
-- ------------------------------------------------------
-- Server version	5.7.12

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
-- Table structure for table `announcement_user`
--

DROP TABLE IF EXISTS `announcement_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcement_user` (
  `announcement_id` int(10) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `announcements` (
  `id` int(11) DEFAULT NULL,
  `title` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `body` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_connections`
--

DROP TABLE IF EXISTS `api_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_connections` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` varchar(80) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `connector_id` int(11) unsigned NOT NULL COMMENT 'The id for the connector data source for which the connection is connected',
  `connect_status` varchar(32) NOT NULL COMMENT 'Indicates whether a connector is currently connected to a service for a user.',
  `connect_error` text COMMENT 'Error message if there is a problem with authorizing this connection.',
  `update_requested_at` timestamp NULL DEFAULT NULL,
  `update_status` varchar(32) NOT NULL COMMENT 'Indicates whether a connector is currently updated.',
  `update_error` text COMMENT 'Indicates if there was an error during the update.',
  `last_successful_updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `total_measurements_in_last_update` int(10) DEFAULT NULL,
  `user_message` varchar(255) DEFAULT NULL,
  `latest_measurement_at` timestamp NULL DEFAULT NULL,
  `import_started_at` timestamp NULL DEFAULT NULL,
  `import_ended_at` timestamp NULL DEFAULT NULL,
  `reason_for_import` varchar(255) DEFAULT NULL,
  `user_error_message` text,
  `internal_error_message` text,
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `number_of_connector_imports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Imports for this Connection.\n                [Formula: \n                    update connections\n                        left join (\n                            select count(id) as total, connection_id\n                            from connector_imports\n                            group by connection_id\n                        )\n                        as grouped on connections.id = grouped.connection_id\n                    set connections.number_of_connector_imports = count(grouped.total)\n                ]\n                ',
  `number_of_connector_requests` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Requests for this Connection.\n                [Formula: \n                    update connections\n                        left join (\n                            select count(id) as total, connection_id\n                            from connector_requests\n                            group by connection_id\n                        )\n                        as grouped on connections.id = grouped.connection_id\n                    set connections.number_of_connector_requests = count(grouped.total)\n                ]\n                ',
  `credentials` text COMMENT 'Encrypted user credentials for accessing third party data',
  `imported_data_from_at` timestamp NULL DEFAULT NULL COMMENT 'Earliest data that we''ve requested from this data source ',
  `imported_data_end_at` timestamp NULL DEFAULT NULL COMMENT 'Most recent data that we''ve requested from this data source ',
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this Connection.\n                    [Formula: update connections\n                        left join (\n                            select count(id) as total, connection_id\n                            from measurements\n                            group by connection_id\n                        )\n                        as grouped on connections.id = grouped.connection_id\n                    set connections.number_of_measurements = count(grouped.total)]',
  `is_public` tinyint(1) DEFAULT NULL,
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  `meta` text COMMENT 'Additional meta data instructions for import, such as a list of repositories the Github connector should import from. ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UX_userId_connectorId` (`user_id`,`connector_id`) USING BTREE,
  UNIQUE KEY `connections_slug_uindex` (`slug`),
  KEY `status_update_requested` (`update_requested_at`,`update_status`) USING BTREE,
  KEY `status` (`update_status`) USING BTREE,
  KEY `IDX_status` (`connect_status`) USING BTREE,
  KEY `connections_connectors_id_fk` (`connector_id`),
  KEY `connections_client_id_fk` (`client_id`),
  KEY `connections_wp_posts_ID_fk` (`wp_post_id`),
  CONSTRAINT `connections_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `connections_connectors_id_fk` FOREIGN KEY (`connector_id`) REFERENCES `api_connectors` (`id`),
  CONSTRAINT `connections_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `connections_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=16248 DEFAULT CHARSET=utf8 COMMENT='Connections to 3rd party data sources that we can import from for a given user.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_connector_devices`
--

DROP TABLE IF EXISTS `api_connector_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_connector_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` tinytext,
  `display_name` tinytext,
  `image` varchar(2083) DEFAULT NULL,
  `get_it_url` varchar(2083) DEFAULT NULL,
  `short_description` mediumtext,
  `long_description` longtext,
  `enabled` tinyint(4) DEFAULT NULL,
  `oauth` tinyint(4) DEFAULT NULL,
  `qm_client` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `client_id` tinytext,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_parent` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COMMENT='Various devices whose data may be obtained from a given connector''s API';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_connector_imports`
--

DROP TABLE IF EXISTS `api_connector_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_connector_imports` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` varchar(80) DEFAULT NULL,
  `connection_id` int(11) unsigned DEFAULT NULL,
  `connector_id` int(11) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `earliest_measurement_at` timestamp NULL DEFAULT NULL,
  `import_ended_at` timestamp NULL DEFAULT NULL,
  `import_started_at` timestamp NULL DEFAULT NULL,
  `internal_error_message` text,
  `latest_measurement_at` timestamp NULL DEFAULT NULL,
  `number_of_measurements` int(11) unsigned NOT NULL DEFAULT '0',
  `reason_for_import` varchar(255) DEFAULT NULL,
  `success` tinyint(1) DEFAULT '1',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_error_message` text,
  `user_id` bigint(20) unsigned NOT NULL,
  `additional_meta_data` json DEFAULT NULL,
  `number_of_connector_requests` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Requests for this Connector Import.\n                [Formula: \n                    update connector_imports\n                        left join (\n                            select count(id) as total, connector_import_id\n                            from connector_requests\n                            group by connector_import_id\n                        )\n                        as grouped on connector_imports.id = grouped.connector_import_id\n                    set connector_imports.number_of_connector_requests = count(grouped.total)\n                ]\n                ',
  `imported_data_from_at` timestamp NULL DEFAULT NULL COMMENT 'Earliest data that we''ve requested from this data source ',
  `imported_data_end_at` timestamp NULL DEFAULT NULL COMMENT 'Most recent data that we''ve requested from this data source ',
  `credentials` text COMMENT 'Encrypted user credentials for accessing third party data',
  `connector_requests` timestamp NULL DEFAULT NULL COMMENT 'Most recent data that we''ve requested from this data source ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `connector_imports_connector_id_user_id_created_at_uindex` (`connector_id`,`user_id`,`created_at`),
  UNIQUE KEY `connector_imports_connection_id_created_at_uindex` (`connection_id`,`created_at`),
  KEY `IDX_connector_imports_user_connector` (`user_id`,`connector_id`),
  KEY `connector_imports_client_id_fk` (`client_id`),
  CONSTRAINT `connector_imports_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `connector_imports_connections_id_fk` FOREIGN KEY (`connection_id`) REFERENCES `api_connections` (`id`),
  CONSTRAINT `connector_imports_connectors_id_fk` FOREIGN KEY (`connector_id`) REFERENCES `api_connectors` (`id`),
  CONSTRAINT `connector_imports_wp_users_ID_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85040 DEFAULT CHARSET=utf8 COMMENT='A record of attempts to import from a given data source.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_connector_requests`
--

DROP TABLE IF EXISTS `api_connector_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_connector_requests` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `connector_id` int(11) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `connection_id` int(11) unsigned DEFAULT NULL,
  `connector_import_id` int(10) unsigned NOT NULL,
  `method` varchar(10) NOT NULL,
  `code` int(11) NOT NULL,
  `uri` varchar(2083) NOT NULL,
  `response_body` mediumtext,
  `request_body` text,
  `request_headers` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `content_type` varchar(100) DEFAULT NULL,
  `imported_data_from_at` timestamp NULL DEFAULT NULL COMMENT 'Earliest data that we''ve requested from this data source ',
  PRIMARY KEY (`id`),
  KEY `connector_requests_connector_imports_id_fk` (`connector_import_id`),
  KEY `connector_requests_wp_users_ID_fk` (`user_id`),
  KEY `connector_requests_connections_id_fk` (`connection_id`),
  KEY `connector_requests_connectors_id_fk` (`connector_id`),
  CONSTRAINT `connector_requests_connections_id_fk` FOREIGN KEY (`connection_id`) REFERENCES `api_connections` (`id`),
  CONSTRAINT `connector_requests_connector_imports_id_fk` FOREIGN KEY (`connector_import_id`) REFERENCES `api_connector_imports` (`id`),
  CONSTRAINT `connector_requests_connectors_id_fk` FOREIGN KEY (`connector_id`) REFERENCES `api_connectors` (`id`),
  CONSTRAINT `connector_requests_wp_users_ID_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='An API request made to an HTTP endpoint during import from a data source.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_connectors`
--

DROP TABLE IF EXISTS `api_connectors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_connectors` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Connector ID number',
  `name` varchar(30) NOT NULL COMMENT 'Lowercase system name for the data source',
  `display_name` varchar(30) NOT NULL COMMENT 'Pretty display name for the data source',
  `image` varchar(2083) NOT NULL COMMENT 'URL to the image of the connector logo',
  `get_it_url` varchar(2083) DEFAULT NULL COMMENT 'URL to a site where one can get this device or application',
  `short_description` text NOT NULL COMMENT 'Short description of the service (such as the categories it tracks)',
  `long_description` longtext NOT NULL COMMENT 'Longer paragraph description of the data provider',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Set to 1 if the connector should be returned when listing connectors',
  `oauth` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Set to 1 if the connector uses OAuth authentication as opposed to username/password',
  `qm_client` tinyint(1) DEFAULT '0' COMMENT 'Whether its a connector or one of our clients',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id` varchar(80) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `number_of_connections` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connections for this Connector.\n                [Formula: \n                    update connectors\n                        left join (\n                            select count(id) as total, connector_id\n                            from connections\n                            group by connector_id\n                        )\n                        as grouped on connectors.id = grouped.connector_id\n                    set connectors.number_of_connections = count(grouped.total)\n                ]\n                ',
  `number_of_connector_imports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Imports for this Connector.\n                [Formula: \n                    update connectors\n                        left join (\n                            select count(id) as total, connector_id\n                            from connector_imports\n                            group by connector_id\n                        )\n                        as grouped on connectors.id = grouped.connector_id\n                    set connectors.number_of_connector_imports = count(grouped.total)\n                ]\n                ',
  `number_of_connector_requests` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Requests for this Connector.\n                [Formula: \n                    update connectors\n                        left join (\n                            select count(id) as total, connector_id\n                            from connector_requests\n                            group by connector_id\n                        )\n                        as grouped on connectors.id = grouped.connector_id\n                    set connectors.number_of_connector_requests = count(grouped.total)\n                ]\n                ',
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this Connector.\n                    [Formula: update connectors\n                        left join (\n                            select count(id) as total, connector_id\n                            from measurements\n                            group by connector_id\n                        )\n                        as grouped on connectors.id = grouped.connector_id\n                    set connectors.number_of_measurements = count(grouped.total)]',
  `is_public` tinyint(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `connectors_slug_uindex` (`slug`),
  KEY `connectors_client_id_fk` (`client_id`),
  KEY `connectors_wp_posts_ID_fk` (`wp_post_id`),
  CONSTRAINT `connectors_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `connectors_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=utf8 COMMENT='A connector pulls data from other data providers using their API or a screenscraper. Returns a list of all available connectors and information about them such as their id, name, whether the user has provided access, logo url, connection instructions, and the update history.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `api_keys`
--

DROP TABLE IF EXISTS `api_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `api_keys` (
  `id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `key` varchar(60) DEFAULT NULL,
  `last_used_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `applications`
--

DROP TABLE IF EXISTS `applications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `applications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` int(10) unsigned DEFAULT NULL,
  `client_id` varchar(80) NOT NULL,
  `app_display_name` varchar(255) NOT NULL,
  `app_description` varchar(255) DEFAULT NULL,
  `long_description` text,
  `user_id` bigint(20) unsigned NOT NULL,
  `icon_url` varchar(2083) DEFAULT NULL,
  `text_logo` varchar(2083) DEFAULT NULL,
  `splash_screen` varchar(2083) DEFAULT NULL,
  `homepage_url` varchar(255) DEFAULT NULL,
  `app_type` varchar(32) DEFAULT NULL,
  `app_design` mediumtext,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `enabled` tinyint(4) NOT NULL DEFAULT '1',
  `stripe_active` tinyint(4) NOT NULL DEFAULT '0',
  `stripe_id` varchar(255) DEFAULT NULL,
  `stripe_subscription` varchar(255) DEFAULT NULL,
  `stripe_plan` varchar(100) DEFAULT NULL,
  `last_four` varchar(4) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `subscription_ends_at` timestamp NULL DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `zip` varchar(10) DEFAULT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `exceeding_call_count` int(11) NOT NULL DEFAULT '0',
  `exceeding_call_charge` decimal(16,2) DEFAULT NULL,
  `study` tinyint(4) NOT NULL DEFAULT '0',
  `billing_enabled` tinyint(4) NOT NULL DEFAULT '1',
  `outcome_variable_id` int(10) unsigned DEFAULT NULL,
  `predictor_variable_id` int(10) unsigned DEFAULT NULL,
  `physician` tinyint(4) NOT NULL DEFAULT '0',
  `additional_settings` text COMMENT 'Additional non-design settings for your application.',
  `app_status` text COMMENT 'The current build status for the iOS app, Android app, and Chrome extension.',
  `build_enabled` tinyint(1) NOT NULL DEFAULT '0',
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `number_of_collaborators_where_app` int(10) unsigned DEFAULT NULL COMMENT 'Number of Collaborators for this App.\n                [Formula: \n                    update applications\n                        left join (\n                            select count(id) as total, app_id\n                            from collaborators\n                            group by app_id\n                        )\n                        as grouped on applications.id = grouped.app_id\n                    set applications.number_of_collaborators_where_app = count(grouped.total)\n                ]\n                ',
  `is_public` tinyint(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `applications_client_id_unique` (`client_id`) USING BTREE,
  UNIQUE KEY `applications_slug_uindex` (`slug`),
  KEY `applications_user_id_fk` (`user_id`),
  KEY `applications_wp_posts_ID_fk` (`wp_post_id`),
  KEY `applications_outcome_variable_id_fk` (`outcome_variable_id`),
  KEY `applications_predictor_variable_id_fk` (`predictor_variable_id`),
  CONSTRAINT `applications_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `applications_outcome_variable_id_fk` FOREIGN KEY (`outcome_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `applications_predictor_variable_id_fk` FOREIGN KEY (`predictor_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `applications_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `applications_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4958 DEFAULT CHARSET=utf8 COMMENT='Settings for applications created by the no-code QuantiModo app builder at https://builder.quantimo.do.  ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `biomarkers`
--

DROP TABLE IF EXISTS `biomarkers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `biomarkers` (
  `slug` text,
  `type` text,
  `subtype` text,
  `classification` text,
  `name_short` text,
  `name_long` text,
  `unit` text,
  `default_value` text,
  `description` text,
  `references` text,
  `range_min` text,
  `range_max` text,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blood_lipids`
--

DROP TABLE IF EXISTS `blood_lipids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blood_lipids` (
  `slug` text,
  `type` text,
  `subtype` text,
  `classification` text,
  `name_short` text,
  `name_long` text,
  `unit` text,
  `default_value` text,
  `description` text,
  `references` text,
  `range_min` text,
  `range_max` text,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `blood_test_reference_ranges`
--

DROP TABLE IF EXISTS `blood_test_reference_ranges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blood_test_reference_ranges` (
  `Test` varchar(59) DEFAULT NULL,
  `Normal_Range_Low` float DEFAULT NULL,
  `Normal_Range_High` float DEFAULT NULL,
  `Ideal_Range_Low` float DEFAULT NULL,
  `Ideal_Range_High` float DEFAULT NULL,
  `Unit` varchar(255) DEFAULT NULL,
  `Abreviation` varchar(255) DEFAULT NULL,
  `Age_Variance` varchar(1) DEFAULT NULL,
  `Category` varchar(35) DEFAULT NULL,
  `Wikipedia` varchar(999) DEFAULT NULL,
  `Short_Description` text,
  `AwesomeList` varchar(1) DEFAULT NULL,
  `Notes` time DEFAULT NULL,
  `Source1` varchar(255) DEFAULT NULL,
  `Source1_URL` varchar(255) DEFAULT NULL,
  `Source2` varchar(255) DEFAULT NULL,
  `Source2_URL` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinical_trial_conditions`
--

DROP TABLE IF EXISTS `clinical_trial_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trial_conditions` (
  `id` int(11) NOT NULL,
  `nct_id` varchar(4369) DEFAULT NULL,
  `name` varchar(4369) DEFAULT NULL,
  `downcase_name` varchar(4369) DEFAULT NULL,
  `variable_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ctg_conditions_variable_id_uindex` (`variable_id`),
  CONSTRAINT `ctg_conditions_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Conditions from clinicaltrials.gov';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinical_trial_intervention_other_names`
--

DROP TABLE IF EXISTS `clinical_trial_intervention_other_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trial_intervention_other_names` (
  `id` int(11) NOT NULL,
  `nct_id` varchar(4369) DEFAULT NULL,
  `intervention_id` int(11) DEFAULT NULL,
  `name` varchar(4369) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Terms or phrases that are synonymous with an intervention. (Each row is linked to one of the interventions associated with the study.)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinical_trial_interventions`
--

DROP TABLE IF EXISTS `clinical_trial_interventions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinical_trial_interventions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nct_id` varchar(4369) DEFAULT NULL,
  `intervention_type` varchar(4369) DEFAULT NULL,
  `name` varchar(4369) DEFAULT NULL,
  `description` text,
  `variable_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ctg_interventions_variable_id_uindex` (`variable_id`),
  CONSTRAINT `ctg_interventions_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9201193 DEFAULT CHARSET=latin1 COMMENT='Interventions from clinicaltrials.gov';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `collaborators`
--

DROP TABLE IF EXISTS `collaborators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `collaborators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `app_id` int(10) unsigned NOT NULL,
  `type` enum('owner','collaborator') NOT NULL DEFAULT 'collaborator',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `collaborators_user_client_index` (`user_id`,`client_id`) USING BTREE,
  KEY `collaborators_applications_id_fk` (`app_id`),
  KEY `collaborators_client_id_fk` (`client_id`),
  CONSTRAINT `collaborators_applications_id_fk` FOREIGN KEY (`app_id`) REFERENCES `applications` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `collaborators_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `collaborators_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Collaborators authorized to edit applications in the app builder';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_collection_methods`
--

DROP TABLE IF EXISTS `data_collection_methods`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_collection_methods` (
  `slug` text,
  `name` text,
  `error` double DEFAULT NULL,
  `quality` text,
  `description` text,
  `references` text,
  `biomarkers_0` text,
  `biomarkers_1` text,
  `biomarkers_2` text,
  `biomarkers_3` text,
  `biomarkers_4` text,
  `biomarkers_5` text,
  `biomarkers_6` text,
  `biomarkers_7` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_rows`
--

DROP TABLE IF EXISTS `data_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_rows` (
  `id` int(11) DEFAULT NULL,
  `data_type_id` int(11) DEFAULT NULL,
  `field` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `display_name` varchar(191) DEFAULT NULL,
  `required` tinyint(4) DEFAULT NULL,
  `browse` tinyint(4) DEFAULT NULL,
  `read` tinyint(4) DEFAULT NULL,
  `edit` tinyint(4) DEFAULT NULL,
  `add` tinyint(4) DEFAULT NULL,
  `delete` tinyint(4) DEFAULT NULL,
  `details` text,
  `order` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_source_platforms`
--

DROP TABLE IF EXISTS `data_source_platforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_source_platforms` (
  `id` smallint(5) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `source_platforms_client_id_fk` (`client_id`),
  CONSTRAINT `source_platforms_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `data_types`
--

DROP TABLE IF EXISTS `data_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_types` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `display_name_singular` varchar(191) DEFAULT NULL,
  `display_name_plural` varchar(191) DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `model_name` varchar(191) DEFAULT NULL,
  `policy_name` varchar(191) DEFAULT NULL,
  `controller` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `generate_permissions` tinyint(4) DEFAULT NULL,
  `server_side` tinyint(4) DEFAULT NULL,
  `details` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dlsd_supplement_ingredients`
--

DROP TABLE IF EXISTS `dlsd_supplement_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dlsd_supplement_ingredients` (
  `Ingredient_Name` varchar(255) NOT NULL,
  `Primary_Ingredient_Group_ID` int(11) DEFAULT NULL,
  `synonyms` text,
  `Total_Number_of_Labels` int(11) DEFAULT NULL,
  `Count_of_Labels_in_NHANES` int(11) DEFAULT NULL,
  `All_Ingredient_Group_ID` int(11) DEFAULT NULL,
  `Sample_DSLD_IDs` text,
  `Sample_DSLD_IDs_in_NHANES` text,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39409 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dsld_supplement_products`
--

DROP TABLE IF EXISTS `dsld_supplement_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dsld_supplement_products` (
  `DSLD_ID` int(11) DEFAULT NULL,
  `Brand_Name` text,
  `Product_Name` text,
  `Net_Contents` double DEFAULT NULL,
  `Net_Content_Unit` text,
  `Serving_Size_Quantity` int(11) DEFAULT NULL,
  `Serving_Size_Unit` text,
  `Product_Type` text,
  `Supplement_Form` text,
  `Dietary_Claims` text,
  `Intended_Target_Group` text,
  `Database` text,
  `Tracking_History` text,
  `Date` text,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92072 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_studies`
--

DROP TABLE IF EXISTS `global_studies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_studies` (
  `id` varchar(80) NOT NULL COMMENT 'Study id which should match OAuth client id',
  `type` varchar(20) NOT NULL COMMENT 'The type of study may be population, individual, or cohort study',
  `cause_variable_id` int(10) unsigned NOT NULL COMMENT 'variable ID of the cause variable for which the user desires correlations',
  `effect_variable_id` int(10) unsigned NOT NULL COMMENT 'variable ID of the effect variable for which the user desires correlations',
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `analysis_parameters` text COMMENT 'Additional parameters for the study such as experiment_end_time, experiment_start_time, cause_variable_filling_value, effect_variable_filling_value',
  `user_study_text` longtext COMMENT 'Overrides auto-generated study text',
  `user_title` text,
  `study_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `study_password` varchar(20) DEFAULT NULL,
  `study_images` text COMMENT 'Provided images will override the auto-generated images',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id` varchar(255) DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `wp_post_id` int(11) DEFAULT NULL,
  `newest_data_at` timestamp NULL DEFAULT NULL,
  `analysis_requested_at` timestamp NULL DEFAULT NULL,
  `reason_for_analysis` varchar(255) DEFAULT NULL,
  `analysis_ended_at` timestamp NULL DEFAULT NULL,
  `analysis_started_at` timestamp NULL DEFAULT NULL,
  `internal_error_message` varchar(255) DEFAULT NULL,
  `user_error_message` varchar(255) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `analysis_settings_modified_at` timestamp NULL DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL COMMENT 'Indicates whether the study is private or should be publicly displayed.',
  `sort_order` int(11) NOT NULL,
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_cause_effect_type` (`user_id`,`cause_variable_id`,`effect_variable_id`,`type`),
  UNIQUE KEY `studies_slug_uindex` (`slug`),
  KEY `cause_variable_id` (`cause_variable_id`),
  KEY `effect_variable_id` (`effect_variable_id`),
  KEY `studies_client_id_fk` (`client_id`),
  CONSTRAINT `studies_cause_variable_id_variables_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `studies_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `studies_effect_variable_id_variables_id_fk` FOREIGN KEY (`effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `studies_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores Study Settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_study_causality_votes`
--

DROP TABLE IF EXISTS `global_study_causality_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_study_causality_votes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cause_variable_id` int(11) unsigned NOT NULL,
  `effect_variable_id` int(11) unsigned NOT NULL,
  `correlation_id` int(11) DEFAULT NULL,
  `aggregate_correlation_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `vote` int(11) NOT NULL COMMENT 'The opinion of the data owner on whether or not there is a plausible\n                                mechanism of action by which the predictor variable could influence the outcome variable.',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(80) CHARACTER SET utf8 DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correlation_causality_votes_user_cause_effect_uindex` (`user_id`,`cause_variable_id`,`effect_variable_id`),
  KEY `correlation_causality_votes_aggregate_correlations_id_fk` (`aggregate_correlation_id`),
  KEY `correlation_causality_votes_cause_variables_id_fk` (`cause_variable_id`),
  KEY `correlation_causality_votes_client_id_fk` (`client_id`),
  KEY `correlation_causality_votes_correlations_id_fk` (`correlation_id`),
  KEY `correlation_causality_votes_effect_variables_id_fk` (`effect_variable_id`),
  CONSTRAINT `correlation_causality_votes_aggregate_correlations_id_fk` FOREIGN KEY (`aggregate_correlation_id`) REFERENCES `global_study_results` (`id`),
  CONSTRAINT `correlation_causality_votes_cause_variables_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `correlation_causality_votes_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `correlation_causality_votes_correlations_id_fk` FOREIGN KEY (`correlation_id`) REFERENCES `user_study_results` (`id`),
  CONSTRAINT `correlation_causality_votes_effect_variables_id_fk` FOREIGN KEY (`effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `correlation_causality_votes_wp_users_ID_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='The opinion of the data owner on whether or not there is a plausible mechanism of action by which the predictor variable could influence the outcome variable.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_study_results`
--

DROP TABLE IF EXISTS `global_study_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_study_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `forward_pearson_correlation_coefficient` float(10,4) NOT NULL COMMENT 'Pearson correlation coefficient between cause and effect measurements',
  `onset_delay` int(11) NOT NULL COMMENT 'User estimated or default time after cause measurement before a perceivable effect is observed',
  `duration_of_action` int(11) NOT NULL COMMENT 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
  `number_of_pairs` int(11) NOT NULL COMMENT 'Number of points that went into the correlation calculation',
  `value_predicting_high_outcome` double NOT NULL COMMENT 'cause value that predicts an above average effect value (in default unit for cause variable)',
  `value_predicting_low_outcome` double NOT NULL COMMENT 'cause value that predicts a below average effect value (in default unit for cause variable)',
  `optimal_pearson_product` double NOT NULL COMMENT 'Optimal Pearson Product',
  `average_vote` float(3,1) DEFAULT '0.5' COMMENT 'Vote',
  `number_of_users` int(11) NOT NULL COMMENT 'Number of Users by which correlation is aggregated',
  `number_of_correlations` int(11) NOT NULL COMMENT 'Number of Correlations by which correlation is aggregated',
  `statistical_significance` float(10,4) NOT NULL COMMENT 'A function of the effect size and sample size',
  `cause_unit_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Unit ID of Cause',
  `cause_changes` int(11) NOT NULL COMMENT 'The number of times the cause measurement value was different from the one preceding it.',
  `effect_changes` int(11) NOT NULL COMMENT 'The number of times the effect measurement value was different from the one preceding it.',
  `aggregate_qm_score` double NOT NULL COMMENT 'A number representative of the relative importance of the relationship based on the strength, usefulness, and plausible causality.  The higher the number, the greater the perceived importance.  This value can be used for sorting relationships by importance. ',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(25) NOT NULL COMMENT 'Whether the correlation is being analyzed, needs to be analyzed, or is up to date already.',
  `reverse_pearson_correlation_coefficient` double NOT NULL COMMENT 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
  `predictive_pearson_correlation_coefficient` double NOT NULL COMMENT 'Pearson correlation coefficient of cause and effect values lagged by the onset delay and grouped based on the duration of action. ',
  `data_source_name` varchar(255) DEFAULT NULL,
  `predicts_high_effect_change` int(5) NOT NULL COMMENT 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
  `predicts_low_effect_change` int(5) NOT NULL COMMENT 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
  `p_value` double NOT NULL COMMENT 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
  `t_value` double NOT NULL COMMENT 'Function of correlation and number of samples.',
  `critical_t_value` double NOT NULL COMMENT 'Value of t from lookup table which t must exceed for significance.',
  `confidence_interval` double NOT NULL COMMENT 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `average_effect` double NOT NULL COMMENT 'The average effect variable measurement value used in analysis in the common unit. ',
  `average_effect_following_high_cause` double NOT NULL COMMENT 'The average effect variable measurement value following an above average cause value (in the common unit). ',
  `average_effect_following_low_cause` double NOT NULL COMMENT 'The average effect variable measurement value following a below average cause value (in the common unit). ',
  `average_daily_low_cause` double NOT NULL COMMENT 'The average of below average cause values (in the common unit). ',
  `average_daily_high_cause` double NOT NULL COMMENT 'The average of above average cause values (in the common unit). ',
  `population_trait_pearson_correlation_coefficient` double DEFAULT NULL COMMENT 'The pearson correlation of pairs which each consist of the average cause value and the average effect value for a given user. ',
  `grouped_cause_value_closest_to_value_predicting_low_outcome` double NOT NULL COMMENT 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
  `grouped_cause_value_closest_to_value_predicting_high_outcome` double NOT NULL COMMENT 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
  `client_id` varchar(255) DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `cause_variable_category_id` tinyint(3) unsigned NOT NULL,
  `effect_variable_category_id` tinyint(3) unsigned NOT NULL,
  `interesting_variable_category_pair` tinyint(1) NOT NULL COMMENT 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ',
  `newest_data_at` timestamp NULL DEFAULT NULL,
  `analysis_requested_at` timestamp NULL DEFAULT NULL,
  `reason_for_analysis` varchar(255) NOT NULL COMMENT 'The reason analysis was requested.',
  `analysis_started_at` timestamp NOT NULL,
  `analysis_ended_at` timestamp NULL DEFAULT NULL,
  `user_error_message` text,
  `internal_error_message` text,
  `cause_variable_id` int(10) unsigned NOT NULL,
  `effect_variable_id` int(10) unsigned NOT NULL,
  `cause_baseline_average_per_day` float NOT NULL COMMENT 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)',
  `cause_baseline_average_per_duration_of_action` float NOT NULL COMMENT 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)',
  `cause_treatment_average_per_day` float NOT NULL COMMENT 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)',
  `cause_treatment_average_per_duration_of_action` float NOT NULL COMMENT 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)',
  `effect_baseline_average` float NOT NULL COMMENT 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)',
  `effect_baseline_relative_standard_deviation` float NOT NULL COMMENT 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)',
  `effect_baseline_standard_deviation` float NOT NULL COMMENT 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)',
  `effect_follow_up_average` float NOT NULL COMMENT 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
  `effect_follow_up_percent_change_from_baseline` float NOT NULL COMMENT 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
  `z_score` float NOT NULL COMMENT 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.',
  `charts` json NOT NULL,
  `number_of_variables_where_best_aggregate_correlation` int(10) unsigned NOT NULL COMMENT 'Number of Variables for this Best Aggregate Correlation.\n                    [Formula: update aggregate_correlations\n                        left join (\n                            select count(id) as total, best_aggregate_correlation_id\n                            from variables\n                            group by best_aggregate_correlation_id\n                        )\n                        as grouped on aggregate_correlations.id = grouped.best_aggregate_correlation_id\n                    set aggregate_correlations.number_of_variables_where_best_aggregate_correlation = count(grouped.total)]',
  `deletion_reason` varchar(280) DEFAULT NULL COMMENT 'The reason the variable was deleted.',
  `record_size_in_kb` int(11) DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `boring` tinyint(1) DEFAULT NULL COMMENT 'The relationship is boring if it is obvious, the predictor is not controllable, or the outcome is not a goal, the relationship could not be causal, or the confidence is low.  ',
  `outcome_is_a_goal` tinyint(1) DEFAULT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
  `predictor_is_controllable` tinyint(1) DEFAULT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
  `plausibly_causal` tinyint(1) DEFAULT NULL COMMENT 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ',
  `obvious` tinyint(1) DEFAULT NULL COMMENT 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ',
  `number_of_up_votes` int(11) NOT NULL COMMENT 'Number of people who feel this relationship is plausible and useful. ',
  `number_of_down_votes` int(11) NOT NULL COMMENT 'Number of people who feel this relationship is implausible or not useful. ',
  `strength_level` enum('VERY STRONG','STRONG','MODERATE','WEAK','VERY WEAK') NOT NULL COMMENT 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ',
  `confidence_level` enum('HIGH','MEDIUM','LOW') NOT NULL COMMENT 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ',
  `relationship` enum('POSITIVE','NEGATIVE','NONE') NOT NULL COMMENT 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ',
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `aggregate_correlations_pk` (`cause_variable_id`,`effect_variable_id`),
  UNIQUE KEY `cause_variable_id_effect_variable_id_uindex` (`cause_variable_id`,`effect_variable_id`),
  UNIQUE KEY `aggregate_correlations_slug_uindex` (`slug`),
  KEY `aggregate_correlations_client_id_fk` (`client_id`),
  KEY `aggregate_correlations_cause_variable_category_id_fk` (`cause_variable_category_id`),
  KEY `aggregate_correlations_effect_variable_category_id_fk` (`effect_variable_category_id`),
  KEY `aggregate_correlations_cause_unit_id_fk` (`cause_unit_id`),
  KEY `aggregate_correlations_wp_posts_ID_fk` (`wp_post_id`),
  KEY `aggregate_correlations_effect_variable_id_index` (`effect_variable_id`),
  CONSTRAINT `aggregate_correlations_cause_unit_id_fk` FOREIGN KEY (`cause_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `aggregate_correlations_cause_variable_category_id_fk` FOREIGN KEY (`cause_variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `aggregate_correlations_cause_variables_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `aggregate_correlations_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `aggregate_correlations_effect_variable_category_id_fk` FOREIGN KEY (`effect_variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `aggregate_correlations_effect_variables_id_fk` FOREIGN KEY (`effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `aggregate_correlations_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=65934693 DEFAULT CHARSET=utf8 COMMENT='Stores Calculated Aggregated Correlation Coefficients';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_study_usefulness_votes`
--

DROP TABLE IF EXISTS `global_study_usefulness_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_study_usefulness_votes` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cause_variable_id` int(11) unsigned NOT NULL,
  `effect_variable_id` int(11) unsigned NOT NULL,
  `correlation_id` int(11) DEFAULT NULL,
  `aggregate_correlation_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `vote` int(11) NOT NULL COMMENT 'The opinion of the data owner on whether or not knowledge of this \n                    relationship is useful in helping them improve an outcome of interest. \n                    -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a \n                    previous vote.  null corresponds to never having voted before.',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(80) CHARACTER SET utf8 DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `correlation_usefulness_votes_user_cause_effect_uindex` (`user_id`,`cause_variable_id`,`effect_variable_id`),
  KEY `correlation_usefulness_votes_aggregate_correlations_id_fk` (`aggregate_correlation_id`),
  KEY `correlation_usefulness_votes_client_id_fk` (`client_id`),
  KEY `correlation_usefulness_votes_correlations_id_fk` (`correlation_id`),
  KEY `correlation_usefulness_votes_cause_variables_id_fk` (`cause_variable_id`),
  KEY `correlation_usefulness_votes_effect_variables_id_fk` (`effect_variable_id`),
  CONSTRAINT `correlation_usefulness_votes_aggregate_correlations_id_fk` FOREIGN KEY (`aggregate_correlation_id`) REFERENCES `global_study_results` (`id`),
  CONSTRAINT `correlation_usefulness_votes_cause_variables_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `correlation_usefulness_votes_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `correlation_usefulness_votes_correlations_id_fk` FOREIGN KEY (`correlation_id`) REFERENCES `user_study_results` (`id`),
  CONSTRAINT `correlation_usefulness_votes_effect_variables_id_fk` FOREIGN KEY (`effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `correlation_usefulness_votes_wp_users_ID_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='The opinion of the data owner on whether or not knowledge of this relationship is useful in helping them improve an outcome of interest. -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a previous vote.  null corresponds to never having voted before.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_study_votes`
--

DROP TABLE IF EXISTS `global_study_votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_study_votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(80) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `value` int(11) NOT NULL COMMENT 'Value of Vote',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `cause_variable_id` int(10) unsigned NOT NULL,
  `effect_variable_id` int(10) unsigned NOT NULL,
  `correlation_id` int(11) DEFAULT NULL,
  `aggregate_correlation_id` int(11) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `votes_user_id_cause_variable_id_effect_variable_id_uindex` (`user_id`,`cause_variable_id`,`effect_variable_id`),
  KEY `votes_client_id_fk` (`client_id`),
  KEY `votes_cause_variable_id_index` (`cause_variable_id`),
  KEY `votes_effect_variable_id_index` (`effect_variable_id`),
  KEY `votes_correlations_id_fk` (`correlation_id`),
  KEY `votes_aggregate_correlations_id_fk` (`aggregate_correlation_id`),
  CONSTRAINT `votes_aggregate_correlations_id_fk` FOREIGN KEY (`aggregate_correlation_id`) REFERENCES `global_study_results` (`id`) ON DELETE SET NULL,
  CONSTRAINT `votes_cause_variable_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `votes_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `votes_correlations_id_fk` FOREIGN KEY (`correlation_id`) REFERENCES `user_study_results` (`id`),
  CONSTRAINT `votes_effect_variable_id_fk_2` FOREIGN KEY (`effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `votes_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30388 DEFAULT CHARSET=utf8 COMMENT='Vote thumbs down button for relationships that you think are coincidences and thumbs up for correlations with a plausible causal explanation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_variable_child_parent`
--

DROP TABLE IF EXISTS `global_variable_child_parent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_variable_child_parent` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `child_global_variable_id` int(10) unsigned NOT NULL COMMENT 'This is the id of the variable being tagged with an ingredient or something.',
  `parent_global_variable_id` int(10) unsigned NOT NULL COMMENT 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.',
  `client_id` varchar(80) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_tag_tagged` (`child_global_variable_id`,`parent_global_variable_id`),
  KEY `common_tags_client_id_fk` (`client_id`) USING BTREE,
  KEY `common_tags_tag_variable_id_variables_id_fk` (`parent_global_variable_id`) USING BTREE,
  CONSTRAINT `common_tags_client_id_fk_copy` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `common_tags_tag_variable_id_variables_id_fk_copy` FOREIGN KEY (`parent_global_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `common_tags_tagged_variable_id_variables_id_fk_copy` FOREIGN KEY (`child_global_variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1107724 DEFAULT CHARSET=utf8 COMMENT='Variable tags are used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_variable_food_ingredient`
--

DROP TABLE IF EXISTS `global_variable_food_ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_variable_food_ingredient` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `food_global_variable_id` int(10) unsigned NOT NULL COMMENT 'This is the id of the food or composite variable being tagged with an ingredient.',
  `ingredient_global_variable_id` int(10) unsigned NOT NULL COMMENT 'This is the id of the ingredient variable whose value is inferred based on the value of the food or composite variable.',
  `number_of_data_points` int(10) DEFAULT NULL COMMENT 'The number of data points used to estimate the mean ingredient concentration from testing.',
  `standard_error` float DEFAULT NULL COMMENT 'Measure of variability of the \r\nmean value as a function of the number of data points.',
  `ingredient_global_variable_unit_id` smallint(5) unsigned DEFAULT NULL COMMENT 'The id for the unit of the tag (ingredient) variable.',
  `food_global_variable_unit_id` smallint(5) unsigned DEFAULT NULL COMMENT 'The unit id for the food or composite variable to be tagged.',
  `conversion_factor` double NOT NULL COMMENT 'Number by which we multiply the food or composite variable''s value to obtain the ingredient variable''s value',
  `client_id` varchar(80) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_tag_tagged` (`food_global_variable_id`,`ingredient_global_variable_id`) USING BTREE,
  KEY `common_tags_tag_variable_id_variables_id_fk` (`ingredient_global_variable_id`),
  KEY `common_tags_client_id_fk` (`client_id`),
  KEY `common_tags_tag_variable_unit_id_fk` (`ingredient_global_variable_unit_id`),
  KEY `common_tags_tagged_variable_unit_id_fk` (`food_global_variable_unit_id`),
  CONSTRAINT `common_tags_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `common_tags_tag_variable_id_variables_id_fk` FOREIGN KEY (`ingredient_global_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `common_tags_tag_variable_unit_id_fk` FOREIGN KEY (`ingredient_global_variable_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `common_tags_tagged_variable_id_variables_id_fk` FOREIGN KEY (`food_global_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `common_tags_tagged_variable_unit_id_fk` FOREIGN KEY (`food_global_variable_unit_id`) REFERENCES `units` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1107724 DEFAULT CHARSET=utf8 COMMENT='Variable tags are used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `global_variables`
--

DROP TABLE IF EXISTS `global_variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `global_variables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Meaningless auto assigned integer for relating to other data. ',
  `name` varchar(125) NOT NULL COMMENT '[Admin-Setting] A consumer friendly name for this item. The intent is to provide a test name that health care consumers will recognize.',
  `number_of_user_variables` int(11) NOT NULL DEFAULT '0' COMMENT 'Number of variables',
  `variable_category_id` tinyint(3) unsigned NOT NULL COMMENT 'Variable category ID',
  `default_unit_id` smallint(5) unsigned NOT NULL COMMENT 'ID of the default unit for the variable',
  `default_value` double DEFAULT NULL COMMENT '[]',
  `cause_only` tinyint(1) DEFAULT NULL COMMENT '[Admin-Setting] A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user',
  `client_id` varchar(80) DEFAULT NULL COMMENT '[Calculated] ID',
  `combination_operation` enum('SUM','MEAN') DEFAULT NULL COMMENT '[Admin-Setting] How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
  `common_alias` varchar(125) DEFAULT NULL COMMENT '[Deprecated]',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '[db-gen]',
  `description` text COMMENT '[]',
  `duration_of_action` int(10) unsigned DEFAULT NULL COMMENT 'How long the effect of a measurement in this variable lasts',
  `filling_value` double DEFAULT '-1' COMMENT 'Value for replacing null measurements',
  `image_url` varchar(2083) DEFAULT NULL COMMENT '[]',
  `informational_url` varchar(2083) DEFAULT NULL COMMENT '[Admin-Setting] A wikipedia article, for instance',
  `ion_icon` varchar(40) DEFAULT NULL COMMENT '[Admin-Setting]',
  `kurtosis` double DEFAULT NULL COMMENT 'Kurtosis',
  `maximum_allowed_value` double DEFAULT NULL COMMENT 'Maximum reasonable value for a single measurement for this variable in the default unit. ',
  `maximum_recorded_value` double DEFAULT NULL COMMENT 'Maximum recorded value of this variable',
  `mean` double DEFAULT NULL COMMENT 'Mean',
  `median` double DEFAULT NULL COMMENT 'Median',
  `minimum_allowed_value` double DEFAULT NULL COMMENT 'Minimum reasonable value for this variable (uses default unit)',
  `minimum_recorded_value` double DEFAULT NULL COMMENT 'Minimum recorded value of this variable',
  `number_of_aggregate_correlations_as_cause` int(10) unsigned DEFAULT NULL COMMENT 'Number of aggregate correlations for which this variable is the cause variable',
  `most_common_original_unit_id` int(11) DEFAULT NULL COMMENT 'Most common Unit ID',
  `most_common_value` double DEFAULT NULL COMMENT 'Most common value',
  `number_of_aggregate_correlations_as_effect` int(10) unsigned DEFAULT NULL COMMENT 'Number of aggregate correlations for which this variable is the effect variable',
  `number_of_unique_values` int(11) DEFAULT NULL COMMENT 'Number of unique values',
  `onset_delay` int(10) unsigned DEFAULT NULL COMMENT 'How long it takes for a measurement in this variable to take effect',
  `outcome` tinyint(1) DEFAULT NULL COMMENT 'Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables.',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the parent variable if this variable has any parent',
  `price` double DEFAULT NULL COMMENT 'Price',
  `product_url` varchar(2083) DEFAULT NULL COMMENT 'Product URL',
  `second_most_common_value` double DEFAULT NULL COMMENT '[]',
  `skewness` double DEFAULT NULL COMMENT '[] Skewness',
  `standard_deviation` double DEFAULT NULL COMMENT '[calculated] Standard Deviation',
  `status` varchar(25) NOT NULL DEFAULT 'WAITING' COMMENT 'status',
  `third_most_common_value` double DEFAULT NULL COMMENT '[]',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '[]',
  `variance` double DEFAULT NULL COMMENT 'Variance',
  `most_common_connector_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `synonyms` varchar(600) DEFAULT NULL COMMENT '[admin-edit,public-write] The primary variable name and any synonyms for it. This field should be used for non-specific variable searches.',
  `wikipedia_url` varchar(2083) DEFAULT NULL COMMENT '[]',
  `brand_name` varchar(125) DEFAULT NULL COMMENT '[Admin-Setting,Imported] Product brand name',
  `valence` enum('positive','negative','neutral') DEFAULT NULL COMMENT '[]',
  `wikipedia_title` varchar(100) DEFAULT NULL COMMENT '[]',
  `number_of_tracking_reminders` int(11) DEFAULT NULL COMMENT '[]',
  `upc_12` varchar(255) DEFAULT NULL COMMENT '[]',
  `upc_14` varchar(255) DEFAULT NULL COMMENT '[]',
  `number_common_tagged_by` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `number_of_common_tags` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '[]',
  `most_common_source_name` varchar(255) DEFAULT NULL COMMENT '[]',
  `data_sources_count` text COMMENT 'Array of connector or client measurement data source names as key with number of users as value',
  `optimal_value_message` varchar(500) DEFAULT NULL COMMENT '[]',
  `best_cause_variable_id` int(10) unsigned DEFAULT NULL COMMENT '[Calculated] The strongest predictor variable for all users.',
  `best_effect_variable_id` int(10) unsigned DEFAULT NULL COMMENT '[Calculated] The strongest outcome variable for all users.',
  `common_maximum_allowed_daily_value` double DEFAULT NULL COMMENT '[validation]',
  `common_minimum_allowed_daily_value` double DEFAULT NULL COMMENT '[validation]',
  `common_minimum_allowed_non_zero_value` double DEFAULT NULL COMMENT '[validation]',
  `minimum_allowed_seconds_between_measurements` int(11) DEFAULT NULL COMMENT '[]',
  `average_seconds_between_measurements` int(11) DEFAULT NULL COMMENT '[Calculated] Average seconds between measurements for the average user.  Helps identify duplicate or erronous data and spamming of the database.',
  `median_seconds_between_measurements` int(11) DEFAULT NULL COMMENT '[]',
  `number_of_raw_measurements_with_tags_joins_children` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `additional_meta_data` text COMMENT '[] JSON-encoded additional data that does not fit in any other columns. JSON object',
  `manual_tracking` tinyint(1) DEFAULT NULL COMMENT '[]',
  `analysis_settings_modified_at` timestamp NULL DEFAULT NULL COMMENT '[Internal] When last analysis settings we''re changed.',
  `newest_data_at` timestamp NULL DEFAULT NULL COMMENT '[]',
  `analysis_requested_at` timestamp NULL DEFAULT NULL COMMENT '[Internal] When an analysis was manually triggered.',
  `reason_for_analysis` varchar(255) DEFAULT NULL COMMENT '[]',
  `analysis_started_at` timestamp NULL DEFAULT NULL COMMENT '[Internal] When the analysis started.',
  `analysis_ended_at` timestamp NULL DEFAULT NULL COMMENT '[Internal] When last analysis was completed.',
  `user_error_message` text COMMENT '[]',
  `internal_error_message` text COMMENT '[]',
  `latest_tagged_measurement_start_at` timestamp NULL DEFAULT NULL COMMENT '[]',
  `earliest_tagged_measurement_start_at` timestamp NULL DEFAULT NULL COMMENT '[]',
  `latest_non_tagged_measurement_start_at` timestamp NULL DEFAULT NULL COMMENT '[]',
  `earliest_non_tagged_measurement_start_at` timestamp NULL DEFAULT NULL COMMENT '[]',
  `wp_post_id` bigint(20) unsigned DEFAULT NULL COMMENT '[]',
  `number_of_soft_deleted_measurements` int(11) DEFAULT NULL COMMENT 'Formula: update variables v \n                inner join (\n                    select measurements.variable_id, count(measurements.id) as number_of_soft_deleted_measurements \n                    from measurements\n                    where measurements.deleted_at is not null\n                    group by measurements.variable_id\n                    ) m on v.id = m.variable_id\n                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements\n            ',
  `charts` json DEFAULT NULL COMMENT '[Calculated] Highcharts configuration',
  `creator_user_id` bigint(20) unsigned NOT NULL COMMENT '[api-gen]',
  `best_aggregate_correlation_id` int(11) DEFAULT NULL COMMENT '[Calculated] The strongest predictor or outcome for all users.',
  `filling_type` enum('zero','none','interpolation','value') DEFAULT NULL COMMENT '[]',
  `number_of_outcome_population_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Global Population Studies for this Cause Variable.\n                [Formula: \n                    update variables\n                        left join (\n                            select count(id) as total, cause_variable_id\n                            from aggregate_correlations\n                            group by cause_variable_id\n                        )\n                        as grouped on variables.id = grouped.cause_variable_id\n                    set variables.number_of_outcome_population_studies = count(grouped.total)\n                ]\n                ',
  `number_of_predictor_population_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Global Population Studies for this Effect Variable.\n                [Formula: \n                    update variables\n                        left join (\n                            select count(id) as total, effect_variable_id\n                            from aggregate_correlations\n                            group by effect_variable_id\n                        )\n                        as grouped on variables.id = grouped.effect_variable_id\n                    set variables.number_of_predictor_population_studies = count(grouped.total)\n                ]\n                ',
  `number_of_applications_where_outcome_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Applications for this Outcome Variable.\r\n                [Formula: \r\n                    update variables\r\n                        left join (\r\n                            select count(id) as total, outcome_variable_id\r\n                            from applications\r\n                            group by outcome_variable_id\r\n                        )\r\n                        as grouped on variables.id = grouped.outcome_variable_id\r\n                    set variables.number_of_applications_where_outcome_variable = count(grouped.total)\r\n                ]',
  `number_of_applications_where_predictor_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Applications for this Predictor Variable.\n                [Formula: \n                    update variables\n                        left join (\n                            select count(id) as total, predictor_variable_id\n                            from applications\n                            group by predictor_variable_id\n                        )\n                        as grouped on variables.id = grouped.predictor_variable_id\n                    set variables.number_of_applications_where_predictor_variable = count(grouped.total)\n                ]\n                ',
  `number_of_common_tags_where_tag_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Common Tags for this Tag Variable.\n                [Formula: \n                    update variables\n                        left join (\n                            select count(id) as total, tag_variable_id\n                            from common_tags\n                            group by tag_variable_id\n                        )\n                        as grouped on variables.id = grouped.tag_variable_id\n                    set variables.number_of_common_tags_where_tag_variable = count(grouped.total)\n                ]\n                ',
  `number_of_common_tags_where_tagged_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Common Tags for this Tagged Variable.\n                [Formula: \n                    update variables\n                        left join (\n                            select count(id) as total, tagged_variable_id\n                            from common_tags\n                            group by tagged_variable_id\n                        )\n                        as grouped on variables.id = grouped.tagged_variable_id\n                    set variables.number_of_common_tags_where_tagged_variable = count(grouped.total)\n                ]\n                ',
  `number_of_outcome_case_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Individual Case Studies for this Cause Variable.\n                [Formula: \n                    update variables\n                        left join (\n                            select count(id) as total, cause_variable_id\n                            from correlations\n                            group by cause_variable_id\n                        )\n                        as grouped on variables.id = grouped.cause_variable_id\n                    set variables.number_of_outcome_case_studies = count(grouped.total)\n                ]\n                ',
  `number_of_predictor_case_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Individual Case Studies for this Effect Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, effect_variable_id\n                            from correlations\n                            group by effect_variable_id\n                        )\n                        as grouped on variables.id = grouped.effect_variable_id\n                    set variables.number_of_predictor_case_studies = count(grouped.total)]',
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, variable_id\n                            from measurements\n                            group by variable_id\n                        )\n                        as grouped on variables.id = grouped.variable_id\n                    set variables.number_of_measurements = count(grouped.total)]',
  `number_of_studies_where_cause_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Studies for this Cause Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, cause_variable_id\n                            from studies\n                            group by cause_variable_id\n                        )\n                        as grouped on variables.id = grouped.cause_variable_id\n                    set variables.number_of_studies_where_cause_variable = count(grouped.total)]',
  `number_of_studies_where_effect_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Studies for this Effect Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, effect_variable_id\n                            from studies\n                            group by effect_variable_id\n                        )\n                        as grouped on variables.id = grouped.effect_variable_id\n                    set variables.number_of_studies_where_effect_variable = count(grouped.total)]',
  `number_of_tracking_reminder_notifications` int(10) unsigned DEFAULT NULL COMMENT 'Number of Tracking Reminder Notifications for this Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, variable_id\n                            from tracking_reminder_notifications\n                            group by variable_id\n                        )\n                        as grouped on variables.id = grouped.variable_id\n                    set variables.number_of_tracking_reminder_notifications = count(grouped.total)]',
  `number_of_user_tags_where_tag_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of User Tags for this Tag Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, tag_variable_id\n                            from user_tags\n                            group by tag_variable_id\n                        )\n                        as grouped on variables.id = grouped.tag_variable_id\n                    set variables.number_of_user_tags_where_tag_variable = count(grouped.total)]',
  `number_of_user_tags_where_tagged_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of User Tags for this Tagged Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, tagged_variable_id\n                            from user_tags\n                            group by tagged_variable_id\n                        )\n                        as grouped on variables.id = grouped.tagged_variable_id\n                    set variables.number_of_user_tags_where_tagged_variable = count(grouped.total)]',
  `number_of_variables_where_best_cause_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Variables for this Best Cause Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, best_cause_variable_id\n                            from variables\n                            group by best_cause_variable_id\n                        )\n                        as grouped on variables.id = grouped.best_cause_variable_id\n                    set variables.number_of_variables_where_best_cause_variable = count(grouped.total)]',
  `number_of_variables_where_best_effect_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Variables for this Best Effect Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, best_effect_variable_id\n                            from variables\n                            group by best_effect_variable_id\n                        )\n                        as grouped on variables.id = grouped.best_effect_variable_id\n                    set variables.number_of_variables_where_best_effect_variable = count(grouped.total)]',
  `number_of_votes_where_cause_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Votes for this Cause Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, cause_variable_id\n                            from votes\n                            group by cause_variable_id\n                        )\n                        as grouped on variables.id = grouped.cause_variable_id\n                    set variables.number_of_votes_where_cause_variable = count(grouped.total)]',
  `number_of_votes_where_effect_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Votes for this Effect Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(id) as total, effect_variable_id\n                            from votes\n                            group by effect_variable_id\n                        )\n                        as grouped on variables.id = grouped.effect_variable_id\n                    set variables.number_of_votes_where_effect_variable = count(grouped.total)]',
  `number_of_users_where_primary_outcome_variable` int(10) unsigned DEFAULT NULL COMMENT 'Number of Users for this Primary Outcome Variable.\n                    [Formula: update variables\n                        left join (\n                            select count(ID) as total, primary_outcome_variable_id\n                            from wp_users\n                            group by primary_outcome_variable_id\n                        )\n                        as grouped on variables.id = grouped.primary_outcome_variable_id\n                    set variables.number_of_users_where_primary_outcome_variable = count(grouped.total)]',
  `deletion_reason` varchar(280) DEFAULT NULL COMMENT 'The reason the variable was deleted.',
  `maximum_allowed_daily_value` double DEFAULT NULL COMMENT 'The maximum allowed value in the default unit for measurements aggregated over a single day. ',
  `record_size_in_kb` int(11) DEFAULT NULL COMMENT '[]',
  `number_of_common_joined_variables` int(11) DEFAULT NULL COMMENT 'Joined variables are duplicate variables measuring the same thing. ',
  `number_of_common_ingredients` int(11) DEFAULT NULL COMMENT 'Measurements for this variable can be used to synthetically generate ingredient measurements. ',
  `number_of_common_foods` int(11) DEFAULT NULL COMMENT 'Measurements for this ingredient variable can be synthetically generate by food measurements. ',
  `number_of_common_children` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
  `number_of_common_parents` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
  `number_of_user_joined_variables` int(11) DEFAULT NULL COMMENT 'Joined variables are duplicate variables measuring the same thing. This only includes ones created by users. ',
  `number_of_user_ingredients` int(11) DEFAULT NULL COMMENT 'Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by users. ',
  `number_of_user_foods` int(11) DEFAULT NULL COMMENT 'Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by users. ',
  `number_of_user_children` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ',
  `number_of_user_parents` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ',
  `is_public` tinyint(1) DEFAULT NULL COMMENT '[]',
  `sort_order` int(11) NOT NULL COMMENT '[]',
  `is_goal` tinyint(1) DEFAULT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
  `controllable` tinyint(1) DEFAULT NULL COMMENT 'You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ',
  `boring` tinyint(1) DEFAULT NULL COMMENT '[Admin-Setting] The variable is boring if the average person would not be interested in its causes or effects.',
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is an identifier in human-readable keywords, used as id for the exchange format and id in document database.',
  `canonical_variable_id` int(10) unsigned DEFAULT NULL COMMENT '[Admin-Setting] If a variable duplicates another but with a different name, set the canonical variable id to match the variable with the more appropriate name.  Then only the canonical variable will be displayed and all data for the duplicate variable will be included when fetching data for the canonical variable.',
  `predictor` tinyint(1) DEFAULT NULL COMMENT 'predictor is true if the variable is a factor that could influence an outcome of interest',
  `source_url` varchar(2083) DEFAULT NULL COMMENT '[admin,public-if-null] URL for the website related to the database containing the info that was used to create this variable such as https://world.openfoodfacts.org or https://dsld.od.nih.gov/dsld',
  `loinc_core_id` int(11) DEFAULT NULL COMMENT '[]',
  `abbreviated_name` varchar(100) DEFAULT NULL COMMENT '[Admin-Setting] Canonical shorter version of the name or scientific abbrevation',
  `version_first_released` varchar(255) DEFAULT NULL COMMENT 'The CureDAO version number in which the record was first released. For oldest records where the version released number is known, this field will be null.',
  `version_last_changed` varchar(255) DEFAULT NULL COMMENT 'The CureDAO version number in which the record has last changed. For records that have never been updated after their release, this field will contain the same value as the loinc.VersionFirstReleased field.',
  `loinc_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `rxnorm_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `snomed_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `meddra_all_indications_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `meddra_all_side_effects_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `icd10_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `uniprot_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `hmdb_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `gene_ontology_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  `aact_id` int(10) unsigned DEFAULT NULL COMMENT '[]',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`) USING BTREE,
  UNIQUE KEY `variables_slug_uindex` (`slug`),
  KEY `fk_variableDefaultUnit` (`default_unit_id`) USING BTREE,
  KEY `IDX_cat_unit_public_name` (`variable_category_id`,`default_unit_id`,`name`,`number_of_user_variables`,`id`) USING BTREE,
  KEY `variables_client_id_fk` (`client_id`),
  KEY `variables_best_cause_variable_id_fk` (`best_cause_variable_id`),
  KEY `variables_best_effect_variable_id_fk` (`best_effect_variable_id`),
  KEY `variables_wp_posts_ID_fk` (`wp_post_id`),
  KEY `variables_analysis_ended_at_index` (`analysis_ended_at`),
  KEY `variables_aggregate_correlations_id_fk` (`best_aggregate_correlation_id`),
  KEY `variables_public_name_number_of_user_variables_index` (`name`,`number_of_user_variables`),
  KEY `public_deleted_at_synonyms_number_of_user_variables_index` (`deleted_at`,`synonyms`,`number_of_user_variables`),
  KEY `qm_variables_loinc_core_id_fk` (`loinc_core_id`),
  CONSTRAINT `qm_variables_loinc_core_id_fk` FOREIGN KEY (`loinc_core_id`) REFERENCES `loinc_core` (`id`),
  CONSTRAINT `variables_aggregate_correlations_id_fk` FOREIGN KEY (`best_aggregate_correlation_id`) REFERENCES `global_study_results` (`id`) ON DELETE SET NULL,
  CONSTRAINT `variables_best_cause_variable_id_fk` FOREIGN KEY (`best_cause_variable_id`) REFERENCES `global_variables` (`id`) ON DELETE SET NULL,
  CONSTRAINT `variables_best_effect_variable_id_fk` FOREIGN KEY (`best_effect_variable_id`) REFERENCES `global_variables` (`id`) ON DELETE SET NULL,
  CONSTRAINT `variables_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `variables_default_unit_id_fk` FOREIGN KEY (`default_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `variables_variable_category_id_fk` FOREIGN KEY (`variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `variables_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6067536 DEFAULT CHARSET=utf8 COMMENT='Variable overviews with statistics, analysis settings, and data visualizations and likely outcomes or predictors based on the anonymously aggregated donated data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intuitive_causes`
--

DROP TABLE IF EXISTS `intuitive_causes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intuitive_causes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `number_of_conditions` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `causeName` (`name`) USING BTREE,
  UNIQUE KEY `ct_causes_variable_id_uindex` (`variable_id`),
  CONSTRAINT `ct_causes_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7637 DEFAULT CHARSET=utf8 COMMENT='User self-reported causes of illness';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intuitive_condition_symptom`
--

DROP TABLE IF EXISTS `intuitive_condition_symptom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intuitive_condition_symptom` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `condition_variable_id` int(10) unsigned NOT NULL,
  `condition_id` int(11) NOT NULL,
  `symptom_variable_id` int(10) unsigned NOT NULL,
  `symptom_id` int(11) NOT NULL,
  `votes` int(11) NOT NULL,
  `extreme` int(11) DEFAULT NULL,
  `severe` int(11) DEFAULT NULL,
  `moderate` int(11) DEFAULT NULL,
  `mild` int(11) DEFAULT NULL,
  `minimal` int(11) DEFAULT NULL,
  `no_symptoms` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ct_condition_symptom_condition_uindex` (`condition_variable_id`,`symptom_variable_id`),
  UNIQUE KEY `ct_condition_symptom_variable_id_uindex` (`symptom_variable_id`,`condition_variable_id`),
  KEY `ct_condition_symptom_conditions_fk` (`condition_id`),
  KEY `ct_condition_symptom_symptoms_fk` (`symptom_id`),
  CONSTRAINT `ct_condition_symptom_conditions_fk` FOREIGN KEY (`condition_id`) REFERENCES `intuitive_conditions` (`id`),
  CONSTRAINT `ct_condition_symptom_symptoms_fk` FOREIGN KEY (`symptom_id`) REFERENCES `intuitive_symptoms` (`id`),
  CONSTRAINT `ct_condition_symptom_variables_condition_fk` FOREIGN KEY (`condition_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `ct_condition_symptom_variables_symptom_fk` FOREIGN KEY (`symptom_variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4187 DEFAULT CHARSET=utf8 COMMENT='User self-reported conditions and related symptoms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intuitive_condition_treatment`
--

DROP TABLE IF EXISTS `intuitive_condition_treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intuitive_condition_treatment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `condition_id` int(11) NOT NULL,
  `treatment_id` int(11) NOT NULL,
  `condition_variable_id` int(10) unsigned DEFAULT NULL,
  `treatment_variable_id` int(10) unsigned NOT NULL,
  `major_improvement` int(11) NOT NULL DEFAULT '0',
  `moderate_improvement` int(11) NOT NULL DEFAULT '0',
  `no_effect` int(11) NOT NULL DEFAULT '0',
  `worse` int(11) NOT NULL DEFAULT '0',
  `much_worse` int(11) NOT NULL DEFAULT '0',
  `popularity` int(11) NOT NULL DEFAULT '0',
  `average_effect` int(11) NOT NULL DEFAULT '0',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `treatment_id_condition_id_uindex` (`treatment_id`,`condition_id`),
  UNIQUE KEY `treatment_variable_id_condition_variable_id_uindex` (`treatment_variable_id`,`condition_variable_id`),
  KEY `ct_condition_treatment_conditions_id_fk` (`condition_id`),
  KEY `ct_condition_treatment_variables_id_fk_2` (`condition_variable_id`),
  CONSTRAINT `ct_condition_treatment_conditions_id_fk` FOREIGN KEY (`condition_id`) REFERENCES `intuitive_conditions` (`id`),
  CONSTRAINT `ct_condition_treatment_ct_treatments_fk` FOREIGN KEY (`treatment_id`) REFERENCES `treatments` (`id`),
  CONSTRAINT `ct_condition_treatment_variables_id_fk` FOREIGN KEY (`treatment_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `ct_condition_treatment_variables_id_fk_2` FOREIGN KEY (`condition_variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5879 DEFAULT CHARSET=utf8 COMMENT='Conditions and related treatments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intuitive_conditions`
--

DROP TABLE IF EXISTS `intuitive_conditions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intuitive_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `number_of_treatments` int(10) unsigned NOT NULL,
  `number_of_symptoms` int(10) unsigned DEFAULT NULL,
  `number_of_causes` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `conName` (`name`) USING BTREE,
  UNIQUE KEY `ct_conditions_variable_id_uindex` (`variable_id`),
  CONSTRAINT `ct_conditions_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8 COMMENT='User self-reported condition names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intuitive_relationships`
--

DROP TABLE IF EXISTS `intuitive_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intuitive_relationships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `correlation_coefficient` float(10,4) DEFAULT NULL,
  `cause_variable_id` int(10) unsigned NOT NULL,
  `effect_variable_id` int(10) unsigned NOT NULL,
  `onset_delay` int(11) DEFAULT NULL,
  `duration_of_action` int(11) DEFAULT NULL,
  `number_of_pairs` int(11) DEFAULT NULL,
  `value_predicting_high_outcome` double DEFAULT NULL,
  `value_predicting_low_outcome` double DEFAULT NULL,
  `optimal_pearson_product` double DEFAULT NULL,
  `vote` float(3,1) DEFAULT '0.5',
  `statistical_significance` float(10,4) DEFAULT NULL,
  `cause_unit_id` int(11) DEFAULT NULL,
  `cause_changes` int(11) DEFAULT NULL,
  `effect_changes` int(11) DEFAULT NULL,
  `qm_score` double DEFAULT NULL,
  `error` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user_id`,`cause_variable_id`,`effect_variable_id`) USING BTREE,
  KEY `cause` (`cause_variable_id`) USING BTREE,
  KEY `effect` (`effect_variable_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=29081842 DEFAULT CHARSET=utf8 COMMENT='Stores Calculated Correlation Coefficients';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intuitive_side_effects`
--

DROP TABLE IF EXISTS `intuitive_side_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intuitive_side_effects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `number_of_treatments` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `seName` (`name`) USING BTREE,
  UNIQUE KEY `ct_side_effects_variable_id_uindex` (`variable_id`),
  CONSTRAINT `ct_side_effects_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28421 DEFAULT CHARSET=utf8 COMMENT='User self-reported side effect names';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intuitive_symptoms`
--

DROP TABLE IF EXISTS `intuitive_symptoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intuitive_symptoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `number_of_conditions` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `symName` (`name`) USING BTREE,
  UNIQUE KEY `ct_symptoms_variable_id_uindex` (`variable_id`),
  CONSTRAINT `ct_symptoms_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6419 DEFAULT CHARSET=utf8 COMMENT='User self-reported symptoms';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `inutitive_condition_cause`
--

DROP TABLE IF EXISTS `inutitive_condition_cause`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inutitive_condition_cause` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `condition_id` int(11) NOT NULL,
  `cause_id` int(11) NOT NULL,
  `condition_variable_id` int(10) unsigned NOT NULL,
  `cause_variable_id` int(10) unsigned NOT NULL,
  `votes_percent` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ct_condition_cause_cause_id_condition_id_uindex` (`cause_id`,`condition_id`),
  UNIQUE KEY `ct_condition_cause_cause_uindex` (`cause_variable_id`,`condition_variable_id`),
  KEY `ct_condition_cause_variables_id_condition_fk` (`condition_variable_id`),
  KEY `ct_condition_cause_ct_conditions_id_condition_fk` (`condition_id`),
  CONSTRAINT `ct_condition_cause_ct_causes_cause_fk` FOREIGN KEY (`cause_id`) REFERENCES `intuitive_causes` (`id`),
  CONSTRAINT `ct_condition_cause_ct_conditions_id_condition_fk` FOREIGN KEY (`condition_id`) REFERENCES `intuitive_conditions` (`id`),
  CONSTRAINT `ct_condition_cause_variables_id_condition_fk` FOREIGN KEY (`condition_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `ct_condition_cause_variables_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3654 DEFAULT CHARSET=utf8 COMMENT='User self-reported conditions and causes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loinc_core`
--

DROP TABLE IF EXISTS `loinc_core`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loinc_core` (
  `LOINC_NUM` text,
  `COMPONENT` text,
  `PROPERTY` text,
  `TIME_ASPCT` text,
  `SYSTEM` text,
  `SCALE_TYP` text,
  `METHOD_TYP` text,
  `CLASS` text,
  `CLASSTYPE` int(11) DEFAULT NULL,
  `LONG_COMMON_NAME` text,
  `SHORTNAME` text,
  `EXTERNAL_COPYRIGHT_NOTICE` text,
  `STATUS` text,
  `VersionFirstReleased` text,
  `VersionLastChanged` double DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=96581 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `longevity_supplements`
--

DROP TABLE IF EXISTS `longevity_supplements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `longevity_supplements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` text,
  `rxnorm_code` text,
  `name_short` text,
  `name_long` text,
  `application_route` text,
  `description` text,
  `references` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurement_exports`
--

DROP TABLE IF EXISTS `measurement_exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurement_exports` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `status` varchar(32) NOT NULL COMMENT 'Status of Measurement Export',
  `type` enum('user','app') NOT NULL DEFAULT 'user' COMMENT 'Whether user''s measurement export request or app users',
  `output_type` enum('csv','xls','pdf') NOT NULL DEFAULT 'csv' COMMENT 'Output type of export file',
  `error_message` varchar(255) DEFAULT NULL COMMENT 'Error message',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `measurement_exports_user_id_fk` (`user_id`),
  KEY `measurement_exports_client_id_fk` (`client_id`),
  CONSTRAINT `measurement_exports_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `measurement_exports_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3101 DEFAULT CHARSET=utf8 COMMENT='A request from a user to export their data as a spreadsheet.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurement_imports`
--

DROP TABLE IF EXISTS `measurement_imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurement_imports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `file` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(25) NOT NULL DEFAULT 'WAITING',
  `error_message` text,
  `source_name` varchar(80) DEFAULT NULL COMMENT 'Name of the application or device',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `import_started_at` timestamp NULL DEFAULT NULL,
  `import_ended_at` timestamp NULL DEFAULT NULL,
  `reason_for_import` varchar(255) DEFAULT NULL,
  `user_error_message` varchar(255) DEFAULT NULL,
  `internal_error_message` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `measurement_imports_user_id_fk` (`user_id`),
  KEY `measurement_imports_client_id_fk` (`client_id`),
  CONSTRAINT `measurement_imports_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `measurement_imports_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COMMENT='Spreadsheet import records.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurements`
--

DROP TABLE IF EXISTS `measurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurements` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'Unique ID representing the owner of the measurement',
  `client_id` varchar(80) NOT NULL COMMENT 'ID of the client application that sumbitted the measurement on behalf of the user',
  `connector_id` int(10) unsigned DEFAULT NULL COMMENT 'The id for the connector data source from which the measurement was obtained',
  `variable_id` int(10) unsigned NOT NULL COMMENT 'ID of the variable for which we are creating the measurement records',
  `start_time` int(10) unsigned NOT NULL COMMENT 'Start time for the measurement event in ISO 8601',
  `value` double NOT NULL COMMENT 'The value of the measurement after conversion to the default unit for that variable',
  `unit_id` smallint(5) unsigned NOT NULL COMMENT 'The default unit for the variable',
  `original_value` double NOT NULL COMMENT 'Value of measurement as originally posted (before conversion to default unit)',
  `original_unit_id` smallint(5) unsigned NOT NULL COMMENT 'Unit id of measurement as originally submitted',
  `duration` int(10) DEFAULT NULL COMMENT 'Duration of the event being measurement in seconds',
  `note` text COMMENT 'An optional note the user may include with their measurement',
  `latitude` double DEFAULT NULL COMMENT 'Latitude at which the measurement was taken',
  `longitude` double DEFAULT NULL COMMENT 'Longitude at which the measurement was taken',
  `location` varchar(255) DEFAULT NULL COMMENT 'location',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `error` text COMMENT 'An error message if there is a problem with the measurement',
  `variable_category_id` tinyint(3) unsigned NOT NULL COMMENT 'Variable category ID',
  `deleted_at` datetime DEFAULT NULL,
  `source_name` varchar(80) DEFAULT NULL COMMENT 'Name of the application or device',
  `user_variable_id` int(10) unsigned NOT NULL,
  `start_at` timestamp NOT NULL,
  `connection_id` int(11) unsigned DEFAULT NULL,
  `connector_import_id` int(11) unsigned DEFAULT NULL,
  `deletion_reason` varchar(280) DEFAULT NULL COMMENT 'The reason the variable was deleted.',
  `original_start_at` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `measurements_pk` (`user_id`,`variable_id`,`start_time`),
  KEY `measurements_user_variables_variable_id_user_id_fk` (`variable_id`,`user_id`),
  KEY `measurements_connectors_id_fk` (`connector_id`),
  KEY `measurements_user_variables_user_variable_id_fk` (`user_variable_id`),
  KEY `measurements_client_id_fk` (`client_id`),
  KEY `measurements_connections_id_fk` (`connection_id`),
  KEY `measurements_connector_imports_id_fk` (`connector_import_id`),
  KEY `measurements_user_id_variable_category_id_start_time_index` (`user_id`,`variable_category_id`,`start_time`),
  KEY `measurements_variable_category_id_fk` (`variable_category_id`),
  KEY `measurements_unit_id_fk` (`unit_id`),
  KEY `measurements_original_unit_id_fk` (`original_unit_id`),
  KEY `measurements_variable_id_start_time_index` (`variable_id`,`start_time`),
  KEY `measurements_variable_id_value_start_time_index` (`variable_id`,`value`,`start_time`),
  KEY `measurements_start_time_index` (`start_time`),
  CONSTRAINT `measurements_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `measurements_connections_id_fk` FOREIGN KEY (`connection_id`) REFERENCES `api_connections` (`id`),
  CONSTRAINT `measurements_connector_imports_id_fk` FOREIGN KEY (`connector_import_id`) REFERENCES `api_connector_imports` (`id`),
  CONSTRAINT `measurements_connectors_id_fk` FOREIGN KEY (`connector_id`) REFERENCES `api_connectors` (`id`),
  CONSTRAINT `measurements_original_unit_id_fk` FOREIGN KEY (`original_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `measurements_unit_id_fk` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `measurements_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `measurements_user_variables_user_variable_id_fk` FOREIGN KEY (`user_variable_id`) REFERENCES `user_variables` (`id`),
  CONSTRAINT `measurements_variable_category_id_fk` FOREIGN KEY (`variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `measurements_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1093091217 DEFAULT CHARSET=utf8 COMMENT='Measurements are any value that can be recorded like daily steps, a mood rating, or apples eaten.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meddra_all_indications`
--

DROP TABLE IF EXISTS `meddra_all_indications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meddra_all_indications` (
  `STITCH_compound_id_flat` varchar(55) DEFAULT NULL,
  `UMLS_concept_id_as_it_was_found_on_the_label` varchar(55) DEFAULT NULL,
  `method_of_detection` varchar(55) DEFAULT NULL,
  `concept_name` varchar(55) DEFAULT NULL,
  `MedDRA_concept_type` varchar(55) DEFAULT NULL,
  `UMLS_concept_id_for_MedDRA_term` varchar(55) DEFAULT NULL,
  `MedDRA_concept_name` varchar(55) DEFAULT NULL,
  `compound_name` varchar(255) DEFAULT NULL,
  `compound_variable_id` int(10) DEFAULT NULL,
  `condition_variable_id` int(10) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `id` (`STITCH_compound_id_flat`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=30836 DEFAULT CHARSET=utf8 COMMENT='Conditions treated by specific medications from the Medical Dictionary for Regulatory Activities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meddra_all_side_effects`
--

DROP TABLE IF EXISTS `meddra_all_side_effects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meddra_all_side_effects` (
  `STITCH_compound_id_flat` varchar(255) DEFAULT NULL,
  `STITCH_compound_id_stereo` varchar(255) DEFAULT NULL,
  `UMLS_concept_id_as_it_was_found_on_the_label` varchar(255) DEFAULT NULL,
  `MedDRA_concept_type` varchar(255) DEFAULT NULL,
  `UMLS_concept_id_for_MedDRA_term` varchar(255) DEFAULT NULL,
  `side_effect_name` varchar(255) DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=309850 DEFAULT CHARSET=latin1 COMMENT='Side effects from the Medical Dictionary for Regulatory Activities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `meddra_side_effect_frequencies`
--

DROP TABLE IF EXISTS `meddra_side_effect_frequencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meddra_side_effect_frequencies` (
  `STITCH_compound_id_flat` varchar(50) DEFAULT NULL,
  `STITCH_compound_id_stereo` varchar(50) DEFAULT NULL,
  `UMLS_concept_id_as_it_was_found_on_the_label` varchar(50) DEFAULT NULL,
  `placebo` varchar(50) DEFAULT NULL,
  `description_of_the_frequency` double DEFAULT NULL,
  `a_lower_bound_on_the_frequency` double DEFAULT NULL,
  `an_upper_bound_on_the_frequency` double DEFAULT NULL,
  `MedDRA_concept_type` varchar(50) DEFAULT NULL,
  `UMLS_concept_id_for_MedDRA_term` varchar(50) DEFAULT NULL,
  `side_effect_name` varchar(50) DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=291633 DEFAULT CHARSET=latin1 COMMENT='Frequency of side effects from the Medical Dictionary for Regulatory Activities';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `collection_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `file_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mime_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `disk` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `size` bigint(20) unsigned NOT NULL,
  `manipulations` json NOT NULL,
  `custom_properties` json NOT NULL,
  `responsive_images` json NOT NULL,
  `order_column` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `media_model_type_model_id_index` (`model_type`,`model_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Files that can be attached to data models.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menu_items`
--

DROP TABLE IF EXISTS `menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menu_items` (
  `id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `title` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `target` varchar(191) DEFAULT NULL,
  `icon_class` varchar(191) DEFAULT NULL,
  `color` varchar(191) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(191) DEFAULT NULL,
  `parameters` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menus` (
  `id` int(11) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) DEFAULT NULL,
  `migration` varchar(191) DEFAULT NULL,
  `batch` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` char(36) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `notifiable_id` int(11) DEFAULT NULL,
  `notifiable_type` varchar(191) DEFAULT NULL,
  `data` text,
  `read_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `nutrients`
--

DROP TABLE IF EXISTS `nutrients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nutrients` (
  `slug` text,
  `category` text,
  `name_long` text,
  `unit` text,
  `default_value` text,
  `description` text,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oa_clients`
--

DROP TABLE IF EXISTS `oa_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oa_clients` (
  `client_id` varchar(80) NOT NULL,
  `client_secret` varchar(80) NOT NULL,
  `redirect_uri` varchar(2000) DEFAULT NULL,
  `grant_types` varchar(80) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `icon_url` varchar(2083) DEFAULT NULL,
  `app_identifier` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `earliest_measurement_start_at` timestamp NULL DEFAULT NULL,
  `latest_measurement_start_at` timestamp NULL DEFAULT NULL,
  `number_of_aggregate_correlations` int(10) unsigned DEFAULT NULL COMMENT 'Number of Global Population Studies for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from aggregate_correlations\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_aggregate_correlations = count(grouped.total)\n                ]\n                ',
  `number_of_applications` int(10) unsigned DEFAULT NULL COMMENT 'Number of Applications for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from applications\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_applications = count(grouped.total)\n                ]\n                ',
  `number_of_oauth_access_tokens` int(10) unsigned DEFAULT NULL COMMENT 'Number of OAuth Access Tokens for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(access_token) as total, client_id\n                            from oa_access_tokens\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_oauth_access_tokens = count(grouped.total)\n                ]\n                ',
  `number_of_oauth_authorization_codes` int(10) unsigned DEFAULT NULL COMMENT 'Number of OAuth Authorization Codes for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(authorization_code) as total, client_id\n                            from oa_authorization_codes\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_oauth_authorization_codes = count(grouped.total)\n                ]\n                ',
  `number_of_oauth_refresh_tokens` int(10) unsigned DEFAULT NULL COMMENT 'Number of OAuth Refresh Tokens for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(refresh_token) as total, client_id\n                            from oa_refresh_tokens\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_oauth_refresh_tokens = count(grouped.total)\n                ]\n                ',
  `number_of_button_clicks` int(10) unsigned DEFAULT NULL COMMENT 'Number of Button Clicks for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from button_clicks\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_button_clicks = count(grouped.total)\n                ]\n                ',
  `number_of_collaborators` int(10) unsigned DEFAULT NULL COMMENT 'Number of Collaborators for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from collaborators\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_collaborators = count(grouped.total)\n                ]\n                ',
  `number_of_common_tags` int(10) unsigned DEFAULT NULL COMMENT 'Number of Common Tags for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from common_tags\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_common_tags = count(grouped.total)\n                ]\n                ',
  `number_of_connections` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connections for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from connections\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_connections = count(grouped.total)\n                ]\n                ',
  `number_of_connector_imports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Imports for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from connector_imports\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_connector_imports = count(grouped.total)\n                ]\n                ',
  `number_of_connectors` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connectors for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from connectors\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_connectors = count(grouped.total)\n                ]\n                ',
  `number_of_correlations` int(10) unsigned DEFAULT NULL COMMENT 'Number of Individual Case Studies for this Client.\n                [Formula: \n                    update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from correlations\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_correlations = count(grouped.total)\n                ]\n                ',
  `number_of_measurement_exports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurement Exports for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from measurement_exports\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_measurement_exports = count(grouped.total)]',
  `number_of_measurement_imports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurement Imports for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from measurement_imports\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_measurement_imports = count(grouped.total)]',
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from measurements\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_measurements = count(grouped.total)]',
  `number_of_sent_emails` int(10) unsigned DEFAULT NULL COMMENT 'Number of Sent Emails for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from sent_emails\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_sent_emails = count(grouped.total)]',
  `number_of_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Studies for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from studies\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_studies = count(grouped.total)]',
  `number_of_tracking_reminder_notifications` int(10) unsigned DEFAULT NULL COMMENT 'Number of Tracking Reminder Notifications for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from tracking_reminder_notifications\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_tracking_reminder_notifications = count(grouped.total)]',
  `number_of_tracking_reminders` int(10) unsigned DEFAULT NULL COMMENT 'Number of Tracking Reminders for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from tracking_reminders\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_tracking_reminders = count(grouped.total)]',
  `number_of_user_tags` int(10) unsigned DEFAULT NULL COMMENT 'Number of User Tags for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from user_tags\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_user_tags = count(grouped.total)]',
  `number_of_user_variables` int(10) unsigned DEFAULT NULL COMMENT 'Number of User Variables for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from user_variables\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_user_variables = count(grouped.total)]',
  `number_of_variables` int(10) unsigned DEFAULT NULL COMMENT 'Number of Variables for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from variables\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_variables = count(grouped.total)]',
  `number_of_votes` int(10) unsigned DEFAULT NULL COMMENT 'Number of Votes for this Client.\n                    [Formula: update oa_clients\n                        left join (\n                            select count(id) as total, client_id\n                            from votes\n                            group by client_id\n                        )\n                        as grouped on oa_clients.client_id = grouped.client_id\n                    set oa_clients.number_of_votes = count(grouped.total)]',
  PRIMARY KEY (`client_id`),
  KEY `oa_clients_user_id_fk` (`user_id`),
  CONSTRAINT `oa_clients_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='OAuth Clients authorized to read or write user data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_access_tokens`
--

DROP TABLE IF EXISTS `oauth_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text,
  `revoked` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_auth_codes`
--

DROP TABLE IF EXISTS `oauth_auth_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `scopes` text,
  `revoked` tinyint(4) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_clients`
--

DROP TABLE IF EXISTS `oauth_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_clients` (
  `id` int(11) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `redirect` text,
  `personal_access_client` tinyint(4) DEFAULT NULL,
  `password_client` tinyint(4) DEFAULT NULL,
  `revoked` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_personal_access_clients`
--

DROP TABLE IF EXISTS `oauth_personal_access_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(11) DEFAULT NULL,
  `client_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oauth_refresh_tokens`
--

DROP TABLE IF EXISTS `oauth_refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) DEFAULT NULL,
  `access_token_id` varchar(100) DEFAULT NULL,
  `revoked` tinyint(4) DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `opencures_biomarkers`
--

DROP TABLE IF EXISTS `opencures_biomarkers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opencures_biomarkers` (
  `slug` varchar(34) DEFAULT NULL,
  `apple_mapping` varchar(12) DEFAULT NULL,
  `category` varchar(12) DEFAULT NULL,
  `name_long` varchar(40) DEFAULT NULL,
  `unit` varchar(13) DEFAULT NULL,
  `default_value` varchar(1) DEFAULT NULL,
  `description` text,
  `references_0` varchar(161) DEFAULT NULL,
  `references_1` varchar(67) DEFAULT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paddle_subscriptions`
--

DROP TABLE IF EXISTS `paddle_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paddle_subscriptions` (
  `id` bigint(20) DEFAULT NULL,
  `subscription_id` int(11) DEFAULT NULL,
  `plan_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(191) DEFAULT NULL,
  `update_url` varchar(191) DEFAULT NULL,
  `cancel_url` varchar(191) DEFAULT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prodrome_scan_biomarker_panel`
--

DROP TABLE IF EXISTS `prodrome_scan_biomarker_panel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prodrome_scan_biomarker_panel` (
  `slug` text,
  `type` text,
  `subtype` text,
  `classification` text,
  `name_long` text,
  `name_long_prodrome_scan` text,
  `unit` text,
  `default_value` text,
  `description` text,
  `references` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `property_tags`
--

DROP TABLE IF EXISTS `property_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property_tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `test_panels`
--

DROP TABLE IF EXISTS `test_panels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_panels` (
  `slug` text,
  `biomarker_id` text,
  `name` text,
  `entries` text,
  `description` text,
  `references` text,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `third_party_study_results`
--

DROP TABLE IF EXISTS `third_party_study_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `third_party_study_results` (
  `cause_id` int(10) unsigned NOT NULL COMMENT 'variable ID of the cause variable for which the user desires correlations',
  `effect_id` int(10) unsigned NOT NULL COMMENT 'variable ID of the effect variable for which the user desires correlations',
  `qm_score` double DEFAULT NULL COMMENT 'QM Score',
  `forward_pearson_correlation_coefficient` float(10,4) DEFAULT NULL COMMENT 'Pearson correlation coefficient between cause and effect measurements',
  `value_predicting_high_outcome` double DEFAULT NULL COMMENT 'cause value that predicts an above average effect value (in default unit for cause variable)',
  `value_predicting_low_outcome` double DEFAULT NULL COMMENT 'cause value that predicts a below average effect value (in default unit for cause variable)',
  `predicts_high_effect_change` int(5) DEFAULT NULL COMMENT 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
  `predicts_low_effect_change` int(5) DEFAULT NULL COMMENT 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
  `average_effect` double DEFAULT NULL,
  `average_effect_following_high_cause` double DEFAULT NULL,
  `average_effect_following_low_cause` double DEFAULT NULL,
  `average_daily_low_cause` double DEFAULT NULL,
  `average_daily_high_cause` double DEFAULT NULL,
  `average_forward_pearson_correlation_over_onset_delays` float DEFAULT NULL,
  `average_reverse_pearson_correlation_over_onset_delays` float DEFAULT NULL,
  `cause_changes` int(11) DEFAULT NULL COMMENT 'Cause changes',
  `cause_filling_value` double DEFAULT NULL,
  `cause_number_of_processed_daily_measurements` int(11) NOT NULL,
  `cause_number_of_raw_measurements` int(11) NOT NULL,
  `cause_unit_id` int(11) DEFAULT NULL COMMENT 'Unit ID of Cause',
  `confidence_interval` double DEFAULT NULL COMMENT 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the Ã¢â‚¬Å“trueÃ¢â‚¬Â value of the correlation.',
  `critical_t_value` double DEFAULT NULL COMMENT 'Value of t from lookup table which t must exceed for significance.',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_source_name` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `duration_of_action` int(11) DEFAULT NULL COMMENT 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
  `effect_changes` int(11) DEFAULT NULL COMMENT 'Effect changes',
  `effect_filling_value` double DEFAULT NULL,
  `effect_number_of_processed_daily_measurements` int(11) NOT NULL,
  `effect_number_of_raw_measurements` int(11) NOT NULL,
  `error` text,
  `forward_spearman_correlation_coefficient` float DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number_of_days` int(11) NOT NULL,
  `number_of_pairs` int(11) DEFAULT NULL COMMENT 'Number of points that went into the correlation calculation',
  `onset_delay` int(11) DEFAULT NULL COMMENT 'User estimated or default time after cause measurement before a perceivable effect is observed',
  `onset_delay_with_strongest_pearson_correlation` int(10) DEFAULT NULL,
  `optimal_pearson_product` double DEFAULT NULL COMMENT 'Optimal Pearson Product',
  `p_value` double DEFAULT NULL COMMENT 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
  `pearson_correlation_with_no_onset_delay` float DEFAULT NULL,
  `predictive_pearson_correlation_coefficient` double DEFAULT NULL COMMENT 'Predictive Pearson Correlation Coefficient',
  `reverse_pearson_correlation_coefficient` double DEFAULT NULL COMMENT 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
  `statistical_significance` float(10,4) DEFAULT NULL COMMENT 'A function of the effect size and sample size',
  `strongest_pearson_correlation_coefficient` float DEFAULT NULL,
  `t_value` double DEFAULT NULL COMMENT 'Function of correlation and number of samples.',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint(20) unsigned NOT NULL,
  `grouped_cause_value_closest_to_value_predicting_low_outcome` double DEFAULT NULL,
  `grouped_cause_value_closest_to_value_predicting_high_outcome` double DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `wp_post_id` int(11) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `cause_variable_category_id` tinyint(3) unsigned DEFAULT NULL,
  `effect_variable_category_id` tinyint(3) unsigned DEFAULT NULL,
  `interesting_variable_category_pair` tinyint(1) DEFAULT NULL,
  `cause_variable_id` int(10) unsigned DEFAULT NULL,
  `effect_variable_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_cause_effect` (`user_id`,`cause_id`,`effect_id`),
  KEY `cause` (`cause_id`) USING BTREE,
  KEY `effect` (`effect_id`) USING BTREE,
  KEY `third_party_correlations_client_id_fk` (`client_id`),
  KEY `third_party_correlations_cause_variable_category_id_fk` (`cause_variable_category_id`),
  KEY `third_party_correlations_effect_variable_category_id_fk` (`effect_variable_category_id`),
  CONSTRAINT `third_party_correlations_cause_variable_category_id_fk` FOREIGN KEY (`cause_variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `third_party_correlations_cause_variables_id_fk` FOREIGN KEY (`cause_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `third_party_correlations_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `third_party_correlations_effect_variable_category_id_fk` FOREIGN KEY (`effect_variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `third_party_correlations_effect_variables_id_fk` FOREIGN KEY (`effect_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70535352 DEFAULT CHARSET=utf8 COMMENT='Stores Calculated Correlation Coefficients';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tracking_reminder_notifications`
--

DROP TABLE IF EXISTS `tracking_reminder_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking_reminder_notifications` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tracking_reminder_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `notified_at` timestamp NULL DEFAULT NULL,
  `received_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `notify_at` timestamp NOT NULL,
  `user_variable_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `notify_at_tracking_reminder_id_uindex` (`notify_at`,`tracking_reminder_id`),
  KEY `tracking_reminder_notifications_tracking_reminders_id_fk` (`tracking_reminder_id`),
  KEY `tracking_reminder_notifications_user_id_fk` (`user_id`),
  KEY `tracking_reminder_notifications_variables_id_fk` (`variable_id`),
  KEY `tracking_reminder_notifications_user_variables_id_fk` (`user_variable_id`),
  KEY `tracking_reminder_notifications_client_id_fk` (`client_id`),
  CONSTRAINT `tracking_reminder_notifications_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `tracking_reminder_notifications_tracking_reminders_id_fk` FOREIGN KEY (`tracking_reminder_id`) REFERENCES `tracking_reminders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tracking_reminder_notifications_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tracking_reminder_notifications_user_variables_id_fk` FOREIGN KEY (`user_variable_id`) REFERENCES `user_variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tracking_reminder_notifications_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tracking_reminders`
--

DROP TABLE IF EXISTS `tracking_reminders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tracking_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` varchar(80) NOT NULL,
  `variable_id` int(10) unsigned NOT NULL COMMENT 'Id for the variable to be tracked',
  `default_value` double DEFAULT NULL COMMENT 'Default value to use for the measurement when tracking',
  `reminder_start_time` time NOT NULL DEFAULT '00:00:00' COMMENT 'UTC time of day at which reminder notifications should appear in the case of daily or less frequent reminders.  The earliest UTC time at which notifications should appear in the case of intraday repeating reminders. ',
  `reminder_end_time` time DEFAULT NULL COMMENT 'Latest time of day at which reminders should appear',
  `reminder_sound` varchar(125) DEFAULT NULL COMMENT 'String identifier for the sound to accompany the reminder',
  `reminder_frequency` int(11) DEFAULT NULL COMMENT 'Number of seconds between one reminder and the next',
  `pop_up` tinyint(1) DEFAULT NULL COMMENT 'True if the reminders should appear as a popup notification',
  `sms` tinyint(1) DEFAULT NULL COMMENT 'True if the reminders should be delivered via SMS',
  `email` tinyint(1) DEFAULT NULL COMMENT 'True if the reminders should be delivered via email',
  `notification_bar` tinyint(1) DEFAULT NULL COMMENT 'True if the reminders should appear in the notification bar',
  `last_tracked` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `start_tracking_date` date DEFAULT NULL COMMENT 'Earliest date on which the user should be reminded to track in YYYY-MM-DD format',
  `stop_tracking_date` date DEFAULT NULL COMMENT 'Latest date on which the user should be reminded to track  in YYYY-MM-DD format',
  `instructions` text,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `image_url` varchar(2083) DEFAULT NULL,
  `user_variable_id` int(10) unsigned NOT NULL,
  `latest_tracking_reminder_notification_notify_at` timestamp NULL DEFAULT NULL,
  `number_of_tracking_reminder_notifications` int(10) unsigned DEFAULT NULL COMMENT 'Number of Tracking Reminder Notifications for this Tracking Reminder.\n                    [Formula: update tracking_reminders\n                        left join (\n                            select count(id) as total, tracking_reminder_id\n                            from tracking_reminder_notifications\n                            group by tracking_reminder_id\n                        )\n                        as grouped on tracking_reminders.id = grouped.tracking_reminder_id\n                    set tracking_reminders.number_of_tracking_reminder_notifications = count(grouped.total)]',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_user_var_time_freq` (`user_id`,`variable_id`,`reminder_start_time`,`reminder_frequency`) USING BTREE,
  KEY `user_client` (`user_id`,`client_id`) USING BTREE,
  KEY `tracking_reminders_user_variables_variable_id_user_id_fk` (`variable_id`,`user_id`),
  KEY `tracking_reminders_user_variables_user_variable_id_fk` (`user_variable_id`),
  KEY `tracking_reminders_client_id_fk` (`client_id`),
  CONSTRAINT `tracking_reminders_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `tracking_reminders_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tracking_reminders_user_variables_user_id_variable_id_fk` FOREIGN KEY (`user_id`, `variable_id`) REFERENCES `user_variables` (`user_id`, `variable_id`),
  CONSTRAINT `tracking_reminders_user_variables_user_variable_id_fk` FOREIGN KEY (`user_variable_id`) REFERENCES `user_variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tracking_reminders_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=145357 DEFAULT CHARSET=utf8 COMMENT='Manage what variables you want to track and when you want to be reminded.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `treatment_side_effect`
--

DROP TABLE IF EXISTS `treatment_side_effect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treatment_side_effect` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `treatment_variable_id` int(10) unsigned NOT NULL,
  `side_effect_variable_id` int(10) unsigned NOT NULL,
  `treatment_id` int(11) NOT NULL,
  `side_effect_id` int(11) NOT NULL,
  `votes_percent` int(11) NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `treatment_variable_id_side_effect_variable_id_uindex` (`treatment_variable_id`,`side_effect_variable_id`),
  UNIQUE KEY `treatment_id_side_effect_id_uindex` (`treatment_id`,`side_effect_id`),
  KEY `side_effect_variables_id_fk` (`side_effect_variable_id`),
  KEY `treatment_side_effect_side_effects_id_fk` (`side_effect_id`),
  CONSTRAINT `side_effect_variables_id_fk` FOREIGN KEY (`side_effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `treatment_side_effect_side_effects_id_fk` FOREIGN KEY (`side_effect_id`) REFERENCES `intuitive_side_effects` (`id`),
  CONSTRAINT `treatment_side_effect_treatments_id_fk` FOREIGN KEY (`treatment_id`) REFERENCES `treatments` (`id`),
  CONSTRAINT `treatment_variables_id_fk` FOREIGN KEY (`treatment_variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2510 DEFAULT CHARSET=utf8 COMMENT='User self-reported treatments and side-effects';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `treatments`
--

DROP TABLE IF EXISTS `treatments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treatments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `number_of_conditions` int(10) unsigned DEFAULT NULL,
  `number_of_side_effects` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `treName` (`name`) USING BTREE,
  KEY `ct_treatments_variables_id_fk` (`variable_id`),
  CONSTRAINT `ct_treatments_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9486 DEFAULT CHARSET=utf8 COMMENT='User self-reported treatments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ucum_units_of_measure`
--

DROP TABLE IF EXISTS `ucum_units_of_measure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ucum_units_of_measure` (
  `Code` text,
  `Descriptive_Name` text,
  `Code_System` text,
  `Definition` text,
  `Date_Created` text,
  `Synonym` text,
  `Status` text,
  `Kind_of_Quantity` text,
  `Date_Revised` text,
  `ConceptID` text,
  `Dimension` text,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=347 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unit_categories`
--

DROP TABLE IF EXISTS `unit_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT 'Unit category name',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `can_be_summed` tinyint(1) NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='Category for the unit of measurement';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unit_conversions`
--

DROP TABLE IF EXISTS `unit_conversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unit_conversions` (
  `unit_id` int(10) unsigned NOT NULL,
  `step_number` tinyint(3) unsigned NOT NULL COMMENT 'step in the conversion process',
  `operation` tinyint(3) unsigned NOT NULL COMMENT '0 is add and 1 is multiply',
  `value` double NOT NULL COMMENT 'number used in the operation',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qm_unit_conversions_unit_id_step_number_uindex` (`unit_id`,`step_number`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='Unit conversion formulas.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT 'Unit name',
  `abbreviated_name` varchar(16) NOT NULL COMMENT 'Unit abbreviation',
  `unit_category_id` tinyint(3) unsigned NOT NULL COMMENT 'Unit category ID',
  `minimum_value` double DEFAULT NULL COMMENT 'The minimum value for a single measurement. ',
  `maximum_value` double DEFAULT NULL COMMENT 'The maximum value for a single measurement',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `filling_type` enum('zero','none','interpolation','value') NOT NULL COMMENT 'The filling type specifies how periods of missing data should be treated. ',
  `number_of_outcome_population_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Global Population Studies for this Cause Unit.\n                [Formula: \n                    update units\n                        left join (\n                            select count(id) as total, cause_unit_id\n                            from aggregate_correlations\n                            group by cause_unit_id\n                        )\n                        as grouped on units.id = grouped.cause_unit_id\n                    set units.number_of_outcome_population_studies = count(grouped.total)\n                ]\n                ',
  `number_of_common_tags_where_tag_variable_unit` int(10) unsigned DEFAULT NULL COMMENT 'Number of Common Tags for this Tag Variable Unit.\n                [Formula: \n                    update units\n                        left join (\n                            select count(id) as total, tag_variable_unit_id\n                            from common_tags\n                            group by tag_variable_unit_id\n                        )\n                        as grouped on units.id = grouped.tag_variable_unit_id\n                    set units.number_of_common_tags_where_tag_variable_unit = count(grouped.total)\n                ]\n                ',
  `number_of_common_tags_where_tagged_variable_unit` int(10) unsigned DEFAULT NULL COMMENT 'Number of Common Tags for this Tagged Variable Unit.\n                [Formula: \n                    update units\n                        left join (\n                            select count(id) as total, tagged_variable_unit_id\n                            from common_tags\n                            group by tagged_variable_unit_id\n                        )\n                        as grouped on units.id = grouped.tagged_variable_unit_id\n                    set units.number_of_common_tags_where_tagged_variable_unit = count(grouped.total)\n                ]\n                ',
  `number_of_outcome_case_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Individual Case Studies for this Cause Unit.\n                [Formula: \n                    update units\n                        left join (\n                            select count(id) as total, cause_unit_id\n                            from correlations\n                            group by cause_unit_id\n                        )\n                        as grouped on units.id = grouped.cause_unit_id\n                    set units.number_of_outcome_case_studies = count(grouped.total)\n                ]\n                ',
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this Unit.\n                    [Formula: update units\n                        left join (\n                            select count(id) as total, unit_id\n                            from measurements\n                            group by unit_id\n                        )\n                        as grouped on units.id = grouped.unit_id\n                    set units.number_of_measurements = count(grouped.total)]',
  `number_of_user_variables_where_default_unit` int(10) unsigned DEFAULT NULL COMMENT 'Number of User Variables for this Default Unit.\n                    [Formula: update units\n                        left join (\n                            select count(id) as total, default_unit_id\n                            from user_variables\n                            group by default_unit_id\n                        )\n                        as grouped on units.id = grouped.default_unit_id\n                    set units.number_of_user_variables_where_default_unit = count(grouped.total)]',
  `number_of_variable_categories_where_default_unit` int(10) unsigned DEFAULT NULL COMMENT 'Number of Variable Categories for this Default Unit.\n                    [Formula: update units\n                        left join (\n                            select count(id) as total, default_unit_id\n                            from variable_categories\n                            group by default_unit_id\n                        )\n                        as grouped on units.id = grouped.default_unit_id\n                    set units.number_of_variable_categories_where_default_unit = count(grouped.total)]',
  `number_of_variables_where_default_unit` int(10) unsigned DEFAULT NULL COMMENT 'Number of Variables for this Default Unit.\n                    [Formula: update units\n                        left join (\n                            select count(id) as total, default_unit_id\n                            from variables\n                            group by default_unit_id\n                        )\n                        as grouped on units.id = grouped.default_unit_id\n                    set units.number_of_variables_where_default_unit = count(grouped.total)]',
  `advanced` tinyint(1) NOT NULL COMMENT 'Advanced units are rarely used and should generally be hidden or at the bottom of selector lists',
  `manual_tracking` tinyint(1) NOT NULL COMMENT 'Include manual tracking units in selector when manually recording a measurement. ',
  `filling_value` float DEFAULT NULL COMMENT 'The filling value is substituted used when data is missing if the filling type is set to value.',
  `scale` enum('nominal','interval','ratio','ordinal') NOT NULL COMMENT '\nOrdinal is used to simply depict the order of variables and not the difference between each of the variables. Ordinal scales are generally used to depict non-mathematical ideas such as frequency, satisfaction, happiness, a degree of pain etc.\n\nRatio Scale not only produces the order of variables but also makes the difference between variables known along with information on the value of true zero.\n\nInterval scale contains all the properties of ordinal scale, in addition to which, it offers a calculation of the difference between variables. The main characteristic of this scale is the equidistant difference between objects. Interval has no pre-decided starting point or a true zero value.\n\nNominal, also called the categorical variable scale, is defined as a scale used for labeling variables into distinct classifications and doesn’t involve a quantitative value or order.\n',
  `conversion_steps` text COMMENT 'An array of mathematical operations, each containing a operation and value field to apply to the value in the current unit to convert it to the default unit for the unit category. ',
  `maximum_daily_value` double DEFAULT NULL COMMENT 'The maximum aggregated measurement value over a single day.',
  `sort_order` int(11) NOT NULL,
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`) USING BTREE,
  UNIQUE KEY `abbr_name_UNIQUE` (`abbreviated_name`) USING BTREE,
  UNIQUE KEY `units_slug_uindex` (`slug`),
  KEY `fk_unitCategory` (`unit_category_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=218 DEFAULT CHARSET=utf8 COMMENT='Units of measurement';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_clients`
--

DROP TABLE IF EXISTS `user_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(80) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `earliest_measurement_at` timestamp NULL DEFAULT NULL COMMENT 'Earliest measurement time for this variable and client',
  `latest_measurement_at` timestamp NULL DEFAULT NULL COMMENT 'Earliest measurement time for this variable and client',
  `number_of_measurements` int(10) unsigned DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user_id`,`client_id`),
  KEY `user_clients_client_id_fk` (`client_id`),
  CONSTRAINT `user_clients_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `user_clients_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1098 DEFAULT CHARSET=utf8 COMMENT='Data sources for each user';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_meta`
--

DROP TABLE IF EXISTS `user_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_meta` (
  `umeta_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique number assigned to each row of the table.',
  `user_id` bigint(20) unsigned DEFAULT NULL COMMENT 'ID of the related user.',
  `meta_key` varchar(255) DEFAULT NULL COMMENT 'An identifying key for the piece of data.',
  `meta_value` longtext COMMENT 'The actual piece of data.',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`umeta_id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `meta_key` (`meta_key`) USING BTREE,
  CONSTRAINT `wp_usermeta_wp_users_ID_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table stores any further information related to the users. You will see other user profile fields for a user in the dashboard that are stored here.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_studies`
--

DROP TABLE IF EXISTS `user_studies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_studies` (
  `id` varchar(80) NOT NULL COMMENT 'Study id which should match OAuth client id',
  `type` varchar(20) NOT NULL COMMENT 'The type of study may be population, individual, or cohort study',
  `cause_variable_id` int(10) unsigned NOT NULL COMMENT 'variable ID of the cause variable for which the user desires correlations',
  `effect_variable_id` int(10) unsigned NOT NULL COMMENT 'variable ID of the effect variable for which the user desires correlations',
  `correlation_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the correlation statistics',
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `analysis_parameters` text COMMENT 'Additional parameters for the study such as experiment_end_time, experiment_start_time, cause_variable_filling_value, effect_variable_filling_value',
  `user_study_text` longtext COMMENT 'Overrides auto-generated study text',
  `user_title` text,
  `study_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `study_password` varchar(20) DEFAULT NULL,
  `study_images` text COMMENT 'Provided images will override the auto-generated images',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id` varchar(255) DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `wp_post_id` int(11) DEFAULT NULL,
  `newest_data_at` timestamp NULL DEFAULT NULL,
  `analysis_requested_at` timestamp NULL DEFAULT NULL,
  `reason_for_analysis` varchar(255) DEFAULT NULL,
  `analysis_ended_at` timestamp NULL DEFAULT NULL,
  `analysis_started_at` timestamp NULL DEFAULT NULL,
  `internal_error_message` varchar(255) DEFAULT NULL,
  `user_error_message` varchar(255) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `analysis_settings_modified_at` timestamp NULL DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_cause_effect_type` (`user_id`,`cause_variable_id`,`effect_variable_id`,`type`),
  UNIQUE KEY `user_studies_slug_uindex` (`slug`),
  KEY `user_studies_client_id_fk` (`client_id`),
  KEY `cause_variable_id` (`cause_variable_id`),
  KEY `effect_variable_id` (`effect_variable_id`),
  CONSTRAINT `user_studies_cause_variable_id_variables_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `user_studies_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `user_studies_effect_variable_id_variables_id_fk` FOREIGN KEY (`effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `user_studies_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores User Study Settings';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_study_results`
--

DROP TABLE IF EXISTS `user_study_results`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_study_results` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `cause_variable_id` int(10) unsigned NOT NULL,
  `effect_variable_id` int(10) unsigned NOT NULL,
  `qm_score` double DEFAULT NULL COMMENT 'A number representative of the relative importance of the relationship based on the strength, \n                    usefulness, and plausible causality.  The higher the number, the greater the perceived importance.  \n                    This value can be used for sorting relationships by importance.  ',
  `forward_pearson_correlation_coefficient` float(10,4) DEFAULT NULL COMMENT 'Pearson correlation coefficient between cause and effect measurements',
  `value_predicting_high_outcome` double DEFAULT NULL COMMENT 'cause value that predicts an above average effect value (in default unit for cause variable)',
  `value_predicting_low_outcome` double DEFAULT NULL COMMENT 'cause value that predicts a below average effect value (in default unit for cause variable)',
  `predicts_high_effect_change` int(5) DEFAULT NULL COMMENT 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ',
  `predicts_low_effect_change` int(5) NOT NULL COMMENT 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.',
  `average_effect` double NOT NULL COMMENT 'The average effect variable measurement value used in analysis in the common unit. ',
  `average_effect_following_high_cause` double NOT NULL COMMENT 'The average effect variable measurement value following an above average cause value (in the common unit). ',
  `average_effect_following_low_cause` double NOT NULL COMMENT 'The average effect variable measurement value following a below average cause value (in the common unit). ',
  `average_daily_low_cause` double NOT NULL COMMENT 'The average of below average cause values (in the common unit). ',
  `average_daily_high_cause` double NOT NULL COMMENT 'The average of above average cause values (in the common unit). ',
  `average_forward_pearson_correlation_over_onset_delays` float DEFAULT NULL,
  `average_reverse_pearson_correlation_over_onset_delays` float DEFAULT NULL,
  `cause_changes` int(11) NOT NULL COMMENT 'The number of times the cause measurement value was different from the one preceding it. ',
  `cause_filling_value` double DEFAULT NULL,
  `cause_number_of_processed_daily_measurements` int(11) NOT NULL,
  `cause_number_of_raw_measurements` int(11) NOT NULL,
  `cause_unit_id` smallint(5) unsigned DEFAULT NULL COMMENT 'Unit ID of Cause',
  `confidence_interval` double NOT NULL COMMENT 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.',
  `critical_t_value` double NOT NULL COMMENT 'Value of t from lookup table which t must exceed for significance.',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `data_source_name` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `duration_of_action` int(11) NOT NULL COMMENT 'Time over which the cause is expected to produce a perceivable effect following the onset delay',
  `effect_changes` int(11) NOT NULL COMMENT 'The number of times the effect measurement value was different from the one preceding it. ',
  `effect_filling_value` double DEFAULT NULL,
  `effect_number_of_processed_daily_measurements` int(11) NOT NULL,
  `effect_number_of_raw_measurements` int(11) NOT NULL,
  `forward_spearman_correlation_coefficient` float NOT NULL COMMENT 'Predictive spearman correlation of the lagged pair data. While the Pearson correlation assesses linear relationships, the Spearman correlation assesses monotonic relationships (whether linear or not).',
  `number_of_days` int(11) NOT NULL,
  `number_of_pairs` int(11) NOT NULL COMMENT 'Number of points that went into the correlation calculation',
  `onset_delay` int(11) NOT NULL COMMENT 'User estimated or default time after cause measurement before a perceivable effect is observed',
  `onset_delay_with_strongest_pearson_correlation` int(10) DEFAULT NULL,
  `optimal_pearson_product` double DEFAULT NULL COMMENT 'Optimal Pearson Product',
  `p_value` double DEFAULT NULL COMMENT 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.',
  `pearson_correlation_with_no_onset_delay` float DEFAULT NULL,
  `predictive_pearson_correlation_coefficient` double DEFAULT NULL COMMENT 'Predictive Pearson Correlation Coefficient',
  `reverse_pearson_correlation_coefficient` double DEFAULT NULL COMMENT 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation',
  `statistical_significance` float(10,4) DEFAULT NULL COMMENT 'A function of the effect size and sample size',
  `strongest_pearson_correlation_coefficient` float DEFAULT NULL,
  `t_value` double DEFAULT NULL COMMENT 'Function of correlation and number of samples.',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `grouped_cause_value_closest_to_value_predicting_low_outcome` double NOT NULL COMMENT 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
  `grouped_cause_value_closest_to_value_predicting_high_outcome` double NOT NULL COMMENT 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ',
  `client_id` varchar(255) DEFAULT NULL,
  `published_at` timestamp NULL DEFAULT NULL,
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `cause_variable_category_id` tinyint(3) unsigned NOT NULL,
  `effect_variable_category_id` tinyint(3) unsigned NOT NULL,
  `interesting_variable_category_pair` tinyint(1) NOT NULL COMMENT 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ',
  `newest_data_at` timestamp NULL DEFAULT NULL COMMENT 'The time the source data was last updated. This indicated whether the analysis is stale and should be performed again. ',
  `analysis_requested_at` timestamp NULL DEFAULT NULL,
  `reason_for_analysis` varchar(255) NOT NULL COMMENT 'The reason analysis was requested.',
  `analysis_started_at` timestamp NOT NULL,
  `analysis_ended_at` timestamp NULL DEFAULT NULL,
  `user_error_message` text,
  `internal_error_message` text,
  `cause_user_variable_id` int(10) unsigned NOT NULL,
  `effect_user_variable_id` int(10) unsigned NOT NULL,
  `latest_measurement_start_at` timestamp NULL DEFAULT NULL,
  `earliest_measurement_start_at` timestamp NULL DEFAULT NULL,
  `cause_baseline_average_per_day` float NOT NULL COMMENT 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)',
  `cause_baseline_average_per_duration_of_action` float NOT NULL COMMENT 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)',
  `cause_treatment_average_per_day` float NOT NULL COMMENT 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)',
  `cause_treatment_average_per_duration_of_action` float NOT NULL COMMENT 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)',
  `effect_baseline_average` float DEFAULT NULL COMMENT 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)',
  `effect_baseline_relative_standard_deviation` float NOT NULL COMMENT 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)',
  `effect_baseline_standard_deviation` float DEFAULT NULL COMMENT 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)',
  `effect_follow_up_average` float NOT NULL COMMENT 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
  `effect_follow_up_percent_change_from_baseline` float NOT NULL COMMENT 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)',
  `z_score` float DEFAULT NULL COMMENT 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.',
  `experiment_end_at` timestamp NOT NULL COMMENT 'The latest data used in the analysis. ',
  `experiment_start_at` timestamp NOT NULL COMMENT 'The earliest data used in the analysis. ',
  `aggregate_correlation_id` int(11) DEFAULT NULL,
  `aggregated_at` timestamp NULL DEFAULT NULL,
  `usefulness_vote` int(11) DEFAULT NULL COMMENT 'The opinion of the data owner on whether or not knowledge of this relationship is useful. \n                        -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a \n                        previous vote.  null corresponds to never having voted before.',
  `causality_vote` int(11) DEFAULT NULL COMMENT 'The opinion of the data owner on whether or not there is a plausible mechanism of action\n                        by which the predictor variable could influence the outcome variable.',
  `deletion_reason` varchar(280) DEFAULT NULL COMMENT 'The reason the variable was deleted.',
  `record_size_in_kb` int(11) DEFAULT NULL,
  `correlations_over_durations` text NOT NULL COMMENT 'Pearson correlations calculated with various duration of action lengths. This can be used to compare short and long term effects. ',
  `correlations_over_delays` text NOT NULL COMMENT 'Pearson correlations calculated with various onset delay lags used to identify reversed causality or asses the significant of a correlation with a given lag parameters. ',
  `is_public` tinyint(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `boring` tinyint(1) DEFAULT NULL COMMENT 'The relationship is boring if it is obvious, the predictor is not controllable, the outcome is not a goal, the relationship could not be causal, or the confidence is low. ',
  `outcome_is_goal` tinyint(1) DEFAULT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
  `predictor_is_controllable` tinyint(1) DEFAULT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
  `plausibly_causal` tinyint(1) DEFAULT NULL COMMENT 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ',
  `obvious` tinyint(1) DEFAULT NULL COMMENT 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ',
  `number_of_up_votes` int(11) NOT NULL COMMENT 'Number of people who feel this relationship is plausible and useful. ',
  `number_of_down_votes` int(11) NOT NULL COMMENT 'Number of people who feel this relationship is implausible or not useful. ',
  `strength_level` enum('VERY STRONG','STRONG','MODERATE','WEAK','VERY WEAK') NOT NULL COMMENT 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ',
  `confidence_level` enum('HIGH','MEDIUM','LOW') NOT NULL COMMENT 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ',
  `relationship` enum('POSITIVE','NEGATIVE','NONE') NOT NULL COMMENT 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ',
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `correlations_user_id_cause_variable_id_effect_variable_id_uindex` (`user_id`,`cause_variable_id`,`effect_variable_id`),
  UNIQUE KEY `correlations_pk` (`user_id`,`cause_variable_id`,`effect_variable_id`),
  UNIQUE KEY `correlations_slug_uindex` (`slug`),
  KEY `correlations_client_id_fk` (`client_id`),
  KEY `correlations_user_variables_cause_user_variable_id_fk` (`cause_user_variable_id`),
  KEY `correlations_user_variables_effect_user_variable_id_fk` (`effect_user_variable_id`),
  KEY `correlations_cause_variable_category_id_fk` (`cause_variable_category_id`),
  KEY `correlations_effect_variable_category_id_fk` (`effect_variable_category_id`),
  KEY `correlations_cause_unit_id_fk` (`cause_unit_id`),
  KEY `correlations_cause_variable_id_fk` (`cause_variable_id`),
  KEY `correlations_effect_variable_id_fk` (`effect_variable_id`),
  KEY `correlations_wp_posts_ID_fk` (`wp_post_id`),
  KEY `correlations_updated_at_index` (`updated_at`),
  KEY `correlations_user_id_deleted_at_qm_score_index` (`user_id`,`deleted_at`,`qm_score`),
  KEY `correlations_analysis_started_at_index` (`analysis_started_at`),
  KEY `correlations_aggregate_correlations_id_fk` (`aggregate_correlation_id`),
  KEY `user_id_cause_variable_id_deleted_at_qm_score_index` (`user_id`,`cause_variable_id`,`deleted_at`,`qm_score`),
  KEY `user_id_effect_variable_id_deleted_at_qm_score_index` (`user_id`,`effect_variable_id`,`deleted_at`,`qm_score`),
  KEY `correlations_deleted_at_analysis_ended_at_index` (`deleted_at`,`analysis_ended_at`),
  KEY `correlations_deleted_at_z_score_index` (`deleted_at`,`z_score`),
  CONSTRAINT `correlations_aggregate_correlations_id_fk` FOREIGN KEY (`aggregate_correlation_id`) REFERENCES `global_study_results` (`id`),
  CONSTRAINT `correlations_cause_unit_id_fk` FOREIGN KEY (`cause_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `correlations_cause_variable_category_id_fk` FOREIGN KEY (`cause_variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `correlations_cause_variable_id_fk` FOREIGN KEY (`cause_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `correlations_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `correlations_effect_variable_category_id_fk` FOREIGN KEY (`effect_variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `correlations_effect_variable_id_fk` FOREIGN KEY (`effect_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `correlations_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `correlations_user_variables_cause_user_variable_id_fk` FOREIGN KEY (`cause_user_variable_id`) REFERENCES `user_variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `correlations_user_variables_effect_user_variable_id_fk` FOREIGN KEY (`effect_user_variable_id`) REFERENCES `user_variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `correlations_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=119250691 DEFAULT CHARSET=utf8 COMMENT='Examination of the relationship between predictor and outcome variables.  This includes the potential optimal values for a given variable. ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_variable_clients`
--

DROP TABLE IF EXISTS `user_variable_clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_variable_clients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(80) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `earliest_measurement_at` timestamp NULL DEFAULT NULL COMMENT 'Earliest measurement time for this variable and client',
  `latest_measurement_at` timestamp NULL DEFAULT NULL COMMENT 'Earliest measurement time for this variable and client',
  `number_of_measurements` int(10) unsigned DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user_id` bigint(20) unsigned NOT NULL,
  `user_variable_id` int(11) unsigned NOT NULL,
  `variable_id` int(11) unsigned NOT NULL COMMENT 'Id of variable',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user_id`,`variable_id`,`client_id`),
  KEY `user_variable_clients_client_id_fk` (`client_id`),
  KEY `user_variable_clients_user_variables_user_variable_id_fk` (`user_variable_id`),
  KEY `user_variable_clients_variable_id_fk` (`variable_id`),
  CONSTRAINT `user_variable_clients_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `user_variable_clients_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_variable_clients_user_variables_user_variable_id_fk` FOREIGN KEY (`user_variable_id`) REFERENCES `user_variables` (`id`),
  CONSTRAINT `user_variable_clients_variable_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=200254 DEFAULT CHARSET=utf8 COMMENT='Information about variable data obtained from specific data sources for specific users.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_variable_outcome_category`
--

DROP TABLE IF EXISTS `user_variable_outcome_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_variable_outcome_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_variable_id` int(10) unsigned NOT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `variable_category_id` tinyint(3) unsigned NOT NULL,
  `number_of_outcome_user_variables` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_variable_id_variable_category_id_uindex` (`user_variable_id`,`variable_category_id`),
  KEY `user_variable_outcome_category_variable_categories_id_fk` (`variable_category_id`),
  KEY `user_variable_outcome_category_variables_id_fk` (`variable_id`),
  CONSTRAINT `user_variable_outcome_category_user_variables_id_fk` FOREIGN KEY (`user_variable_id`) REFERENCES `user_variables` (`id`),
  CONSTRAINT `user_variable_outcome_category_variable_categories_id_fk` FOREIGN KEY (`variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `user_variable_outcome_category_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_variable_predictor_category`
--

DROP TABLE IF EXISTS `user_variable_predictor_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_variable_predictor_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_variable_id` int(10) unsigned NOT NULL,
  `variable_id` int(10) unsigned NOT NULL,
  `variable_category_id` tinyint(3) unsigned NOT NULL,
  `number_of_predictor_user_variables` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_variable_id_variable_category_id_uindex` (`user_variable_id`,`variable_category_id`),
  KEY `user_variable_predictor_category_variable_categories_id_fk` (`variable_category_id`),
  KEY `user_variable_predictor_category_variables_id_fk` (`variable_id`),
  CONSTRAINT `user_variable_predictor_category_user_variables_id_fk` FOREIGN KEY (`user_variable_id`) REFERENCES `user_variables` (`id`),
  CONSTRAINT `user_variable_predictor_category_variable_categories_id_fk` FOREIGN KEY (`variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `user_variable_predictor_category_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_variable_tags`
--

DROP TABLE IF EXISTS `user_variable_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_variable_tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tagged_variable_id` int(10) unsigned NOT NULL COMMENT 'This is the id of the variable being tagged with an ingredient or something.',
  `tag_variable_id` int(10) unsigned NOT NULL COMMENT 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.',
  `conversion_factor` double NOT NULL COMMENT 'Number by which we multiply the tagged variable''s value to obtain the tag variable''s value',
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `client_id` varchar(80) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tagged_user_variable_id` int(10) unsigned DEFAULT NULL,
  `tag_user_variable_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_user_tag_tagged` (`tagged_variable_id`,`tag_variable_id`,`user_id`) USING BTREE,
  KEY `fk_conversionUnit` (`tag_variable_id`) USING BTREE,
  KEY `user_tags_user_id_fk` (`user_id`),
  KEY `user_tags_client_id_fk` (`client_id`),
  KEY `user_tags_tag_user_variable_id_fk` (`tag_user_variable_id`),
  KEY `user_tags_tagged_user_variable_id_fk` (`tagged_user_variable_id`),
  CONSTRAINT `user_tags_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `user_tags_tag_user_variable_id_fk` FOREIGN KEY (`tag_user_variable_id`) REFERENCES `user_variables` (`id`),
  CONSTRAINT `user_tags_tag_variable_id_variables_id_fk` FOREIGN KEY (`tag_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `user_tags_tagged_user_variable_id_fk` FOREIGN KEY (`tagged_user_variable_id`) REFERENCES `user_variables` (`id`),
  CONSTRAINT `user_tags_tagged_variable_id_variables_id_fk` FOREIGN KEY (`tagged_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `user_tags_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8 COMMENT='User self-reported variable tags, used to infer the user intake of the different ingredients by just entering the foods. The inferred intake levels will then be used to determine the effects of different nutrients on the user during analysis.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_variables`
--

DROP TABLE IF EXISTS `user_variables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_variables` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT 'ID of the parent variable if this variable has any parent',
  `client_id` varchar(80) DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `variable_id` int(10) unsigned NOT NULL COMMENT 'ID of variable',
  `default_unit_id` smallint(5) unsigned DEFAULT NULL COMMENT 'ID of unit to use for this variable',
  `minimum_allowed_value` double DEFAULT NULL COMMENT 'Minimum reasonable value for this variable (uses default unit)',
  `maximum_allowed_value` double DEFAULT NULL COMMENT 'Maximum reasonable value for this variable (uses default unit)',
  `filling_value` double DEFAULT '-1' COMMENT 'Value for replacing null measurements',
  `join_with` int(10) unsigned DEFAULT NULL COMMENT 'The Variable this Variable should be joined with. If the variable is joined with some other variable then it is not shown to user in the list of variables',
  `onset_delay` int(10) unsigned DEFAULT NULL COMMENT 'How long it takes for a measurement in this variable to take effect',
  `duration_of_action` int(10) unsigned DEFAULT NULL COMMENT 'Estimated duration of time following the onset delay in which a stimulus produces a perceivable effect',
  `variable_category_id` tinyint(3) unsigned DEFAULT NULL COMMENT 'ID of variable category',
  `cause_only` tinyint(1) DEFAULT NULL COMMENT 'A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user',
  `filling_type` enum('value','none') DEFAULT NULL COMMENT '0 -> No filling, 1 -> Use filling-value',
  `number_of_processed_daily_measurements` int(11) DEFAULT NULL COMMENT 'Number of processed measurements',
  `measurements_at_last_analysis` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Number of measurements at last analysis',
  `last_unit_id` smallint(5) unsigned DEFAULT NULL COMMENT 'ID of last Unit',
  `last_original_unit_id` smallint(5) unsigned DEFAULT NULL COMMENT 'ID of last original Unit',
  `last_value` double DEFAULT NULL COMMENT 'Last Value',
  `last_original_value` double unsigned DEFAULT NULL COMMENT 'Last original value which is stored',
  `number_of_correlations` int(11) DEFAULT NULL COMMENT 'Number of correlations for this variable',
  `status` varchar(25) DEFAULT NULL,
  `standard_deviation` double DEFAULT NULL COMMENT 'Standard deviation',
  `variance` double DEFAULT NULL COMMENT 'Variance',
  `minimum_recorded_value` double DEFAULT NULL COMMENT 'Minimum recorded value of this variable',
  `maximum_recorded_value` double DEFAULT NULL COMMENT 'Maximum recorded value of this variable',
  `mean` double DEFAULT NULL COMMENT 'Mean',
  `median` double DEFAULT NULL COMMENT 'Median',
  `most_common_original_unit_id` int(11) DEFAULT NULL COMMENT 'Most common Unit ID',
  `most_common_value` double DEFAULT NULL COMMENT 'Most common value',
  `number_of_unique_daily_values` int(11) DEFAULT NULL COMMENT 'Number of unique daily values',
  `number_of_unique_values` int(11) DEFAULT NULL COMMENT 'Number of unique values',
  `number_of_changes` int(11) DEFAULT NULL COMMENT 'Number of changes',
  `skewness` double DEFAULT NULL COMMENT 'Skewness',
  `kurtosis` double DEFAULT NULL COMMENT 'Kurtosis',
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `outcome` tinyint(1) DEFAULT NULL COMMENT 'Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables',
  `data_sources_count` text COMMENT 'Array of connector or client measurement data source names as key and number of measurements as value',
  `earliest_filling_time` int(11) DEFAULT NULL COMMENT 'Earliest filling time',
  `latest_filling_time` int(11) DEFAULT NULL COMMENT 'Latest filling time',
  `last_processed_daily_value` double DEFAULT NULL COMMENT 'Last value for user after daily aggregation and filling',
  `outcome_of_interest` tinyint(1) DEFAULT '0',
  `predictor_of_interest` tinyint(1) DEFAULT '0',
  `experiment_start_time` timestamp NULL DEFAULT NULL,
  `experiment_end_time` timestamp NULL DEFAULT NULL,
  `description` text,
  `alias` varchar(125) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `second_to_last_value` double DEFAULT NULL,
  `third_to_last_value` double DEFAULT NULL,
  `number_of_user_correlations_as_effect` int(10) unsigned DEFAULT NULL COMMENT 'Number of user correlations for which this variable is the effect variable',
  `number_of_user_correlations_as_cause` int(10) unsigned DEFAULT NULL COMMENT 'Number of user correlations for which this variable is the cause variable',
  `combination_operation` enum('SUM','MEAN') DEFAULT NULL COMMENT 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
  `informational_url` varchar(2000) DEFAULT NULL COMMENT 'Wikipedia url',
  `most_common_connector_id` int(10) unsigned DEFAULT NULL,
  `valence` enum('positive','negative','neutral') DEFAULT NULL,
  `wikipedia_title` varchar(100) DEFAULT NULL,
  `number_of_tracking_reminders` int(11) NOT NULL,
  `number_of_raw_measurements_with_tags_joins_children` int(10) unsigned DEFAULT NULL,
  `most_common_source_name` varchar(255) DEFAULT NULL,
  `optimal_value_message` varchar(500) DEFAULT NULL,
  `best_cause_variable_id` int(10) DEFAULT NULL,
  `best_effect_variable_id` int(10) DEFAULT NULL,
  `user_maximum_allowed_daily_value` double DEFAULT NULL,
  `user_minimum_allowed_daily_value` double DEFAULT NULL,
  `user_minimum_allowed_non_zero_value` double DEFAULT NULL,
  `minimum_allowed_seconds_between_measurements` int(11) DEFAULT NULL,
  `average_seconds_between_measurements` int(11) DEFAULT NULL,
  `median_seconds_between_measurements` int(11) DEFAULT NULL,
  `last_correlated_at` timestamp NULL DEFAULT NULL,
  `number_of_measurements_with_tags_at_last_correlation` int(11) DEFAULT NULL,
  `analysis_settings_modified_at` timestamp NULL DEFAULT NULL,
  `newest_data_at` timestamp NULL DEFAULT NULL,
  `analysis_requested_at` timestamp NULL DEFAULT NULL,
  `reason_for_analysis` varchar(255) DEFAULT NULL,
  `analysis_started_at` timestamp NULL DEFAULT NULL,
  `analysis_ended_at` timestamp NULL DEFAULT NULL,
  `user_error_message` text,
  `internal_error_message` text,
  `earliest_source_measurement_start_at` timestamp NULL DEFAULT NULL,
  `latest_source_measurement_start_at` timestamp NULL DEFAULT NULL,
  `latest_tagged_measurement_start_at` timestamp NULL DEFAULT NULL,
  `earliest_tagged_measurement_start_at` timestamp NULL DEFAULT NULL,
  `latest_non_tagged_measurement_start_at` timestamp NULL DEFAULT NULL,
  `earliest_non_tagged_measurement_start_at` timestamp NULL DEFAULT NULL,
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `number_of_soft_deleted_measurements` int(11) DEFAULT NULL COMMENT 'Formula: update user_variables v \n                inner join (\n                    select measurements.user_variable_id, count(measurements.id) as number_of_soft_deleted_measurements \n                    from measurements\n                    where measurements.deleted_at is not null\n                    group by measurements.user_variable_id\n                    ) m on v.id = m.user_variable_id\n                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements\n            ',
  `best_user_correlation_id` int(11) DEFAULT NULL,
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this User Variable.\n                    [Formula: update user_variables\n                        left join (\n                            select count(id) as total, user_variable_id\n                            from measurements\n                            group by user_variable_id\n                        )\n                        as grouped on user_variables.id = grouped.user_variable_id\n                    set user_variables.number_of_measurements = count(grouped.total)]',
  `number_of_tracking_reminder_notifications` int(10) unsigned DEFAULT NULL COMMENT 'Number of Tracking Reminder Notifications for this User Variable.\n                    [Formula: update user_variables\n                        left join (\n                            select count(id) as total, user_variable_id\n                            from tracking_reminder_notifications\n                            group by user_variable_id\n                        )\n                        as grouped on user_variables.id = grouped.user_variable_id\n                    set user_variables.number_of_tracking_reminder_notifications = count(grouped.total)]',
  `deletion_reason` varchar(280) DEFAULT NULL COMMENT 'The reason the variable was deleted.',
  `record_size_in_kb` int(11) DEFAULT NULL,
  `number_of_common_tags` int(11) DEFAULT NULL COMMENT 'Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. ',
  `number_common_tagged_by` int(11) DEFAULT NULL COMMENT 'Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. ',
  `number_of_common_joined_variables` int(11) DEFAULT NULL COMMENT 'Joined variables are duplicate variables measuring the same thing. ',
  `number_of_common_ingredients` int(11) DEFAULT NULL COMMENT 'Measurements for this variable can be used to synthetically generate ingredient measurements. ',
  `number_of_common_foods` int(11) DEFAULT NULL COMMENT 'Measurements for this ingredient variable can be synthetically generate by food measurements. ',
  `number_of_common_children` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
  `number_of_common_parents` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ',
  `number_of_user_tags` int(11) DEFAULT NULL COMMENT 'Number of categories, joined variables, or ingredients for this variable that use this variables measurements to generate synthetically derived measurements. This only includes ones created by the user. ',
  `number_user_tagged_by` int(11) DEFAULT NULL COMMENT 'Number of children, joined variables or foods that this use has measurements for which are to be used to generate synthetic measurements for this variable. This only includes ones created by the user. ',
  `number_of_user_joined_variables` int(11) DEFAULT NULL COMMENT 'Joined variables are duplicate variables measuring the same thing. This only includes ones created by the user. ',
  `number_of_user_ingredients` int(11) DEFAULT NULL COMMENT 'Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by the user. ',
  `number_of_user_foods` int(11) DEFAULT NULL COMMENT 'Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by the user. ',
  `number_of_user_children` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ',
  `number_of_user_parents` int(11) DEFAULT NULL COMMENT 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by the user. ',
  `is_public` tinyint(1) DEFAULT NULL,
  `is_goal` tinyint(1) DEFAULT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
  `controllable` tinyint(1) DEFAULT NULL COMMENT 'You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ',
  `boring` tinyint(1) DEFAULT NULL COMMENT 'The user variable is boring if the owner would not be interested in its causes or effects. ',
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  `predictor` tinyint(1) DEFAULT NULL COMMENT 'predictor is true if the variable is a factor that could influence an outcome of interest',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`variable_id`),
  UNIQUE KEY `user_variables_slug_uindex` (`slug`),
  KEY `fk_variableSettings` (`variable_id`) USING BTREE,
  KEY `user_variables_client_id_fk` (`client_id`),
  KEY `user_variables_variable_category_id_fk` (`variable_category_id`),
  KEY `user_variables_default_unit_id_fk` (`default_unit_id`),
  KEY `user_variables_last_unit_id_fk` (`last_unit_id`),
  KEY `user_variables_wp_posts_ID_fk` (`wp_post_id`),
  KEY `variables_analysis_ended_at_index` (`analysis_ended_at`),
  KEY `user_variables_analysis_started_at_index` (`analysis_started_at`),
  KEY `user_variables_user_id_latest_tagged_measurement_time_index` (`user_id`),
  KEY `user_variables_correlations_qm_score_fk` (`best_user_correlation_id`),
  CONSTRAINT `user_variables_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `user_variables_correlations_qm_score_fk` FOREIGN KEY (`best_user_correlation_id`) REFERENCES `user_study_results` (`id`) ON DELETE SET NULL,
  CONSTRAINT `user_variables_default_unit_id_fk` FOREIGN KEY (`default_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `user_variables_last_unit_id_fk` FOREIGN KEY (`last_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `user_variables_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_variables_variable_category_id_fk` FOREIGN KEY (`variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `user_variables_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `user_variables_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=248274 DEFAULT CHARSET=utf8 COMMENT='Variable statistics, analysis settings, and overviews with data visualizations and likely outcomes or predictors based on data for a specific individual';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique number assigned to each user.',
  `client_id` varchar(255) NOT NULL,
  `user_login` varchar(60) DEFAULT NULL COMMENT 'Unique username for the user.',
  `user_email` varchar(100) DEFAULT NULL COMMENT 'Email address of the user.',
  `email` varchar(320) DEFAULT NULL COMMENT 'Needed for laravel password resets because WP user_email field will not work',
  `user_nicename` varchar(50) DEFAULT NULL COMMENT 'Display name for the user.',
  `user_url` varchar(2083) DEFAULT NULL COMMENT 'URL of the user, e.g. website address.',
  `user_registered` datetime DEFAULT NULL COMMENT 'Time and date the user registered.',
  `user_status` int(11) DEFAULT NULL COMMENT 'Was used in Multisite pre WordPress 3.0 to indicate a spam user.',
  `display_name` varchar(250) DEFAULT NULL COMMENT 'Desired name to be used publicly in the site, can be user_login, user_nicename, first name or last name defined in wp_usermeta.',
  `avatar_image` varchar(2083) DEFAULT NULL,
  `reg_provider` varchar(25) DEFAULT NULL COMMENT 'Registered via',
  `provider_id` varchar(255) DEFAULT NULL COMMENT 'Unique id from provider',
  `provider_token` varchar(255) DEFAULT NULL COMMENT 'Access token from provider',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `unsubscribed` tinyint(1) DEFAULT '0' COMMENT 'Indicates whether the use has specified that they want no emails or any form of communication. ',
  `old_user` tinyint(1) DEFAULT '0',
  `stripe_active` tinyint(1) DEFAULT '0',
  `stripe_id` varchar(255) DEFAULT NULL,
  `stripe_subscription` varchar(255) DEFAULT NULL,
  `stripe_plan` varchar(100) DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `subscription_ends_at` timestamp NULL DEFAULT NULL,
  `roles` varchar(255) DEFAULT NULL COMMENT 'An array containing all roles possessed by the user.  This indicates whether the use has roles such as administrator, developer, patient, student, researcher or physician. ',
  `time_zone_offset` int(11) DEFAULT NULL COMMENT 'The time-zone offset is the difference, in minutes, between UTC and local time. Note that this means that the offset is positive if the local timezone is behind UTC (i.e. UTC−06:00 Central) and negative if it is ahead.',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `earliest_reminder_time` time NOT NULL DEFAULT '06:00:00' COMMENT 'Earliest time of day at which reminders should appear in HH:MM:SS format in user timezone',
  `latest_reminder_time` time NOT NULL DEFAULT '22:00:00' COMMENT 'Latest time of day at which reminders should appear in HH:MM:SS format in user timezone',
  `push_notifications_enabled` tinyint(1) DEFAULT '1' COMMENT 'Should we send the user push notifications?',
  `track_location` tinyint(1) DEFAULT '0' COMMENT 'Set to true if the user wants to track their location',
  `combine_notifications` tinyint(1) DEFAULT '0' COMMENT 'Should we combine push notifications or send one for each tracking reminder notification?',
  `send_reminder_notification_emails` tinyint(1) DEFAULT '0' COMMENT 'Should we send reminder notification emails?',
  `send_predictor_emails` tinyint(1) DEFAULT '1' COMMENT 'Should we send predictor emails?',
  `get_preview_builds` tinyint(1) DEFAULT '0' COMMENT 'Should we send preview builds of the mobile application?',
  `subscription_provider` enum('stripe','apple','google') DEFAULT NULL,
  `last_sms_tracking_reminder_notification_id` bigint(20) unsigned DEFAULT NULL,
  `sms_notifications_enabled` tinyint(1) DEFAULT '0' COMMENT 'Should we send tracking reminder notifications via tex messages?',
  `phone_verification_code` varchar(25) DEFAULT NULL,
  `phone_number` varchar(25) DEFAULT NULL,
  `has_android_app` tinyint(1) DEFAULT '0',
  `has_ios_app` tinyint(1) DEFAULT '0',
  `has_chrome_extension` tinyint(1) DEFAULT '0',
  `referrer_user_id` bigint(20) unsigned DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `birthday` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `cover_photo` varchar(2083) DEFAULT NULL,
  `currency` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `gender` varchar(255) DEFAULT NULL,
  `language` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `tag_line` varchar(255) DEFAULT NULL,
  `verified` varchar(255) DEFAULT NULL,
  `zip_code` varchar(255) DEFAULT NULL,
  `spam` tinyint(2) NOT NULL DEFAULT '0',
  `deleted` tinyint(2) NOT NULL DEFAULT '0',
  `last_login_at` timestamp NULL DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `number_of_correlations` int(11) DEFAULT NULL,
  `number_of_connections` int(11) DEFAULT NULL,
  `number_of_tracking_reminders` int(11) DEFAULT NULL,
  `number_of_user_variables` int(11) DEFAULT NULL,
  `number_of_raw_measurements_with_tags` int(11) DEFAULT NULL,
  `number_of_raw_measurements_with_tags_at_last_correlation` int(11) DEFAULT NULL,
  `number_of_votes` int(11) DEFAULT NULL,
  `number_of_studies` int(11) DEFAULT NULL,
  `last_correlation_at` timestamp NULL DEFAULT NULL,
  `last_email_at` timestamp NULL DEFAULT NULL,
  `last_push_at` timestamp NULL DEFAULT NULL,
  `primary_outcome_variable_id` int(10) unsigned DEFAULT NULL,
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `analysis_ended_at` timestamp NULL DEFAULT NULL,
  `analysis_requested_at` timestamp NULL DEFAULT NULL,
  `analysis_started_at` timestamp NULL DEFAULT NULL,
  `internal_error_message` text,
  `newest_data_at` timestamp NULL DEFAULT NULL,
  `reason_for_analysis` varchar(255) DEFAULT NULL,
  `user_error_message` text,
  `status` varchar(25) DEFAULT NULL,
  `analysis_settings_modified_at` timestamp NULL DEFAULT NULL,
  `number_of_applications` int(10) unsigned DEFAULT NULL COMMENT 'Number of Applications for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from applications\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_applications = count(grouped.total)\n                ]\n                ',
  `number_of_oauth_access_tokens` int(10) unsigned DEFAULT NULL COMMENT 'Number of OAuth Access Tokens for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(access_token) as total, user_id\n                            from oa_access_tokens\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_oauth_access_tokens = count(grouped.total)\n                ]\n                ',
  `number_of_oauth_authorization_codes` int(10) unsigned DEFAULT NULL COMMENT 'Number of OAuth Authorization Codes for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(authorization_code) as total, user_id\n                            from oa_authorization_codes\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_oauth_authorization_codes = count(grouped.total)\n                ]\n                ',
  `number_of_oauth_clients` int(10) unsigned DEFAULT NULL COMMENT 'Number of OAuth Clients for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(client_id) as total, user_id\n                            from oa_clients\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_oauth_clients = count(grouped.total)\n                ]\n                ',
  `number_of_oauth_refresh_tokens` int(10) unsigned DEFAULT NULL COMMENT 'Number of OAuth Refresh Tokens for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(refresh_token) as total, user_id\n                            from oa_refresh_tokens\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_oauth_refresh_tokens = count(grouped.total)\n                ]\n                ',
  `number_of_button_clicks` int(10) unsigned DEFAULT NULL COMMENT 'Number of Button Clicks for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from button_clicks\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_button_clicks = count(grouped.total)\n                ]\n                ',
  `number_of_collaborators` int(10) unsigned DEFAULT NULL COMMENT 'Number of Collaborators for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from collaborators\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_collaborators = count(grouped.total)\n                ]\n                ',
  `number_of_connector_imports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Imports for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from connector_imports\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_connector_imports = count(grouped.total)\n                ]\n                ',
  `number_of_connector_requests` int(10) unsigned DEFAULT NULL COMMENT 'Number of Connector Requests for this User.\n                [Formula: \n                    update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from connector_requests\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_connector_requests = count(grouped.total)\n                ]\n                ',
  `number_of_measurement_exports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurement Exports for this User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from measurement_exports\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_measurement_exports = count(grouped.total)]',
  `number_of_measurement_imports` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurement Imports for this User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from measurement_imports\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_measurement_imports = count(grouped.total)]',
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from measurements\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_measurements = count(grouped.total)]',
  `number_of_sent_emails` int(10) unsigned DEFAULT NULL COMMENT 'Number of Sent Emails for this User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from sent_emails\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_sent_emails = count(grouped.total)]',
  `number_of_subscriptions` int(10) unsigned DEFAULT NULL COMMENT 'Number of Subscriptions for this User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from subscriptions\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_subscriptions = count(grouped.total)]',
  `number_of_tracking_reminder_notifications` int(10) unsigned DEFAULT NULL COMMENT 'Number of Tracking Reminder Notifications for this User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from tracking_reminder_notifications\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_tracking_reminder_notifications = count(grouped.total)]',
  `number_of_user_tags` int(10) unsigned DEFAULT NULL COMMENT 'Number of User Tags for this User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(id) as total, user_id\n                            from user_tags\n                            group by user_id\n                        )\n                        as grouped on wp_users.ID = grouped.user_id\n                    set wp_users.number_of_user_tags = count(grouped.total)]',
  `number_of_users_where_referrer_user` int(10) unsigned DEFAULT NULL COMMENT 'Number of Users for this Referrer User.\n                    [Formula: update wp_users\n                        left join (\n                            select count(ID) as total, referrer_user_id\n                            from wp_users\n                            group by referrer_user_id\n                        )\n                        as grouped on wp_users.ID = grouped.referrer_user_id\n                    set wp_users.number_of_users_where_referrer_user = count(grouped.total)]',
  `share_all_data` tinyint(1) NOT NULL DEFAULT '0',
  `deletion_reason` varchar(280) DEFAULT NULL COMMENT 'The reason the user deleted their account.',
  `number_of_patients` int(10) unsigned NOT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `sort_order` int(11) NOT NULL,
  `number_of_sharers` int(10) unsigned NOT NULL COMMENT 'Number of people sharing their data with you.',
  `number_of_trustees` int(10) unsigned NOT NULL COMMENT 'Number of people that you are sharing your data with.',
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_login_key` (`user_login`) USING BTREE,
  UNIQUE KEY `user_email` (`user_email`),
  UNIQUE KEY `wp_users_slug_uindex` (`slug`),
  KEY `user_nicename` (`user_nicename`) USING BTREE,
  KEY `wp_users_variables_id_fk` (`primary_outcome_variable_id`),
  KEY `wp_users_wp_users_ID_fk` (`referrer_user_id`),
  KEY `wp_users_wp_posts_ID_fk` (`wp_post_id`),
  CONSTRAINT `wp_users_variables_id_fk` FOREIGN KEY (`primary_outcome_variable_id`) REFERENCES `global_variables` (`id`),
  CONSTRAINT `wp_users_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `wp_users_wp_users_ID_fk` FOREIGN KEY (`referrer_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=92702 DEFAULT CHARSET=utf8 COMMENT='General user information and overall statistics';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variable_categories`
--

DROP TABLE IF EXISTS `variable_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable_categories` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT 'Name of the category',
  `filling_value` double DEFAULT NULL COMMENT 'Value for replacing null measurements',
  `maximum_allowed_value` double DEFAULT NULL COMMENT 'Maximum recorded value of this category',
  `minimum_allowed_value` double DEFAULT NULL COMMENT 'Minimum recorded value of this category',
  `duration_of_action` int(10) unsigned NOT NULL DEFAULT '86400' COMMENT 'How long the effect of a measurement in this variable lasts',
  `onset_delay` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'How long it takes for a measurement in this variable to take effect',
  `combination_operation` enum('SUM','MEAN') NOT NULL DEFAULT 'SUM' COMMENT 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN',
  `cause_only` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'A value of 1 indicates that this category is generally a cause in a causal relationship.  An example of a causeOnly category would be a category such as Work which would generally not be influenced by the behaviour of the user',
  `outcome` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `image_url` tinytext COMMENT 'Image URL',
  `default_unit_id` smallint(5) unsigned DEFAULT '12' COMMENT 'ID of the default unit for the category',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `manual_tracking` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Should we include in manual tracking searches?',
  `minimum_allowed_seconds_between_measurements` int(11) DEFAULT NULL,
  `average_seconds_between_measurements` int(11) DEFAULT NULL,
  `median_seconds_between_measurements` int(11) DEFAULT NULL,
  `wp_post_id` bigint(20) unsigned DEFAULT NULL,
  `filling_type` enum('zero','none','interpolation','value') DEFAULT NULL,
  `number_of_outcome_population_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Global Population Studies for this Cause Variable Category.\n                [Formula: \n                    update variable_categories\n                        left join (\n                            select count(id) as total, cause_variable_category_id\n                            from aggregate_correlations\n                            group by cause_variable_category_id\n                        )\n                        as grouped on variable_categories.id = grouped.cause_variable_category_id\n                    set variable_categories.number_of_outcome_population_studies = count(grouped.total)\n                ]\n                ',
  `number_of_predictor_population_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Global Population Studies for this Effect Variable Category.\n                [Formula: \n                    update variable_categories\n                        left join (\n                            select count(id) as total, effect_variable_category_id\n                            from aggregate_correlations\n                            group by effect_variable_category_id\n                        )\n                        as grouped on variable_categories.id = grouped.effect_variable_category_id\n                    set variable_categories.number_of_predictor_population_studies = count(grouped.total)\n                ]\n                ',
  `number_of_outcome_case_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Individual Case Studies for this Cause Variable Category.\n                [Formula: \n                    update variable_categories\n                        left join (\n                            select count(id) as total, cause_variable_category_id\n                            from correlations\n                            group by cause_variable_category_id\n                        )\n                        as grouped on variable_categories.id = grouped.cause_variable_category_id\n                    set variable_categories.number_of_outcome_case_studies = count(grouped.total)\n                ]\n                ',
  `number_of_predictor_case_studies` int(10) unsigned DEFAULT NULL COMMENT 'Number of Individual Case Studies for this Effect Variable Category.\n                [Formula: \n                    update variable_categories\n                        left join (\n                            select count(id) as total, effect_variable_category_id\n                            from correlations\n                            group by effect_variable_category_id\n                        )\n                        as grouped on variable_categories.id = grouped.effect_variable_category_id\n                    set variable_categories.number_of_predictor_case_studies = count(grouped.total)\n                ]\n                ',
  `number_of_measurements` int(10) unsigned DEFAULT NULL COMMENT 'Number of Measurements for this Variable Category.\n                    [Formula: update variable_categories\n                        left join (\n                            select count(id) as total, variable_category_id\n                            from measurements\n                            group by variable_category_id\n                        )\n                        as grouped on variable_categories.id = grouped.variable_category_id\n                    set variable_categories.number_of_measurements = count(grouped.total)]',
  `number_of_user_variables` int(10) unsigned DEFAULT NULL COMMENT 'Number of User Variables for this Variable Category.\n                    [Formula: update variable_categories\n                        left join (\n                            select count(id) as total, variable_category_id\n                            from user_variables\n                            group by variable_category_id\n                        )\n                        as grouped on variable_categories.id = grouped.variable_category_id\n                    set variable_categories.number_of_user_variables = count(grouped.total)]',
  `number_of_variables` int(10) unsigned DEFAULT NULL COMMENT 'Number of Variables for this Variable Category.\n                    [Formula: update variable_categories\n                        left join (\n                            select count(id) as total, variable_category_id\n                            from variables\n                            group by variable_category_id\n                        )\n                        as grouped on variable_categories.id = grouped.variable_category_id\n                    set variable_categories.number_of_variables = count(grouped.total)]',
  `is_public` tinyint(1) DEFAULT NULL,
  `synonyms` varchar(600) NOT NULL COMMENT 'The primary name and any synonyms for it. This field should be used for non-specific searches.',
  `amazon_product_category` varchar(100) NOT NULL COMMENT 'The Amazon equivalent product category.',
  `boring` tinyint(1) DEFAULT NULL COMMENT 'If boring, the category should be hidden by default.',
  `effect_only` tinyint(1) DEFAULT NULL COMMENT 'effect_only is true if people would never be interested in the effects of most variables in the category.',
  `predictor` tinyint(1) DEFAULT NULL COMMENT 'Predictor is true if people would like to know the effects of most variables in the category.',
  `font_awesome` varchar(100) DEFAULT NULL,
  `ion_icon` varchar(100) DEFAULT NULL,
  `more_info` varchar(255) DEFAULT NULL COMMENT 'More information displayed when the user is adding reminders and going through the onboarding process. ',
  `valence` enum('positive','negative','neutral') NOT NULL COMMENT 'Set the valence positive if more is better for all the variables in the category, negative if more is bad, and neutral if none of the variables have such a valence. Valence is null if there is not a consistent valence for all variables in the category. ',
  `name_singular` varchar(255) NOT NULL COMMENT 'The singular version of the name.',
  `sort_order` int(11) NOT NULL,
  `is_goal` enum('ALWAYS','SOMETIMES','NEVER') NOT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ',
  `controllable` enum('ALWAYS','SOMETIMES','NEVER') NOT NULL COMMENT 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ',
  `slug` varchar(200) DEFAULT NULL COMMENT 'The slug is the part of a URL that identifies a page in human-readable keywords.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `variable_categories_slug_uindex` (`slug`),
  KEY `variable_categories_default_unit_id_fk` (`default_unit_id`),
  KEY `variable_categories_wp_posts_ID_fk` (`wp_post_id`),
  CONSTRAINT `variable_categories_default_unit_id_fk` FOREIGN KEY (`default_unit_id`) REFERENCES `units` (`id`),
  CONSTRAINT `variable_categories_wp_posts_ID_fk` FOREIGN KEY (`wp_post_id`) REFERENCES `wp_posts` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8 COMMENT='Categories of of trackable variables include Treatments, Emotions, Symptoms, and Foods.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variable_outcome_category`
--

DROP TABLE IF EXISTS `variable_outcome_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable_outcome_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_id` int(10) unsigned NOT NULL,
  `variable_category_id` tinyint(3) unsigned NOT NULL,
  `number_of_outcome_variables` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variable_id_variable_category_id_uindex` (`variable_id`,`variable_category_id`),
  KEY `variable_outcome_category_variable_categories_id_fk` (`variable_category_id`),
  CONSTRAINT `variable_outcome_category_variable_categories_id_fk` FOREIGN KEY (`variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `variable_outcome_category_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variable_predictor_category`
--

DROP TABLE IF EXISTS `variable_predictor_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable_predictor_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_id` int(10) unsigned NOT NULL,
  `variable_category_id` tinyint(3) unsigned NOT NULL,
  `number_of_predictor_variables` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `variable_id_variable_category_id_uindex` (`variable_id`,`variable_category_id`),
  KEY `variable_predictor_category_variable_categories_id_fk` (`variable_category_id`),
  CONSTRAINT `variable_predictor_category_variable_categories_id_fk` FOREIGN KEY (`variable_category_id`) REFERENCES `variable_categories` (`id`),
  CONSTRAINT `variable_predictor_category_variables_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `variable_user_sources`
--

DROP TABLE IF EXISTS `variable_user_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `variable_user_sources` (
  `user_id` bigint(20) unsigned NOT NULL,
  `variable_id` int(10) unsigned NOT NULL COMMENT 'ID of variable',
  `timestamp` int(10) unsigned DEFAULT NULL COMMENT 'Time that this measurement occurred\n\nUses epoch minute (epoch time divided by 60)',
  `earliest_measurement_time` int(10) unsigned DEFAULT NULL COMMENT 'Earliest measurement time',
  `latest_measurement_time` int(10) unsigned DEFAULT NULL COMMENT 'Latest measurement time',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `data_source_name` varchar(80) NOT NULL,
  `number_of_raw_measurements` int(11) DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_variable_id` int(10) unsigned NOT NULL,
  `earliest_measurement_start_at` timestamp NULL DEFAULT NULL,
  `latest_measurement_start_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user` (`user_id`,`variable_id`,`data_source_name`),
  KEY `variable_user_sources_user_variables_variable_id_user_id_fk` (`variable_id`,`user_id`),
  KEY `variable_user_sources_user_variables_user_variable_id_fk` (`user_variable_id`),
  KEY `variable_user_sources_client_id_fk` (`client_id`),
  CONSTRAINT `variable_user_sources_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `oa_clients` (`client_id`),
  CONSTRAINT `variable_user_sources_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `variable_user_sources_user_variables_user_id_variable_id_fk` FOREIGN KEY (`user_id`, `variable_id`) REFERENCES `user_variables` (`user_id`, `variable_id`),
  CONSTRAINT `variable_user_sources_user_variables_user_variable_id_fk` FOREIGN KEY (`user_variable_id`) REFERENCES `user_variables` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `variable_user_sources_variable_id_fk` FOREIGN KEY (`variable_id`) REFERENCES `global_variables` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=269990 DEFAULT CHARSET=utf8 COMMENT='Information about variable data obtained from specific data sources for specific users.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_posts`
--

DROP TABLE IF EXISTS `wp_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique number assigned to each post.',
  `post_author` bigint(20) unsigned DEFAULT NULL COMMENT 'The user ID who created it.',
  `post_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Time and date of creation.',
  `post_date_gmt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'GMT time and date of creation. The GMT time and date is stored so there is no dependency on a site’s timezone in the future.',
  `post_content` longtext COMMENT 'Holds all the content for the post, including HTML, shortcodes and other content.',
  `post_title` text COMMENT 'Title of the post.',
  `post_excerpt` text COMMENT 'Custom intro or short version of the content.',
  `post_status` varchar(20) DEFAULT NULL COMMENT 'Status of the post, e.g. ‘draft’, ‘pending’, ‘private’, ‘publish’. Also a great WordPress <a href="https://poststatus.com/" target="_blank">news site</a>.',
  `comment_status` varchar(20) DEFAULT NULL COMMENT 'If comments are allowed.',
  `ping_status` varchar(20) DEFAULT NULL COMMENT 'If the post allows <a href="http://codex.wordpress.org/Introduction_to_Blogging#Pingbacks" target="_blank">ping and trackbacks</a>.',
  `post_password` varchar(255) DEFAULT NULL COMMENT 'Optional password used to view the post.',
  `post_name` varchar(200) DEFAULT NULL COMMENT 'URL friendly slug of the post title.',
  `to_ping` text COMMENT 'A list of URLs WordPress should send pingbacks to when updated.',
  `pinged` text COMMENT 'A list of URLs WordPress has sent pingbacks to when updated.',
  `post_modified` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'Time and date of last modification.',
  `post_modified_gmt` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'GMT time and date of last modification.',
  `post_content_filtered` longtext COMMENT 'Used by plugins to cache a version of post_content typically passed through the ‘the_content’ filter. Not used by WordPress core itself.',
  `post_parent` bigint(20) unsigned DEFAULT NULL COMMENT 'Used to create a relationship between this post and another when this post is a revision, attachment or another type.',
  `guid` varchar(255) DEFAULT NULL COMMENT 'Global Unique Identifier, the permanent URL to the post, not the permalink version.',
  `menu_order` int(11) DEFAULT NULL COMMENT 'Holds the display number for pages and other non-post types.',
  `post_type` varchar(20) DEFAULT NULL COMMENT 'The content type identifier.',
  `post_mime_type` varchar(100) DEFAULT NULL COMMENT 'Only used for attachments, the MIME type of the uploaded file.',
  `comment_count` bigint(20) DEFAULT NULL COMMENT 'Total number of comments, pingbacks and trackbacks.',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `record_size_in_kb` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`(191)),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `wp_posts_post_modified_index` (`post_modified`),
  KEY `idx_wp_posts_post_author_post_modified_deleted_at` (`post_author`,`post_modified`,`deleted_at`),
  CONSTRAINT `wp_posts_wp_users_ID_fk` FOREIGN KEY (`post_author`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=356270 DEFAULT CHARSET=utf8 COMMENT='Stores various types of content including posts, pages, menu items, media attachments and any custom post types.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_term_taxonomy`
--

DROP TABLE IF EXISTS `wp_term_taxonomy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_term_taxonomy` (
  `term_taxonomy_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique number assigned to each row of the table.',
  `term_id` bigint(20) unsigned DEFAULT NULL COMMENT 'The ID of the related term.',
  `taxonomy` varchar(32) DEFAULT NULL COMMENT 'The slug of the taxonomy. This can be the <a href="http://codex.wordpress.org/Taxonomies#Default_Taxonomies" target="_blank">built in taxonomies</a> or any taxonomy registered using <a href="http://codex.wordpress.org/Function_Reference/register_taxonomy" target="_blank">register_taxonomy()</a>.',
  `description` longtext COMMENT 'Description of the term in this taxonomy.',
  `parent` bigint(20) unsigned DEFAULT NULL COMMENT 'ID of a parent term. Used for hierarchical taxonomies like Categories.',
  `count` bigint(20) DEFAULT NULL COMMENT 'Number of post objects assigned the term for this taxonomy.',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`term_taxonomy_id`),
  UNIQUE KEY `term_id_taxonomy` (`term_id`,`taxonomy`),
  KEY `taxonomy` (`taxonomy`),
  CONSTRAINT `wp_term_taxonomy_wp_terms_term_id_fk` FOREIGN KEY (`term_id`) REFERENCES `wp_terms` (`term_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COMMENT='Terms that are stored in wp_terms don’t exist yet as a ‘Category’ and as ‘Tags’ unless they are given context. Each term is assigned a taxonomy using this table.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wp_terms`
--

DROP TABLE IF EXISTS `wp_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wp_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Unique number assigned to each term.',
  `name` varchar(200) DEFAULT NULL COMMENT 'The name of the term.',
  `slug` varchar(200) DEFAULT NULL COMMENT 'The URL friendly slug of the name.',
  `term_group` bigint(10) DEFAULT NULL COMMENT 'Ability for themes or plugins to group terms together to use aliases. Not populated by WordPress core itself.',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`term_id`),
  KEY `slug` (`slug`(191)),
  KEY `name` (`name`(191))
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COMMENT='Terms are items of a taxonomy used to classify objects. Terms allow items like posts and custom post types to be classified in various ways. For example, when creating a post, by default you can add a category and some tags to it. Both ‘Category’ and ‘Tag’ are examples of a <a href="http://codex.wordpress.org/Taxonomies" target="_blank">taxonomy</a>, basically a way to group things together.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'global_data'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-03 16:56:35
