--Rejected KPIs
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.rejected_KPIs`
AS
SELECT 
  COUNT(*) as total_rejected_apps,
  ROUND(AVG(`Amount Requested`),2) as avg_requested_amnt,
  ROUND(AVG(`dti_clean`),4) as avg_dti,
  ROUND(AVG(`Risk_Score`),2) as avg_risk_score,
FROM `cedar-turbine-501913-v0.lend_club.rejected_clean`

--Rejections by Loan amount bands
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.rejected_loan_amnt`
AS
SELECT 
  requested_amnt_band,
  COUNT(*) as total_rejected_apps

FROM `cedar-turbine-501913-v0.lend_club.rejected_clean`
GROUP BY requested_amnt_band 
ORDER BY total_rejected_apps DESC

--Rejections by DTI bands
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.rejected_dti_band`
AS
SELECT 
  dti_band,
  COUNT(*) as total_rejected_apps

FROM `cedar-turbine-501913-v0.lend_club.rejected_clean`
GROUP BY dti_band 
ORDER BY dti_band;

--Rejection by Employment Length
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.rejected_employment`
AS
SELECT 
  `Employment Length`,
  COUNT(*) as total_rejected_apps

FROM `cedar-turbine-501913-v0.lend_club.rejected_clean`
GROUP BY `Employment Length` 
ORDER BY `Employment Length`;

--Rejections by loan purpose
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.rejected_purpose`
AS
SELECT 
  `Loan Purpose`,
  COUNT(*) as total_rejected_apps

FROM `cedar-turbine-501913-v0.lend_club.rejected_clean`
GROUP BY `Loan Purpose` 
ORDER BY `Loan Purpose`;

