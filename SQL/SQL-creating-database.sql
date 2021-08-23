-- creating the database

CREATE DATABASE credit_card_classification;
SHOW DATABASES;

-- creating the table

USE credit_card_classification;

DROP TABLE IF EXISTS credit_card_data;
CREATE TABLE `credit_card_data` (
  `customer_number` INT NOT NULL AUTO_INCREMENT,
  `offer_accepted` ENUM('Yes','No') DEFAULT NULL,
  `reward` TEXT,
  `mailer_type` TEXT DEFAULT NULL,
  `income_level` TEXT DEFAULT NULL,
  `bank_accounts_open` INT DEFAULT NULL,
  `overdraft_protection` ENUM('Yes','No') DEFAULT NULL,
  `credit_rating` TEXT DEFAULT NULL,
  `credit_cards_held` INT DEFAULT NULL,
  `homes_owned` INT DEFAULT NULL,
  `household_size` INT DEFAULT NULL,
  `own_your_own_home` TEXT DEFAULT NULL,
  `average_balance` FLOAT DEFAULT NULL,
  `q1_balance` FLOAT DEFAULT NULL,
  `q2_balance` FLOAT DEFAULT NULL,
  `q3_balance` FLOAT DEFAULT NULL,
  `q4_balance` FLOAT DEFAULT NULL,
  PRIMARY KEY (`customer_number`)
);

SELECT * FROM credit_card_data;

SHOW VARIABLES LIKE 'local_infile'; 
SET GLOBAL local_infile = 1;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM credit_card_data;
LOAD DATA LOCAL INFILE './creditcardmarketing.csv' 
INTO TABLE credit_card_data
FIELDS TERMINATED BY ',';

SELECT * FROM credit_card_data;

-- dropping column 'Q4 Balance' from table

ALTER TABLE credit_card_data 
DROP COLUMN q4_balance;

SELECT *
FROM credit_card_data
LIMIT 10;

-- checking number of rows of the table

SELECT COUNT(*) AS 'number of rows'
FROM credit_card_data;
