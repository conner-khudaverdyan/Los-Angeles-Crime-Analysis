# Los-Angeles-Crime-Analysis

## Project Overview
In this project I used Python, PostgreSQL and Tableau to analyze and visualize  geographic and demographic trends in Los Angeles crime data. For those who own Tableau Desktop, the final dashboard that illustrates the relationship between crime types, location, and victim demographics such as age, descent, and sex can be found as a packaged workbook file in the repositroy. The dashboard is also easily accessible on Tableau Public through the following link: [crime_dashboard](https://public.tableau.com/views/crime_book/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

Here is a preview of the dashboard: 

<img src="images/dashboard_screenshot.png" alt="Dashboard Preview" width="700" />


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
- Building an interactive Tableau dashboard linked to the PostgreSQL database to visualize trends and insights
- Utilizing Tableau's actions feature to produce visualizations of victim demographics and crime types for specific areas in los angeles by manually selecting them in the dashboard UI

## Analysis 

### General Analysis for Los Angeles as a whole

#### Victim Age 
<img src="images/victim_age_screenshot.png" alt="Dashboard Preview" width="500" />

- Here we can see the distribution of victim ages form a bimodal distribution, the two peaks being age 30 and 50. One possible cause of this could be population density. Looking at the [following article](https://www.neilsberg.com/insights/los-angeles-county-ca-population-by-age), in figure 1, we observe one peak at age 25-39  and the essence of a peak around 45-54, similar to the distribution of victim ages pictured above.
  
- Additionally, it  seems the 25-39 range has an even larger peak in victima ages, which makes sense since that age group is likely the most active in Los Angeles because of a combination of youth, work, and financial independence.
- It seems that victims are much more likely to be victims of crime once they become 18 years old
- There are two unual spikes at age 35 and 50, but after further investigation I found that in some areas the police department logged most of their crimes for those two ages specifically. This is likely because in data entry, those departments choose to estimate the victim age rather than input victims' exact ages.

#### Victim Sex

- Note that in the dataset, male and female are the only defined factors for victim sex. There was an 'unknown' factor, but it was amibiguous what this encompassed so I excluded it from the dashboard
  
<img src="images/victim_sex_screenshot.png" alt="Dashboard Preview" width="500" />


- Victims of property and violent crimes are mostly men. One possible reason for this is that men are seen as 'less delicate', so criminals are more likely to be violent or steal from them over women, possibly  out of good consiousness. The ony exception for violent crimes is assault between intimate partners; interestingly, this consiousness is abscent when the women is someone close to you. The exception for property crime was identity theft.
  
- The only areas that had a majority of female victims were 77th street and Southeast.
  
- All of the sexual crimes were majority female victims (up to 99%)  besides sodomy, which had 50%.

#### Victim Descent

<img src="images/victim_descent_screenshot.png" alt="Dashboard Preview" width="500" />

- Analying descent in crime can be seen as questionable ethically, so I for this section I will be brief for this section.
- Crime volume for each victim descent seems to very largely between each area, most likely due to population of each descent for any given area
- The proportion of white victims in violent crime is significantly lower than the other crime types
- Property crime seems to have the most balanced distribution amongst the victim descents
## Setup Overview 
1. Preprocess Data:
   
  Run data_preprocessing.py to clean and format the raw CSV files. Make sure you have the csv file downloaded and stored in data subdirectory.

2. Set Up Database:
   
  Set up PostgreSQL connection, then execute the SQL script database_setup.sql to create and populate tables

3. Visualization:

  Connect to database and create dashboard in Tableau to find/extract desired insights and analysis. When complete, upload to Tableau public to make accessible for others to see and interact with dashboard.
