--Rejected KPIs
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.rejected_KPIs`
AS
SELECT 
  COUNT(*) as total_rejected_apps,
  ROUND(AVG(`Amount Requested`),2) as avg_requested_amnt,
  ROUND(AVG(`dti_clean`),4) as avg_dti,
  ROUND(AVG(`Risk_Score`),2) as avg_risk_score,
FROM `cedar-turbine-501913-v0.lend_club.rejected_clean`
