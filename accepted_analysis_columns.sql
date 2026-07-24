--Creation of additional columns in the accepted table for easier analysis.

--Unfortunately I did some of this during the cleaning process instead of at the end.
--This has no bearing on the accuracy of the created columns since they were made after
--I cleaned the column they were generated from, however, there are inconsistent
--table names which may reduce clarity.

--Created columns with the dates converted from string to date format
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean`
AS
SELECT
  *,
  PARSE_DATE('%b-%Y', issue_d) AS issue_date,
  PARSE_DATE('%b-%Y', last_pymnt_d) AS last_pymnt_date, 
  PARSE_DATE('%b-%Y', next_pymnt_d) AS next_pymnt_date,
  PARSE_DATE('%b-%Y', last_credit_pull_d) AS last_credit_pull_date,
  PARSE_DATE('%b-%Y', earliest_cr_line) AS earliest_cr_line_date,
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean`

--Created income bands for easier analysis
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
AS
SELECT
  *,
  CASE
    WHEN annual_inc < 50000 THEN '<50k'
    WHEN annual_inc < 100000 THEN '50k-100k'
    WHEN annual_inc < 250000 THEN '100k-250k'
    WHEN annual_inc < 500000 THEN '250K-500K'
    WHEN annual_inc < 1000000 THEN '500K-1M'
    WHEN annual_inc < 5000000 THEN '1M-5M'
    ELSE '>5M'
  END AS income_band
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`

--Created new columns for ease of analysis before moving onto EDA
ALTER TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
ADD COLUMN default_flag INT64;
ALTER TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
ADD COLUMN fico_avg FLOAT64;
ALTER TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
ADD COLUMN issue_year INT64;
ALTER TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
ADD COLUMN issue_month INT64;
ALTER TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
ADD COLUMN loan_size_band STRING;
ALTER TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
ADD COLUMN interest_rate_band STRING;

--Populated new columns
UPDATE `cedar-turbine-501913-v0.lend_club.accepted_clean_temp_num`
SET
  default_flag = CASE
    WHEN loan_outcome = 'Default' THEN 1
    ELSE 0
  END,
  
  fico_avg = ROUND((fico_range_low + fico_range_high) / 2, 0),

  issue_year = EXTRACT(YEAR FROM issue_date),

  issue_month = EXTRACT(MONTH FROM issue_date),

  loan_size_band = CASE
    WHEN loan_amnt < 5000 THEN '<$5K'
    WHEN loan_amnt < 10000 THEN '$5K-$10K'
    WHEN loan_amnt < 20000 THEN '$10K-$20K'
    WHEN loan_amnt < 35000 THEN '$20K-$35K'
    ELSE '>=$35K'
  END,

   interest_rate_band = CASE
    WHEN int_rate < 8 THEN 'Low (0-8%)'
    WHEN int_rate < 12 THEN 'Medium (8-12%)'
    WHEN int_rate < 16 THEN 'High (12-16%)'
    ELSE 'Very High (>16%)'
  END
WHERE TRUE

--Created another new column for DTI bands
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
AS
SELECT
  *,
  CASE
    WHEN dti IS NULL THEN 'Unknown'
    WHEN dti < 0 THEN 'Invalid'
    WHEN dti <= 10 THEN 'Very Low (0-10%)'
    WHEN dti <= 20 THEN 'Low (10-20%)'
    WHEN dti <= 30 THEN 'Moderate (20-30%)'
    WHEN dti <= 40 THEN 'High (30-40%)'
    WHEN dti <= 50 THEN 'Very High (40-50%)'
    ELSE '>50%'
  END AS dti_band
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
