-- creating the database

CREATE DATABASE credit_card_classification;
SHOW DATABASES;

-- creating the table

USE credit_card_classification;

DROP TABLE IF EXISTS credit_card_data;
CREATE TABLE `credit_card_data` (
  `Customer_Number` INT NOT NULL AUTO_INCREMENT,
  `Offer_Accepted` ENUM('Yes','No') DEFAULT NULL,
  `Reward` TEXT,
  `Mailer_Type` TEXT DEFAULT NULL,
  `Income_Level` TEXT DEFAULT NULL,
  `#_Bank_Accounts_Open` INT DEFAULT NULL,
  `Overdraft_Protection` ENUM('Yes','No') DEFAULT NULL,
  `Credit_Rating` TEXT DEFAULT NULL,
  `#_Credit_Cards_Held` INT DEFAULT NULL,
  `#_Homes_Owned` INT DEFAULT NULL,
  `Household_Size` INT DEFAULT NULL,
  `Own_Your_Own_Home` TEXT DEFAULT NULL,
  `Average_Balance` FLOAT DEFAULT NULL,
  `Q1_Balance` FLOAT DEFAULT NULL,
  `Q2_Balance` FLOAT DEFAULT NULL,
  `Q3_Balance` FLOAT DEFAULT NULL,
  `Q4_Balance` FLOAT DEFAULT NULL,
  PRIMARY KEY (`Customer_Number`)
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
