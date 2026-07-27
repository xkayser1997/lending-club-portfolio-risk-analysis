--Created bands for DTI and loan amount to compare to the defaulted loans in the accepted table
ALTER TABLE `cedar-turbine-501913-v0.lend_club.rejected_clean`
ADD COLUMN dti_band STRING;
ALTER TABLE `cedar-turbine-501913-v0.lend_club.rejected_clean`
ADD COLUMN requested_amnt_band STRING;

UPDATE `cedar-turbine-501913-v0.lend_club.rejected_clean`
SET dti_band =
  CASE
    WHEN `Debt-To-Income Ratio` IS NULL THEN 'Unknown'
    WHEN `Debt-To-Income Ratio` < 0 THEN 'Invalid'
    WHEN `Debt-To-Income Ratio` <= .10 THEN 'Very Low (0-10%)'
    WHEN `Debt-To-Income Ratio` <= .20 THEN 'Low (10-20%)'
    WHEN `Debt-To-Income Ratio` <= .30 THEN 'Moderate (20-30%)'
    WHEN `Debt-To-Income Ratio` <= .40 THEN 'High (30-40%)'
    WHEN `Debt-To-Income Ratio` <= .50 THEN 'Very High (40-50%)'
    ELSE '>50%'
  END,

    requested_amnt_band =
  CASE
    WHEN `Amount Requested` IS NULL THEN 'Unknown'
    WHEN `Amount Requested` < 5000 THEN '<5k'
    WHEN `Amount Requested` < 10000 THEN '5-10k'
    WHEN `Amount Requested` < 20000 THEN '10-20k'
    WHEN `Amount Requested` < 35000 THEN '20-35k'
    ELSE '>35k'
  END
WHERE TRUE
