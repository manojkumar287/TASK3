ECOMMERCE Database TASK

This FILE is all about setting up and playing around with an ECOMMERCE database using SQL.  I designed it to hold key info about customers, what products are sold, and the details of customer orders.

 What's in the Database?

The database has these tables:
 **Customers:** Basic customer details like name, email, and location.
 **Products:** Information on the products we sell, including category and price.
 **Orders:** Records of customer orders, linking them to customers and showing the total amount.
 **OrderDetails:** The specifics of what was in each order (which products, how many, prices).

 What I Did with SQL

I used SQL to do a bunch of things:

 **Added Data:** I put sample data into the tables, including customer info with names like Manoj and Vishal, and RANDOM emails.
 **Ran Queries:** I asked the database questions like:
     "Show me customers from Hyderabad."
     "List products from cheapest to most expensive."
     "How much did each customer spend?"
 **Combined Data:** I used joins to combine info from different tables (e.g., to see which customer placed which order).
 **Advanced Queries:** I used more complex queries to find things like products that cost more than average, and which customers have actually placed orders.
 **Calculations:** I calculated things like total sales revenue and average order value.
 **Views:** I created "views" to make it easier to see order history and product sales summaries.
 **Optimization:** I added an index to speed up order-related queries, and showed how another index could improve location-based searches.

## How to Use This

1.  **Set up the Database:** Create a database named "ECOMMERCE" in MySQL .
2.  **Load the Data:** Run the provided SQL script to create the tables and fill them with data.
3.  **Run Queries:** You can then use SQL queries to explore and analyze the data.

## TASK Goal

The main goal was to show how SQL is used to manage and analyze data in a typical online store setup. We covered essential SQL skills like retrieving, filtering, sorting, combining, and summarizing data, plus some database optimization.
