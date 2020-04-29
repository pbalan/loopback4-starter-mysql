USE `lbstarter`;

UPDATE users set `password`= (select `password` from user_credentials as user_credentials where users.id = user_credentials.user_id);
ALTER TABLE users MODIFY COLUMN `password` VARCHAR(60) NOT NULL DEFAULT '';

ALTER TABLE user_credentials DROP FOREIGN KEY fk_user_credentials_users;
DROP TABLE IF EXISTS user_credentials;
