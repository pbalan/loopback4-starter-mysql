DROP SCHEMA IF EXISTS lbstarter;
CREATE SCHEMA IF NOT EXISTS lbstarter;

USE `lbstarter`;

DROP TABLE IF EXISTS `lbstarter`.`migrations`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`migrations` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(191) NOT NULL DEFAULT '' COMMENT 'file name',
  `run_on` datetime NOT NULL COMMENT 'run on',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `lbstarter`.`users`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `first_name` varchar(191) NOT NULL DEFAULT '' COMMENT 'first name',
  `middle_name` varchar(191) DEFAULT NULL COMMENT 'middle name',
  `last_name` varchar(191) NOT NULL DEFAULT '' COMMENT 'last name',
  `username` varchar(191) NOT NULL DEFAULT '' COMMENT 'username',
  `password` varchar(191) NOT NULL COMMENT 'password',
  `email` varchar(191) NOT NULL DEFAULT '' COMMENT 'email',
  `mobile_number` varchar(18) DEFAULT NULL COMMENT 'mobile number',
  `created_at` datetime NOT NULL COMMENT 'created at',
  `modified_at` datetime DEFAULT NULL COMMENT 'modified at',
  `created_by` bigint(20) unsigned DEFAULT NULL COMMENT 'created by',
  `modified_by` bigint(20) unsigned DEFAULT NULL COMMENT 'modified by',
  `default_tenant` bigint(20) unsigned DEFAULT NULL COMMENT 'default tenant',
  `deleted` tinyint(1) DEFAULT '0' COMMENT '1: deleted, 0: active',
  `verified_email` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1: yes, 0: no',
  `verified_mobile_number` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1: yes, 0: no',
  `status` tinyint(11) NOT NULL DEFAULT '0' COMMENT '0: inactive, 1: active',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_users_username` (`username`),
  UNIQUE KEY `uniq_users_email` (`email`),
  UNIQUE KEY `uniq_users_mobile_number` (`mobile_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`languages`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`languages` (
  `id` varchar(2) NOT NULL DEFAULT 'en' COMMENT 'language code',
  `name` varchar(191) NOT NULL DEFAULT 'English' COMMENT 'language name',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_languages_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`roles`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'name',
  `created_at` datetime NOT NULL COMMENT 'created at',
  `modified_at` datetime DEFAULT NULL COMMENT 'modified at',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1: deleted, 0: active',
  `permissions` json DEFAULT NULL COMMENT 'permissions',
  `role_key` int(11) NOT NULL COMMENT 'role key',
  PRIMARY KEY (`id`),
  KEY `idx_roles_key` (`role_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`cities`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(191) NOT NULL DEFAULT '' COMMENT 'name',
  `lang` varchar(2) NOT NULL DEFAULT 'en' COMMENT 'language',
  `city_en_id` bigint(20) unsigned DEFAULT NULL COMMENT 'english city id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_city_name_lang` (`city_en_id`,`lang`,`name`),
  KEY `idx_cities_id_city_en_id` (`city_en_id`),
  KEY `lang` (`lang`),
  CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`city_en_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `cities_ibfk_2` FOREIGN KEY (`lang`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`countries`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`countries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(191) NOT NULL DEFAULT '' COMMENT 'name',
  `lang` varchar(2) NOT NULL DEFAULT 'en' COMMENT 'language',
  `country_en_id` bigint(20) unsigned DEFAULT NULL COMMENT 'english country id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_country_name_lang` (`country_en_id`,`name`,`lang`),
  KEY `idx_counties_id_country_en_id` (`country_en_id`),
  KEY `lang` (`lang`),
  CONSTRAINT `countries_ibfk_1` FOREIGN KEY (`country_en_id`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `countries_ibfk_2` FOREIGN KEY (`lang`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`states`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`states` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(191) NOT NULL DEFAULT '' COMMENT 'name',
  `lang` varchar(2) DEFAULT 'en' COMMENT 'language',
  `state_en_id` bigint(20) unsigned DEFAULT NULL COMMENT 'english state id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_state_name_lang` (`state_en_id`,`name`,`lang`),
  KEY `idx_states_id_state_en_id` (`state_en_id`),
  KEY `lang` (`lang`),
  CONSTRAINT `states_ibfk_1` FOREIGN KEY (`state_en_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `states_ibfk_2` FOREIGN KEY (`lang`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`country_states`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`country_states` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `country_en_id` bigint(20) unsigned NOT NULL COMMENT 'english country id',
  `state_en_id` bigint(20) unsigned NOT NULL COMMENT 'english state id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_country_state` (`country_en_id`,`state_en_id`),
  KEY `state_en_id` (`state_en_id`),
  CONSTRAINT `country_states_ibfk_1` FOREIGN KEY (`country_en_id`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `country_states_ibfk_2` FOREIGN KEY (`state_en_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

DROP TABLE IF EXISTS `lbstarter`.`state_cities`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`state_cities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `state_en_id` bigint(20) unsigned NOT NULL COMMENT 'english state id',
  `city_en_id` bigint(20) unsigned NOT NULL COMMENT 'english city id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_state_city` (`state_en_id`,`city_en_id`),
  KEY `city_en_id` (`city_en_id`),
  CONSTRAINT `state_cities_ibfk_1` FOREIGN KEY (`state_en_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `state_cities_ibfk_2` FOREIGN KEY (`city_en_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

DROP TABLE IF EXISTS `lbstarter`.`addresses`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`addresses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `address1` varchar(100) DEFAULT NULL COMMENT 'address 1',
  `address2` varchar(100) DEFAULT NULL COMMENT 'address 2',
  `address3` varchar(100) DEFAULT NULL COMMENT 'address 3',
  `address4` varchar(100) DEFAULT NULL COMMENT 'address 4',
  `city_id` bigint(20) unsigned DEFAULT NULL COMMENT 'city',
  `state_id` bigint(20) unsigned DEFAULT NULL COMMENT 'state',
  `country_id` bigint(20) unsigned DEFAULT NULL COMMENT 'country',
  `zip` varchar(20) DEFAULT NULL COMMENT 'zip',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'active:1, inactive:0',
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  KEY `country_id` (`country_id`),
  KEY `state_id` (`state_id`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `addresses_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `addresses_ibfk_3` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`tenants`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`tenants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) NOT NULL DEFAULT '' COMMENT 'name',
  `type` varchar(80) NOT NULL DEFAULT '' COMMENT 'type',
  `created_at` datetime NOT NULL COMMENT 'created at',
  `modified_at` datetime DEFAULT NULL COMMENT 'modified at',
  `created_by` bigint(20) unsigned NOT NULL COMMENT 'created by',
  `modified_by` bigint(20) unsigned DEFAULT NULL COMMENT 'modified by',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'deleted',
  `address_id` bigint(20) unsigned DEFAULT NULL COMMENT 'address',
  `status` varchar(50) DEFAULT 'active' COMMENT 'active, inactive, pending_confirmation, expired',
  PRIMARY KEY (`id`),
  KEY `created_by` (`created_by`),
  KEY `modified_by` (`modified_by`),
  KEY `address_id` (`address_id`),
  CONSTRAINT `tenants_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tenants_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `tenants_ibfk_3` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`user_tenants`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`user_tenants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'user id',
  `tenant_id` bigint(20) unsigned NOT NULL COMMENT 'tenant id',
  `created_at` datetime NOT NULL COMMENT 'created at',
  `modified_at` datetime DEFAULT NULL COMMENT 'modified at',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1: deleted, 0: active',
  `role_id` bigint(20) unsigned NOT NULL COMMENT 'role id',
  `status` varchar(50) NOT NULL DEFAULT 'active' COMMENT '1: active, 0: inactive, 2:pending_confirmation, 4: expired, 8: password_expired',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_tenants_user_id_tenant_id` (`user_id`,`tenant_id`),
  KEY `tenant_id` (`tenant_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_tenants_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_tenants_ibfk_2` FOREIGN KEY (`tenant_id`) REFERENCES `tenants` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_tenants_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `lbstarter`.`user_tenant_permissions`;

CREATE TABLE IF NOT EXISTS `lbstarter`.`user_tenant_permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_tenant_id` bigint(20) unsigned NOT NULL COMMENT 'user tenant id',
  `created_at` datetime NOT NULL COMMENT 'created at',
  `modified_at` datetime DEFAULT NULL COMMENT 'modified at',
  `created_by` bigint(20) unsigned NOT NULL COMMENT 'created by',
  `modified_by` bigint(20) unsigned DEFAULT NULL COMMENT 'modified by',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'deleted:1, active: 0',
  `permission` varchar(191) NOT NULL DEFAULT '' COMMENT 'permission',
  `allowed` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'allow:1, deny: 0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_user_tenant_id_permission` (`user_tenant_id`,`permission`),
  KEY `idx_user_tenant_permssions_created_by` (`created_by`),
  KEY `idx_user_tenant_permssions_modified_by` (`modified_by`),
  CONSTRAINT `user_tenant_permissions_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_tenant_permissions_ibfk_2` FOREIGN KEY (`modified_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_tenant_permissions_ibfk_3` FOREIGN KEY (`user_tenant_id`) REFERENCES `user_tenants` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP SCHEMA IF EXISTS `audit_db`;
CREATE SCHEMA `audit_db`;

DROP TABLE IF EXISTS `audit_db`.`audit_logs`;

CREATE TABLE IF NOT EXISTS `audit_db`.`audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `operation_name` varchar(10) NOT NULL DEFAULT '' COMMENT 'operation name',
  `operation_time` datetime NOT NULL COMMENT 'operation time',
  `table_name` varchar(60) NOT NULL DEFAULT '' COMMENT 'table name',
  `log_type` varchar(100) NOT NULL DEFAULT 'APPLICATION_LOGS' COMMENT 'log type',
  `entity_id` bigint(20) NOT NULL COMMENT 'entity id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'user id',
  PRIMARY KEY (`id`),
  KEY `idx_audit_logs_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
