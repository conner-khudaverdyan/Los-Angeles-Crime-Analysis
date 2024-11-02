import pandas as pd


# Assign columns to extract from file 
use_columns = [
    'DR_NO', 'Date Rptd', 'DATE OCC', 'TIME OCC', 'AREA NAME',
    'Part 1-2', 'Crm Cd', 'Crm Cd Desc', 'Vict Age',
    'Vict Sex', 'Vict Descent', 'Weapon Desc', 'Status Desc', 'LAT', 'LON'
]
csv_file = '/Users/connerkhudaverdyan/Desktop/Projects/Crime_Project/data/Crime_Data_from_2020_to_Present_20241013.csv'

# Read the CSV into a DataFrame
df = pd.read_csv(csv_file, usecols=use_columns)

# Clean column names
df.columns = df.columns.str.strip()
df.columns = df.columns.str.replace(' ', '_')
df.rename(columns={'Part_1-2': 'Part_1_2'}, inplace=True)

# Function to categorize crime
def categorize_crime(crime_description):
    # Specific category mappings
    property_crimes = {
        'Vehicle Theft': ['VEHICLE - STOLEN', 'VEHICLE, STOLEN', 'BIKE - STOLEN', 'BOAT - STOLEN', 'THEFT FROM MOTOR VEHICLE', 'VEHICLE - ATTEMPT STOLEN'],
        'Burglary': ['BURGLARY', 'BURGLARY FROM VEHICLE', 'BURGLARY, ATTEMPTED', 'BURGLARY FROM VEHICLE, ATTEMPTED'],
        'Theft': ['THEFT', 'PICKPOCKET','SHOPLIFTING', 'EMBEZZLEMENT', 'GRAND THEFT', 'PETTY THEFT', 'THEFT OF IDENTITY'],
        'Vandalism': ['VANDALISM', 'GRAFFITI', 'ARSON']
    }

    violent_crimes = {
        'Assault': ['ASSAULT', 'BATTERY', 'CRIMINAL HOMICIDE', 'CHILD ABUSE', 'BATTERY - SIMPLE ASSAULT', 'ASSAULT WITH DEADLY WEAPON'],
        'Robbery': ['ROBBERY', 'ATTEMPTED ROBBERY'],
        'Weapons': ['BRANDISH WEAPON', 'DISCHARGE FIREARMS', 'SHOTS FIRED', 'FIREARMS']
    }

    sexual_crimes = {
        'Sexual Offenses': ['RAPE', 'LEWD', 'INDECENT EXPOSURE', 'SODOMY/SEXUAL CONTACT', 'SEXUAL PENETRATION', 'PIMPING', 'PANDERING', 'ORAL', 'SEX']
    }

    fraud_crimes = {
        'Fraud': ['THEFT OF IDENTITY', 'EMBEZZLEMENT', 'COUNTERFEIT', 'FRAUD', 'EXTORTION', 'BUNCO', 'FORGERY']
    }

    public_order_crimes = {
        'Public Order': ['COURT','TRESPASSING', 'CONSPIRACY', 'LYNCHING', 'DISORDERLY CONDUCT', 'DISTURBING THE PEACE', 'INCITING RIOT', 'THREAT', 'RESTRAINING']
    }
    
    # Check in Property Crimes
    for category, crimes in property_crimes.items():
        if any(crime in crime_description for crime in crimes):
            return pd.Series({"Main_Category": "Property_Crime", "Sub_Category": category})
    
    # Check in Violent Crimes
    for category, crimes in violent_crimes.items():
        if any(crime in crime_description for crime in crimes):
            return pd.Series({"Main_Category": "Violent_Crime", "Sub_Category": category})
    
    # Check in Sexual Crimes
    for category, crimes in sexual_crimes.items():
        if any(crime in crime_description for crime in crimes):
            return pd.Series({"Main_Category": "Sexual_Crime", "Sub_Category": category})
    
    # Check in Fraud Crimes
    for category, crimes in fraud_crimes.items():
        if any(crime in crime_description for crime in crimes):
            return pd.Series({"Main_Category": "Fraud_Crime", "Sub_Category": category})
    
    # Check in Public Order Crimes
    for category, crimes in public_order_crimes.items():
        if any(crime in crime_description for crime in crimes):
            return pd.Series({"Main_Category": "Public_Order_Crime", "Sub_Category": category})
    
    # If no matches, categorize as 'Other'
    return pd.Series({"Main_Category": "Other", "Sub_Category": "Other"})


# Apply the categorization to the 'Crm_Cd_Desc' column
categories = df['Crm_Cd_Desc'].apply(categorize_crime)

# Concatenate the original dataframe and the categories
df = pd.concat([df, categories], axis=1)

# Make column names lowercase
df.columns = df.columns.str.lower()

# Convert the date columns to the desired format
df['date_rptd'] = pd.to_datetime(df['date_rptd'], format='%m/%d/%Y %I:%M:%S %p').dt.strftime('%Y-%m-%d')
df['date_occ'] = pd.to_datetime(df['date_occ'], format='%m/%d/%Y %I:%M:%S %p').dt.strftime('%Y-%m-%d')


# Function to convert military time to HH:MM format for Postgres SQL TIME format
def clean_time_format(military_time):
    # Convert the integer to a string, ensuring it's 4 digits
    military_str = f"{military_time:04}"
    # Format the string as HH:MM
    return f"{military_str[:2]}:{military_str[2:]}"

# Apply the conversion function
df['time_occ'] = df['time_occ'].apply(clean_time_format)

# Save processed csv file to data directory
df.to_csv('data/crime_data_processed.csv', index=False)

print('Successfully exported processed crime data')
