# Midterm Project
## Credit Card Marketing | SQL, Python, Tableau

![photo](https://www.rd.com/wp-content/uploads/2018/04/creditcard-2.jpg)

---------------------------------------------------------------------------------------------------------

### Project goal

With this project I am applying everything what I have learned so far during my Data Analytics course.

**Setting** <br>
The imagined work environment for this project is a bank institute. Apart from the other banking and loan services, the bank provides credit card services which is a very important source of revenue for the bank. The bank wants to understand the demographics and other characteristics of its customers that accept a credit card offer and that do not accept a credit card. Usually the observational data for these kinds of problems is somewhat limited in that often the company sees only those who respond to an offer. To get around this, the bank designs a focused marketing study, with 18,000 current bank customers. This focused approach allows the bank to know who does and does not respond to the offer, and to use existing demographic data that is already available on each customer.

**Objective:** <br>
The goal of this project is to be able to predict if a credit card offer will be accepted by a specific customer or not based on specific variables. There are also other potential areas of opportunities that the bank wants to understand from the data.

---------------------------------------------------------------------------------------------------------

### Structure of the repository
This repository contains five folders:<br>
> **Data:** <br>
> Excel-file <br>
> CSV-file with the data which is being used for this project <br>
> **Instructions:** <br>
> Project instructions for the three different parts <br>
> **Python:**  <br>
> Jupyter notebook (ipynb-file) with data cleaning, analysis, model building <br>
> Python functions (py-file) with all self-built functions used for this project <br>
> 2 pickles saving information for two scaling techniques used on data (Normalizer, StandardScaler) <br>
> **SQL:** <br>
> SQL-file creation of the database and table <br>
> SQL-file with SQL-queries answering questions <br>
> **Tableau:** <br>
> README-file with screenshots of the visualizations <br>
> Tableau results (twb-file)

---------------------------------------------------------------------------------------------------------

### Project data

[**creditcardmarketing.csv**](https://github.com/katharina-beriault/Midterm_Project_Credit-Card-Marketing_Classification/blob/main/Data/creditcardmarketing.csv)

> 18000 rows and 17 columns

The data set provides information about:

|Columns |
|:--- |
| Customer Number | 
| Offer Accepted |
| Reward |
| Mailer Type |
| Income Level |
| Household Size   
| Owns a Home  | 
| Number of Homes Owned |
| Overdraft Protection |
| Number of Bank Accounts Owned |
| Number of Credit Cards Held  | 
| Credit Rating  |
| Average Balance  | 
| Balance Q1-Q4  |



---------------------------------------------------------------------------------------------------------

### Project workflow

1. **Agile Project Management via Kanban Board**
    - Self-managing my project via Kanban Board (Github *Projects*)
    - Using Kanban Board to save ressources and references

2. **Exploring the data with SQL**
    - Creating a database and table within SQL-Workbench
    - Writing the right queries to extract the information we need
    - Gaining first insights on the available data set

3. **Preparing the data with Python**
    - Connecting the SQL-database to Python
    - Pulling the data as a dataframe in python
    - Exploring the data (visually)
    - Performing data cleaning and data wrangling in Python
  
4.  **Performing Exploratory Data Analysis with Python** 
    - Fitting the models
    - Checking the accuracy of the models 
    - Iterating on the models to get more optimized results
  
5. **Presenting the results with Tableau** 
    - Producing documentation to make the project accessible
    - Building engaging presentations
    - Including storytelling to my presentation


---------------------------------------------------------------------------------------------------------


### Project outcome/results

**Business insights** 

Only around 6% of all customers accept the credit card offer while 94% of all customers decline the offer.

The average balanace of customers who accept the offer and those who don't accept, doesn't not differ.

! MORE TO COME !


**Classification model results**

The following models currently give us the best results:
> *Decision Tree model* (after DownSampling the data) : Accuracy of 0,653 and F1 of 0,23 <br>
>>DownSampling however is usually used as a technique with a lot larger data sets. The results of the model therefore might not be accurate.

If for future prediction we want to use a model which was trained and tested with the complete data set, we can used the following model which also has good overall scores:
> *Logistic Regression* (after adjusting Class Weights): Accuracy of 0,675 and F1 of 0,19 


**Future score of work**

Possible future improvements on the machine learning models could be:
- applying ordinal encoding to specific columns (e.g. 'income_level') instead of one hot encoding
- scaling only the numerical data and not the encoded categorical data
- trying other machine learning models (e.g. Random Forrest, Linear Discriminant Analysis, Gaussian Naive Bayes, Support Vector Machine)

---------------------------------------------------------------------------------------------------------
### Modules used for Python analysis

[pandas](https://pandas.pydata.org/)<br>
[numpy](https://numpy.org/doc/)<br>
[matplotlib.pyplot](https://matplotlib.org/3.1.1/contents.html)<br>
[seaborn](https://seaborn.pydata.org/)<br>
[sklearn](https://scikit-learn.org/stable/index.html)<br>
[statsmodels](https://www.statsmodels.org/stable/index.html)<br>
[pymysql](https://pypi.org/project/PyMySQL/)<br>
[scipy.stats](https://docs.scipy.org/doc/scipy/reference/stats.html)<br>
[scikitplot](https://pypi.org/project/scikit-plot/)<br>
[imblearn](https://pypi.org/project/imbalanced-learn/)<br>
[pickle](https://docs.python.org/3/library/pickle.html)<br>
