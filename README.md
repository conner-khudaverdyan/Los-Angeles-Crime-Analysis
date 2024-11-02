# Los-Angeles-Crime-Analysis

## Project Overview
In this project I used Python, PostgreSQL and Tableau to analyze and visualize  geographic and demographic trends in Los Angeles crime data. For those who own Tableau Desktop, the final dashboard that illustrates the relationship between crime types, location, and victim demographics such as age, descent, and sex can be found as a packaged workbook file in the repositroy. The dashboard is also easily accessible on Tableau Public through the following link: [crime_dashboard](https://public.tableau.com/views/crime_book/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

#### Data Sources: 
- Crime data is downloaded directly from LA county's data website: [la crime data](https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-Present/2nrs-mtv8/about_data)
- Because of the size of the csv file, I could not directly store the raw data in the repository, but it can be downloaded by anyone using the link above

#### Data Preprocessing and Initial Exploration (Python): 
- Using python notebook to assess quality of data and choose features to use in final database
- Initial data cleaning and structuring using Python on raw CSV files.
- Implementation of function to categorize over 150 different crimes into more general labels such as violent, property, etc
#### Database Transformation (PostgreSQL): 
- Further data processing and wrangling using SQL scripts
- Setting up final relational database with PostgreSQL for efficient querying and easy integration with Tableau
#### Visualization (Tableau): 
- Building an interactive Tableau dashboard linked to the PostgreSQL database to visualize trends and insights.

## Analysis

## Setup Overview 
1. Preprocess Data:
   
  Run data_preprocessing.py to clean and format the raw CSV files. Make sure you have the csv file downloaded and stored in data subdirectory.

2. Set Up Database:
   
  Set up PostgreSQL connection, then execute the SQL script database_setup.sql to create and populate tables

3. Visualization:

  Connect to database and create dashboard in Tableau to find/extract desired insights and analysis. When complete, upload to Tableau public to make accessible for others to see and interact with dashboard.
