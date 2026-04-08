CREATE SCHEMA `citadel` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

CREATE USER 'citadel'@'localhost' IDENTIFIED BY 'citadel';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON juiceworks.* TO 'citadel'@'localhost';

-- Dev. MySQL on Digital Ocean-----
CREATE USER 'citadel'@'dev' IDENTIFIED BY 'citadel';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON juiceworks.* TO 'citadel'@'dev';

-- Production Environment on Digital Ocean-----
CREATE USER 'citadel'@'prod' IDENTIFIED BY 'citadel';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP ON citadel.* TO 'citadel'@'prod';