-- 1. Create a temporary table to import data from csv file
CREATE TEMPORARY TABLE crime_data (
    dr_no VARCHAR(20) PRIMARY KEY,               -- Division of Records Number
    date_rptd DATE NOT NULL,                	 -- Date Reported
    date_occ DATE NOT NULL,                 	 -- Date Occurred
    time_occ TIME NOT NULL,                      -- Time Occurred
    area_name VARCHAR(50) NOT NULL,            	 -- Area Name
    part_1_2 VARCHAR(10),                        -- Part 1-2 (Crime Category)
    crm_cd VARCHAR(10) NOT NULL,                 -- Crime Code
    crm_cd_desc VARCHAR(255) NOT NULL,           -- Crime Code Description
    vict_age INT,                           	 -- Victim Age (2 characters)
    vict_sex CHAR(1), 							 -- Victim Sex
    vict_descent CHAR(1),						 -- Victim Descent
    weapon_desc VARCHAR(50),                     -- Weapon Description
    status_desc VARCHAR(50),                      -- Status Description
    lat DECIMAL(9,6),                            -- Latitude
    lon DECIMAL(9,6),                            -- Longitude
    main_category VARCHAR(20), 					 -- Main Cateogorized Desription of Crime
    sub_category VARCHAR(20) 			 		 -- Sub Cateogorized Desription of Crime
);


COPY crime_data
FROM '/Users/connerkhudaverdyan/Desktop/Projects/Crime_Project/data/crime_data_processed.csv'
DELIMITER ','
CSV HEADER;


-- 2. Create the `vict_descent_info` table that will contain the general category of each descent for easy reference
CREATE TABLE IF NOT EXISTS vict_descent_info (
    vict_descent text primary key,
    vict_descent_general text,
    vict_descent_specific text
);

-- Populate the `vict_descent_info` table using the CASE statement and the data from crime_data
INSERT
	INTO
	vict_descent_info (vict_descent,
	vict_descent_general,
	vict_descent_specific)
SELECT
	DISTINCT 
    vict_descent,
	-- General Description of Victim Descent
    CASE
        WHEN Vict_Descent IN ('A', 'C', 'D', 'F', 'J', 'K', 'L', 'V', 'Z') THEN 'Asian'
        WHEN Vict_Descent = 'H' THEN 'Hispanic/Latin/Mexican'
        WHEN Vict_Descent = 'B' THEN 'Black'
        WHEN Vict_Descent = 'W' THEN 'White'
        WHEN Vict_Descent IN ('-','X') THEN 'Unknown'
        ELSE 'Other'
	END AS vict_descent_general,
	-- Exact Description of Victim Descent
    CASE
		WHEN Vict_Descent = 'A' THEN 'Other Asian'
		WHEN Vict_Descent = 'B' THEN 'Black'
		WHEN Vict_Descent = 'C' THEN 'Chinese'
		WHEN Vict_Descent = 'D' THEN 'Cambodian'
		WHEN Vict_Descent = 'F' THEN 'Filipino'
		WHEN Vict_Descent = 'G' THEN 'Guamanian'
		WHEN Vict_Descent = 'H' THEN 'Hispanic/Latin/Mexican'
		WHEN Vict_Descent = 'I' THEN 'American Indian/Alaskan Native'
		WHEN Vict_Descent = 'J' THEN 'Japanese'
		WHEN Vict_Descent = 'K' THEN 'Korean'
		WHEN Vict_Descent = 'L' THEN 'Laotian'
		WHEN Vict_Descent = 'O' THEN 'Other'
		WHEN Vict_Descent = 'P' THEN 'Pacific Islander'
		WHEN Vict_Descent = 'S' THEN 'Samoan'
		WHEN Vict_Descent = 'U' THEN 'Hawaiian'
		WHEN Vict_Descent = 'V' THEN 'Vietnamese'
		WHEN Vict_Descent = 'W' THEN 'White'
		WHEN Vict_Descent = 'Z' THEN 'Asian Indian'
		ELSE 'Other/Unknown'
	END AS vict_descent_specific
FROM
	crime_data
WHERE
	Vict_Descent IS NOT NULL			-- Exclude NULL values
ON
	CONFLICT (Vict_Descent) DO NOTHING; -- Avoids duplicate entries if the script is re-run


-- 3. Create area_info table that will contain the lat and lon of each area
CREATE TABLE IF NOT EXISTS area_coordinates (
	area_name TEXT PRIMARY KEY,
	area_lat DECIMAL(9,6),
	area_lon DECIMAL(9,6)
);

-- Insert distinct area names and their corresponding LAT and LON values
INSERT INTO area_coordinates (area_name, area_lat, area_lon) VALUES
    ('Central', 34.0445, -118.2479),
    ('Rampart', 34.0583, -118.2713),
    ('Southwest', 34.0107, -118.3039),
    ('Hollenbeck', 34.0453, -118.2121),
    ('Harbor', 33.7388, -118.2884),
    ('Hollywood', 34.0977, -118.3303),
    ('Wilshire', 34.0471, -118.3449),
    ('West LA', 34.0468, -118.4454),
    ('Van Nuys', 34.1849, -118.4494),
    ('West Valley', 34.1934, -118.5445),
    ('Northeast', 34.1095, -118.2351),
    ('77th Street', 33.9705, -118.2789),
    ('Newton', 34.0114, -118.2567),
    ('Pacific', 33.9949, -118.4291),
    ('N Hollywood', 34.1713, -118.3825),
    ('Foothill', 34.2613, -118.4156),
    ('Devonshire', 34.2566, -118.5852),
    ('Southeast', 33.9378, -118.2725),
    ('Mission', 34.2712, -118.4821),
    ('Olympic', 34.0515, -118.2922),
    ('Topanga', 34.2201, -118.5985)
ON CONFLICT (area_name) DO NOTHING;  -- Avoids duplicate entries if the script is re-run

-- 4. Create table to store information on each crime
CREATE TABLE IF NOT EXISTs crime_code_info (
    crm_cd VARCHAR(10) PRIMARY KEY,                  -- Crime Code
    crm_cd_desc VARCHAR(255),                        -- Crime Code Description
    main_category VARCHAR(20),                       -- Main Category
    sub_category VARCHAR(20),                        -- Sub Category
    part_1_2 VARCHAR(10)
);


-- Insert distinct records from the original crime_data table into the new table
INSERT INTO crime_code_info (crm_cd, crm_cd_desc, main_category, sub_category, part_1_2)
SELECT DISTINCT crm_cd, crm_cd_desc, main_category, sub_category, part_1_2
FROM crime_data
ON CONFLICT (crm_cd) DO NOTHING;  -- Avoids duplicate entries if the script is re-run

-- 5. Create crime records table that will serve as the the new base table that relates to the tables we just made


CREATE TABLE IF NOT EXISTS crime_records (
    dr_no VARCHAR(20) PRIMARY KEY,               -- Division of Records Number
    date_rptd DATE NOT NULL,                	 -- Date Reported
    date_occ DATE NOT NULL,                 	 -- Date Occurred
    time_occ TIME NOT NULL,                      -- Time Occurred
    area_name VARCHAR(50) NOT NULL,            	 -- Area Name
    part_1_2 VARCHAR(10),                        -- Part 1-2 (Crime Category)
    crm_cd VARCHAR(10) NOT NULL,                 -- Crime Code
    vict_age INT,                           	 -- Victim Age (2 characters)
    vict_sex CHAR(1), 							 -- Victim Sex
    vict_descent CHAR(1),						 -- Victim Descent
    weapon_desc VARCHAR(50),                     -- Weapon Description
    status_desc VARCHAR(50),                     -- Status Description
    
    FOREIGN KEY (crm_cd) REFERENCES crime_code_info(crm_cd)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE,
    FOREIGN KEY (vict_descent) REFERENCES vict_descent_info(vict_descent)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE,
    FOREIGN KEY (area_name) REFERENCES area_coordinates(area_name)
    	ON DELETE CASCADE
    	ON UPDATE CASCADE
);


-- Insert necessary data from original temporary crime table
INSERT INTO crime_records (
    dr_no, date_rptd, date_occ, time_occ, area_name, part_1_2, crm_cd, vict_age, vict_sex, vict_descent, weapon_desc, status_desc
)
SELECT 
    dr_no, date_rptd, date_occ, time_occ, area_name, part_1_2, crm_cd, vict_age, vict_sex, vict_descent, weapon_desc, status_desc
FROM 
    crime_data;
   
-- 6. Delete original temporary crime table 
DROP TABLE IF exists crime_data;

