# Results of SQL-Queries

## Question 6
Use sql query to find how many rows of data you have.

>SELECT COUNT(*) AS 'number of rows' <br>
>FROM credit_card_data;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.6.JPG)

## Question 7
Now we will try to find the unique values in some of the categorical columns:

- What are the unique values in the column `Offer_accepted`?

>SELECT DISTINCT offer_accepted <br>
>FROM credit_card_data;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.7.1.JPG)

- What are the unique values in the column `Reward`?

>SELECT DISTINCT reward <br>
>FROM credit_card_data;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.7.2.JPG)

- What are the unique values in the column `mailer_type`?

>SELECT DISTINCT mailer_type<br>
>FROM credit_card_data;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.7.3.JPG)

- What are the unique values in the column `credit_cards_held`?

>SELECT DISTINCT credit_cards_held<br>
>FROM credit_card_data<br>
>ORDER BY 1;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.7.4.JPG)

- What are the unique values in the column `household_size`?

>SELECT DISTINCT household_size<br>
>FROM credit_card_data<br>
>ORDER BY 1;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.7.5.JPG)

## Question 8
Arrange the data in a decreasing order by the average_balance of the house. Return only the customer_number of the top 10 customers with the highest average_balances in your data.

- version 1:
>SELECT customer_number, average_balance<br>
>FROM credit_card_data<br>
>ORDER BY average_balance DESC<br>
>LIMIT 10;

- version 2: same results with a subquery+ranks
>SELECT customer_number, average_balance FROM (<br>
>SELECT *, RANK() OVER(ORDER BY average_balance DESC) AS ranking<br>
>FROM credit_card_data<br>
>ORDER BY average_balance DESC) s1<br>
>WHERE ranking <= 10;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.8.JPG)

## Question 9
What is the average balance of all the customers in your data?

>SELECT ROUND(SUM(average_balance)/COUNT(*), 2) AS avg_balance_total<br>
>FROM credit_card_data;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.9.JPG)

## Question 10
In this exercise we will use group by to check the properties of some of the categorical variables in our data. Note wherever average_balance is asked in the questions below, please take the average of the column average_balance:

- What is the average balance of the customers grouped by `Income Level`? The returned result should have only two columns, income level and `Average balance` of the customers. Use an alias to change the name of the second column.

>SELECT income_level, ROUND(SUM(average_balance)/COUNT(*), 2) AS avg_balance -- SUM(average_balance)/COUNT(*) = AVG(average_balance)<br>
>FROM credit_card_data<br>
>GROUP BY income_level;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.10.1.JPG)

- What is the average balance of the customers grouped by `number_of_bank_accounts_open`? The returned result should have only two columns, `number_of_bank_accounts_open` and `Average balance` of the customers. Use an alias to change the name of the second column.

>SELECT bank_accounts_open, ROUND(AVG(average_balance), 2) AS avg_balance<br>
>FROM credit_card_data<br>
>GROUP BY bank_accounts_open;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.10.2.JPG)

- What is the average number of credit cards held by customers for each of the credit card ratings? The returned result should have only two columns, rating and average number of credit cards held. Use an alias to change the name of the second column.

>SELECT credit_rating, ROUND(AVG(credit_cards_held), 3) AS avg_nbr_credit_cards_held<br>
>FROM credit_card_data<br>
>GROUP BY credit_rating;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.10.3.JPG)

- Is there any correlation between the columns `credit_cards_held` and `number_of_bank_accounts_open`? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

You might also have to check the number of customers in each category (ie number of credit cards held) to assess if that category is well represented in the dataset to include it in your analysis. For eg. If the category is under-represented as compared to other categories, ignore that category in this analysis

>SELECT credit_cards_held, AVG(bank_accounts_open) AS avg_nbr_bank_accounts_open, COUNT(*) AS nbr_customers<br>
>FROM credit_card_data<br>
>GROUP BY credit_cards_held<br>
>ORDER BY 1;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.11.1.JPG)

There is a very slight negative correlation. When the amount of credit cards increases, the average number of open bank accounts decreases. One category (4 credity cards held) is under-represented and was ignored for the analysis

>SELECT bank_accounts_open, AVG(credit_cards_held) AS avg_nbr_credit_cards_held, COUNT(*) AS nbr_customers<br>
>FROM credit_card_data<br>
>GROUP BY bank_accounts_open<br>
>ORDER BY 1;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.11.2.JPG)

There is a very subtle negative correlation. When the number of bank accounts increases the average number of credit cards held decreases. One category is under-represented (3 open bank accounts). The remaining categories are highly imbalanced as well.


## Question 11
Your managers are only interested in the customers with the following properties:

- Credit rating medium or high

>SELECT * <br>
>FROM credit_card_data<br>
>WHERE credit_rating IN ('Medium', 'High');

- Credit cards held 2 or less

>SELECT * <br>
>FROM credit_card_data<br>
>WHERE credit_cards_held <= 2;

- Owns their own home

>SELECT *<br>
>FROM credit_card_data<br>
>WHERE own_your_home = 'Yes';

- Household size 3 or more

>SELECT *<br>
>FROM credit_card_data<br>
>WHERE household_size >= 3;

For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them? 

>SELECT *<br>
>FROM credit_card_data<br>
>WHERE credit_rating IN ('Medium', 'High')<br>
>AND credit_cards_held <= 2<br>
>AND own_your_home = 'Yes'<br>
>AND household_size >= 3;

Can you filter the customers who accepted the offers here?

>SELECT * FROM (<br>
>SELECT *<br>
>FROM credit_card_data<br>
>WHERE credit_rating IN ('Medium', 'High')<br>
>AND credit_cards_held <= 2<br>
>AND own_your_home = 'Yes'<br>
>AND household_size >= 3) s1<br>
>WHERE offer_accepted = 'Yes';


## Question 12
Your managers want to find out the list of customers whose average balance is less than the average balance of all the customers in the database. Write a query to show them the list of such customers. You might need to use a subquery for this problem.

>SELECT *<br>
>FROM credit_card_data<br>
>WHERE average_balance < (SELECT ROUND(AVG(average_balance), 2) AS avg_balance_total FROM credit_card_data);


## Question 13
Since this is something that the senior management is regularly interested in, create a view called Customers__Balance_View1 of the same query.

>CREATE VIEW Customers__Balance_View1 AS <br>
>SELECT *<br>
>FROM credit_card_data<br>
>WHERE average_balance < (SELECT ROUND(AVG(average_balance), 2) AS avg_balance_total FROM credit_card_data);


## Question 14
What is the number of people who accepted the offer vs number of people who did not?

>SELECT offer_accepted, COUNT(*) AS nbr_customers<br>
>FROM credit_card_data<br>
>GROUP BY offer_accepted;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.14.JPG)

The target variable is highly imbalanced, which will be important to take into consideration for model!

## Question 15
Your managers are more interested in customers with a credit rating of high or medium. What is the difference in average balances of the customers with high credit card rating and low credit card rating?

>SELECT credit_rating, ROUND(AVG(average_balance), 2) AS avg_balance<br>
>FROM credit_card_data<br>
>GROUP BY credit_rating;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.15.JPG)

The average balance is higher for a low credit card rating than for a medium credit card rating (940.34 VS 936.75).
The average balance is highest for a high credit card rating (944.39). However, the average balance doesn't differ very much between all three credit card ratings

## Question 16
In the database, which all types of communication (mailer_type) were used and with how many customers?

>SELECT mailer_type, COUNT(*) AS nbr_customers<br>
>FROM credit_card_data<br>
>GROUP BY mailer_type;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.16.JPG)

## Question 17
Provide the details of the customer that is the 11th least Q1_balance in your database.

>SELECT *<br>
>FROM (<br>
>SELECT *, DENSE_RANK() OVER(ORDER BY q1_balance) AS ranking<br>
>FROM credit_card_data) s1<br>
>WHERE ranking = 11;

![photo](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/SQL/Screenshots/qu.17.JPG)

There are three customers with the 11th least Q1 balance!
