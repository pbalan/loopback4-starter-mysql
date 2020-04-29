USE `lbstarter`;

CREATE TABLE `user_credentials` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` bigint(20) unsigned NOT NULL COMMENT 'user id',
  `auth_provider` varchar(50) NOT NULL DEFAULT '' COMMENT 'auth provider',
  `auth_id` varchar(100) DEFAULT NULL COMMENT 'auth id',
  `auth_token` varchar(100) DEFAULT NULL COMMENT 'auth token',
  `created_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'created at',
  `modified_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'modified at',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1: deleted, 0: active',
  `password` varchar(60) NOT NULL COMMENT 'password',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_credentials_user_id` (`user_id`),
  KEY `idx_user_credentials` (`auth_provider`),
  CONSTRAINT `fk_user_credentials_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into user_credentials (user_id, auth_provider, `password`) select id, 'internal', password from users;

update auth_clients set redirect_url='http://localhost:4200/login/success' where client_id='webapp';
