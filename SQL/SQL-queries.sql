-- using the correct database

USE credit_card_classification;

-- Finding the unique values for different columns

-- What are the unique values in the column `Offer_accepted`? 
-- No, Yes
SELECT DISTINCT offer_accepted
FROM credit_card_data;

-- What are the unique values in the column `Reward`?
-- Air Miles, Cash Back, Points
SELECT DISTINCT reward
FROM credit_card_data;

-- What are the unique values in the column `mailer_type`?
-- Letter, Postcard
SELECT DISTINCT mailer_type
FROM credit_card_data;

-- What are the unique values in the column `credit_cards_held`?
-- 1, 2, 3, 4
SELECT DISTINCT credit_cards_held
FROM credit_card_data
ORDER BY 1;

-- What are the unique values in the column `household_size`?
-- 1, 2, 3, 4, 5, 6, 8, 9
SELECT DISTINCT household_size
FROM credit_card_data
ORDER BY 1;

-- Arrange the data in a decreasing order by the average_balance of the house.
-- Return only the customer_number of the top 10 customers with the highest average_balances in your data.

-- version 1:
SELECT customer_number, average_balance
FROM credit_card_data
ORDER BY average_balance DESC
LIMIT 10;

-- version 2: same results with a subquery+ranks
SELECT customer_number, average_balance FROM (
SELECT *, RANK() OVER(ORDER BY average_balance DESC) AS ranking
FROM credit_card_data
ORDER BY average_balance DESC) s1
WHERE ranking <= 10;

-- What is the average balance of all the customers in your data?
SELECT ROUND(SUM(average_balance)/COUNT(*), 2) AS avg_balance_total
FROM credit_card_data;

-- In this exercise we will use group by to check the properties of some of the categorical variables in our data. 
-- Note wherever average_balance is asked in the questions below, please take the average of the column average_balance:

-- What is the average balance of the customers grouped by `Income Level`? 
-- The returned result should have only two columns, income level and `Average balance` of the customers. 
-- Use an alias to change the name of the second column.

SELECT income_level, ROUND(SUM(average_balance)/COUNT(*), 2) AS avg_balance -- SUM(average_balance)/COUNT(*) = AVG(average_balance)
FROM credit_card_data
GROUP BY income_level;

-- What is the average balance of the customers grouped by `number_of_bank_accounts_open`? 
-- The returned result should have only two columns, `number_of_bank_accounts_open` and `Average balance` of the customers. 
-- Use an alias to change the name of the second column.

SELECT bank_accounts_open, ROUND(AVG(average_balance), 2) AS avg_balance
FROM credit_card_data
GROUP BY bank_accounts_open;

-- What is the average number of credit cards held by customers for each of the credit card ratings? 
-- The returned result should have only two columns, rating and average number of credit cards held. 
-- Use an alias to change the name of the second column.

SELECT credit_rating, ROUND(AVG(credit_cards_held), 3) AS avg_nbr_credit_cards_held
FROM credit_card_data
GROUP BY credit_rating;

-- Is there any correlation between the columns `credit_cards_held` and `number_of_bank_accounts_open`? 
-- You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
-- Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
-- You might also have to check the number of customers in each category (ie number of credit cards held) 
-- to assess if that category is well represented in the dataset to include it in your analysis. 
-- For eg. If the category is under-represented as compared to other categories, ignore that category in this analysis

-- very slight negative correlation
-- when the amount of credit cards increases, the average number of open bank accounts decreases
-- one category (4 credity cards held) is under-represented and was ignored for the analysis
SELECT credit_cards_held, AVG(bank_accounts_open) AS avg_nbr_bank_accounts_open, COUNT(*) AS nbr_customers
FROM credit_card_data
GROUP BY credit_cards_held
ORDER BY 1;

-- very subtle negative correlation 
-- when the number of bank accounts increases the average number of credit cards held decreases
-- one category is under-represented (3 open bank accounts) 
-- remaining categories are highly unbalanced as well
SELECT bank_accounts_open, AVG(credit_cards_held) AS avg_nbr_credit_cards_held, COUNT(*) AS nbr_customers
FROM credit_card_data
GROUP BY bank_accounts_open
ORDER BY 1;

-- Your managers are only interested in the customers with the following properties:

-- Credit rating medium or high

SELECT * 
FROM credit_card_data
WHERE credit_rating IN ('Medium', 'High');

--  Credit cards held 2 or less

SELECT * 
FROM credit_card_data
WHERE credit_cards_held <= 2;

-- Owns their own home

SELECT *
FROM credit_card_data
WHERE own_your_home = 'Yes';

-- Household size 3 or more

SELECT *
FROM credit_card_data
WHERE household_size >= 3;

-- For the rest of the things, they are not too concerned. 
-- Write a simple query to find what are the options available for them? 

SELECT *
FROM credit_card_data
WHERE credit_rating IN ('Medium', 'High')
AND credit_cards_held <= 2
AND own_your_home = 'Yes'
AND household_size >= 3;

-- Can you filter the customers who accepted the offers here?

SELECT * FROM (
SELECT *
FROM credit_card_data
WHERE credit_rating IN ('Medium', 'High')
AND credit_cards_held <= 2
AND own_your_home = 'Yes'
AND household_size >= 3) s1
WHERE offer_accepted = 'Yes';

-- Your managers want to find out the list of customers whose average balance is less than the average balance 
-- of all the customers in the database. 
-- Write a query to show them the list of such customers. 
-- You might need to use a subquery for this problem.

SELECT *
FROM credit_card_data
WHERE average_balance < (SELECT ROUND(AVG(average_balance), 2) AS avg_balance_total FROM credit_card_data);

-- Since this is something that the senior management is regularly interested in, 
-- create a view called Customers__Balance_View1 of the same query.

CREATE VIEW Customers__Balance_View1 AS 
SELECT *
FROM credit_card_data
WHERE average_balance < (SELECT ROUND(AVG(average_balance), 2) AS avg_balance_total FROM credit_card_data);


-- What is the number of people who accepted the offer vs number of people who did not?

-- no: 16.955, yes: 1021 (highly imbalanced, important to take into consideration for model!)
SELECT offer_accepted, COUNT(*) AS nbr_customers
FROM credit_card_data
GROUP BY offer_accepted;

-- Your managers are more interested in customers with a credit rating of high or medium. 
-- What is the difference in average balances of the customers with high credit card rating and low credit card rating?

-- average balance is higher for a low credit card rating than for a medium credit card rating (940.34 VS 936.75)
-- average balance is highest for a high credit card rating (944.39)
-- the average balance doesn't differ very much between all three credit card ratings
SELECT credit_rating, ROUND(AVG(average_balance), 2) AS avg_balance
FROM credit_card_data
GROUP BY credit_rating;

-- In the database, which all types of communication (mailer_type) were used and with how many customers?

-- Letter: 8842, Postcard:9134
SELECT mailer_type, COUNT(*) AS nbr_customers
FROM credit_card_data
GROUP BY mailer_type;

-- Provide the details of the customer that is the 11th least Q1_balance in your database.

-- dense_rank needed!
SELECT *, DENSE_RANK() OVER(ORDER BY q1_balance) AS ranking
FROM credit_card_data
ORDER BY q1_balance;

-- there are three customers with the 11th least Q1 balance
SELECT *
FROM (
SELECT *, DENSE_RANK() OVER(ORDER BY q1_balance) AS ranking
FROM credit_card_data) s1
WHERE ranking = 11;