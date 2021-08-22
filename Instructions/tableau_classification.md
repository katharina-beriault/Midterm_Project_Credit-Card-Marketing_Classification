# Tableau - Classification

In this part of the project you will work with the data set `creditcardmarketing.xlsx` use Tableau to answer the questions below. 

Create a visually appealing dashboard to represent the information.
        ***Some points to keep in mind while working on the tableau questions:***

a) The plots should be well labelled briefly describing the purpose of the plot
b) Select the chart type that produces an effective outcome for a given scenario
c) Focus audience attention on the most important data
d) Use space, color and fonts appropriately
e) Use correct title for the plots.
f) Utilize formatted tooltips and descriptive titles
g) Format the axes wherever necessary
h) Use caption to add details wherever necessary
i) Use appropriate level of details with labels and color coding etc.
j) For the dashboard make sure that the information represented is clear and easy to understand. The user of the dashboard should be able to understand the purpose of the dashboard and should be able to make decisions looking at the plots presented.
k) You can also use filters wherever appropriate to give the user the flexibility to view different information easily

**Tableau Questions:**

Make a separate sheet for every question: 

**1.**  Convert the necessary measures to dimensions  (the variables that are categorical in nature). When you use a separate sheet for this question, add a note in that sheet on which columns were changed.

**2.**  Check the imbalance in the dataset by looking at the number of people who accepted the offer vs. people who did not accept the offer. Add the counts as labels on the plots.

**3.**  Do a quick table calculation on the previous plot to check percentage of total for both _yes_ and _no_.

**4.**  Now we will try to analyze certain characteristics / the differences between the people who accepted the offer vs people who did not accept the offer. Use the same sheet for plots below.
    - Plot average Q1 balance vs Offer Accepted. Provide the values of averages as labels.
    - Plot average Q2 balance vs Offer Accepted. Provide the values of averages as labels.
    - Plot average Q3 balance vs Offer Accepted. Provide the values of averages as labels.
    - Plot average Q4 balance vs Offer Accepted. Provide the values of averages as labels.

**5.**  We saw all the four plots together on the same sheet. The plots should have the same format for numbers (number of decimal places here). Do you observe any trend here. Add a caption to provide the explanation
    - Now for all the plots, change the style of the plot from bar chart to a line chart. This could be used for a visual trend.

**6.**  Consider a similar analysis for Household Size vs average balances for each quarter. You would observe a huge jump in average balance from Q1 to Q2 for households with size 8.
    - Try and explain that jump. Hint: Check the number of records we have for such customers. Do you see any anomaly.


**7.**  Now we want to see how some of the other features In the data might have affected responses from the people. For these we will first start by creating a cross tab. A cross tab is simply a table between two categorical features with some metric of importance filling up the table.

    - Create a cross tab between Offer Accepted and Overdraft Protection and fill the table with number of records. Do you observe any trend here?
    - Create a cross tab between Offer Accepted and Mailer Type and fill the table with number of records. Do you observe any trend here?
    - Create a cross tab between Offer Accepted and Credit Rating and fill the table with number of records. Rearrange the column credit rating from low to high. Do you observe any trend here?

**8.**  Based on the average balance for each customer, create four buckets : Category A, Category B, Category C, and Category D. Category A is from min value to 700, 701 to 1400, 1400 to 1900, and 1900 to 3366. Check the number of observations for each of the categories.

