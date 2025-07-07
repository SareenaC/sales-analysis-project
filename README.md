## Sales and Profit Analysis
### Project Overview

This project consists of a thorough analysis of data to uncover key insights into sales performance and profit generated from a fictional business-to-business that sells classic models of vehicles such as cars, trains and motorcycles. The dataset covers the years 2003 to 2005. The aim of the project is to inform decision-making, improve commercial success and provide valuable input for shaping the company’s business strategy.

**Targeted SQL queries regarding various business questions can be found** [here.](classicmodels_profit_sales.sql)

**The SQL queries used to clean, inspect and perform quality checks can be found** [here.](data_cleaning_checks.sql)

**An interactive Tableau dashboard can be viewed using the link:** https://public.tableau.com/app/profile/reena.c7771/viz/classicmodelsproject/Classicmodelsdashboard
### Data source and structure
The database used in this project is a sample MySQL database called ClassicModels which can be accessed from https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/

The database contains 8 tables with information about customers, employees, offices, orderdetails, orders, products, payments and productlines.

### Key insights
- £9.6M in revenue and £3.8M in profit is generated over 3 years. 
- Revenue and profit peak in October and November likely due to seasonal events like Black Friday, Christmas and New Year.
-	Top performing countries are USA, Spain and France; followed by Australia, New Zealand and the UK. 
-	In terms of product line performance, Classic cars generate 40.1% of total revenue, vintage cars: 18.7%, ships: 6.9%, trains: 2%.
-	Top 3 products by revenue and profit: 1992 Ferrari 360 Spider Red, 2001 Ferrari Enzo and 1952 Alpine Renault 1300 (classic cars)
- High profit is also generated from 2003 Harley-Davidson Eagle Drag Bike (motorcycle) and 1928 Mercedes-Benz SSK (vintage car)
-	Lowest performing products by revenue: 1939 Chevrolet Deluxe Coupe, 1936 Mercedes Benz 500k Roadster and 1982 Lamborghini Diablo.
- Lowest performing products by profit: 1939 Chevrolet Deluxe Coupe, Boeing X-32A JSF and 1982 Ducati 996 R. 
-	Customer revenue breakdown: 47.2% of total revenue comes from 25 high spend customers (Spending >£100K), 44.8% from 53 medium-spend customers (£50K-£100K) and 8% from 23 low-spend customers (<£50k).  

### Recommendations
- Consider introducing a tiered loyalty scheme to increase customer retention. The more customers spend, the better the rewards. 
- Use targeted marketing to encourage low-spend customers to purchase, such as email offers providing 10% discounts.
- Highlight top-performing models like the 1992 Ferrari 360 Spider Red or the 2003 Harley-Davidson Eagle Drag Bike Focus in social media campaigns to drive engagement and   sales. Focus on classic cars, vintage cars and motorcycles which are the highest selling. 
- Evaluate whether to discontinue underperforming products such as 1939 Chevrolet Deluxe Coupe.
- Increase marketing efforts in Australia, New Zealand and the UK to grow revenue and engage new customers.
- To increase revenue of trains and ships, consider expanding the product ranges which are limited with 3 and 9 products respectively. 
- Focus marketing and inventory around the peaks in October and November to maximise sales and profit. To reduce the dip in sales after this period, promotional campaigns and discounts can be introduced at the start of the year. 
-	Consider reducing stock levels of products generating a low profit and revenue, whilst increasing stock for high-demand products like the 1968 Ford Mustang which has generated a high revenue but is limited in availability. 


