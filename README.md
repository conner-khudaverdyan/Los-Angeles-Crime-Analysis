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
In this section I will provide some patterns and insights I found using Tableau and the dashboard I created. For simplicity, the visualizations are generated on the entire dataset, so if you would like to see them for a given area or set of areas, refer to the dashboard link from earlier or downloaded the workbook yourself from the repository.

#### Victim Age 
<img src="images/victim_age_screenshot.png" alt="Dashboard Preview" width="500" />

- Here we can see the distribution of victim ages form a bimodal distribution, the two peaks being age 30 and 50. One possible cause of this could be population density. Looking at the [following article](https://www.neilsberg.com/insights/los-angeles-county-ca-population-by-age), in figure 1, we observe one peak at age 25-39  and the essence of a peak around 45-54, similar to the distribution of victim ages pictured above.
  
- Additionally, it  seems the 25-39 range has an even larger peak in victima ages, which makes sense since that age group is likely the most active in Los Angeles because of a combination of youth, work, and financial independence.
- It seems that victims are much more likely to be victims of crime once they become 18 years old
- There are two unual spikes at age 35 and 50, but after further investigation I found that in some areas the police department logged most of their crimes for those two ages specifically. This is likely because in data entry, those departments choose to estimate the victim age rather than input victims' exact ages.

#### Victim Sex

- Note that in the dataset, male and female are the only defined factors for victim sex. There was an 'unknown' factor, but it was amibiguous what this encompassed so I excluded it from the dashboard
  
<img src="images/victim_sex_screenshot.png" alt="Dashboard Preview" width="500" />


- Men make up a significant proportion of victims in both property and violent crimes. This trend may stem from social perceptions that frame men as tougher abd  'fair game', potentially leading criminals to target them more frequently. However, there are notable exceptions. In cases of intimate partner violence, women are more frequently targeted, highlighting how patterns of victimization can vary based on the relationship context. Identity theft also stands out as an exception in property crimes, where gender differences are less pronounced and the crime is less phyiscally confrontational.
  
- The only areas that had a majority of female victims were 77th street and Southeast
  
- Nearly all sexual crimes overwhelmingly affect female victims, with women comprising up to 99% of victims in some cases. 

#### Victim Descent

- Analyzing data on victims' ethnic backgrounds requires careful ethical and contextual consideration, so I will be breif in this section
  
<img src="images/victim_descent_screenshot.png" alt="Dashboard Preview" width="500" />

- Crime volume varies substantially across different ethnic backgrounds in each area, likely reflecting the population demographics within those regions.
- The proportion of white victims in violent crime is significantly lower than the other crime types. Upon further investigation, I found that this was consistent across most areas as well. 
- Property crime seems to have the most balanced distribution amongst the victim descents
## Setup Overview 
1. Preprocess Data:
   
  Run data_preprocessing.py to clean and format the raw CSV files. Make sure you have the csv file downloaded and stored in data subdirectory.

2. Set Up Database:
   
  Set up PostgreSQL connection, then execute the SQL script database_setup.sql to create and populate tables

3. Visualization:

  Connect to database and create dashboard in Tableau to find/extract desired insights and analysis. When complete, upload to Tableau public to make accessible for others to see and interact with dashboard.
