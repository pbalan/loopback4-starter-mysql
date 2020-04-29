CREATE TABLE `lbstarter`.`auth_clients` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `client_id` varchar(50) NOT NULL DEFAULT '' COMMENT 'client id',
  `client_secret` varchar(50) NOT NULL DEFAULT '' COMMENT 'client secret',
  `redirect_url` varchar(200) DEFAULT NULL COMMENT 'redirect url',
  `access_token_expiration` int(11) NOT NULL DEFAULT '900' COMMENT 'access token expiration',
  `refresh_token_expiration` int(11) NOT NULL DEFAULT '86400' COMMENT 'refresh token expiration',
  `auth_code_expiration` int(11) NOT NULL DEFAULT '180' COMMENT 'auth code expiration',
  `secret` varchar(50) NOT NULL DEFAULT '' COMMENT 'secret',
  `created_at` datetime NOT NULL COMMENT 'created at',
  `modified_at` datetime NOT NULL COMMENT 'modified at',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1: deleted, 0: active',
  `user_ids` json DEFAULT NULL COMMENT 'user ids',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

insert into lbstarter.auth_clients
  (client_id, client_secret, `secret`, created_at, modified_at, user_ids)
  values
  ('webapp','saqw21!@', 'plmnkoqazxsw', now(), now(), '[1]');
