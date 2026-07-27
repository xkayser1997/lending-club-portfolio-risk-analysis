--Creation of Summary Tables for export to Tableau

--Portfolio Overview: Overview of KPIs, Yearly Trends, State performance, and Purpose
--Overview of KPIs
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.overview_KPIs`
AS
SELECT
  COUNT(*) AS total_loans,
  SUM(funded_amnt) AS total_funded,
  SUM(total_pymnt) AS total_received,
  SUM(total_pymnt) - SUM(funded_amnt) AS net_profit,
  ROUND(AVG(loan_amnt),2) AS avg_loan_amount,
  ROUND(AVG(int_rate),2) AS avg_interest,
  ROUND(AVG(dti),2) AS avg_dti,
  ROUND(AVG(annual_inc),2) AS avg_annual_inc,
  ROUND(AVG(default_flag)*100,2) AS default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
  
--Yearly trends
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.overview_by_year`
AS
SELECT
  issue_year,
  COUNT(*) AS total_loans,
  SUM(funded_amnt) AS total_funded,
  SUM(total_pymnt) AS total_received,
  ROUND(AVG(loan_amnt),2) AS avg_loan_amount,
  ROUND(AVG(int_rate),2) AS avg_interest,
  ROUND(AVG(dti),2) AS avg_dti,
  ROUND(AVG(annual_inc),2) AS avg_annual_inc,
  ROUND(AVG(default_flag)*100,2) AS default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY issue_year
ORDER BY issue_year

--State performance
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.overview_by_state`
AS
SELECT
  addr_state,
  COUNT(*) AS total_loans,
  SUM(funded_amnt) AS total_funded,
  SUM(total_pymnt) AS total_received,
  ROUND(AVG(loan_amnt),2) AS avg_loan_amount,
  ROUND(AVG(int_rate),2) AS avg_interest,
  ROUND(AVG(annual_inc),2) AS avg_annual_inc,
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY addr_state
ORDER BY addr_state

--Overview by purpose
  CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.overview_by_purpose`
AS
SELECT
  purpose,
  COUNT(*) AS total_loans,
  SUM(funded_amnt) AS total_funded,
  SUM(total_pymnt) AS total_received,
  ROUND(AVG(loan_amnt),2) AS avg_loan_amount,
  ROUND(AVG(int_rate),2) AS avg_interest,
  ROUND(AVG(annual_inc),2) AS avg_annual_inc,
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY purpose
ORDER BY purpose

  
--Risk Analysis: Risk by Grade. DTI bands, Income bands, Employment Length, Purpose, and Loan Size bands
--Risk KPIs
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.risk_KPIs` 
AS
SELECT
  COUNT(*) AS total_defaults,
  SUM(funded_amnt)-SUM(total_pymnt)+SUM(collection_recovery_fee) AS total_lost,
  ROUND(AVG(funded_amnt)-AVG(total_pymnt)+AVG(collection_recovery_fee),2) AS avg_lost
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
WHERE loan_outcome = 'Default'
  
--Risk by Grade
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.risk_by_grade` 
AS
SELECT
  grade,
  COUNT(*) as total_loans,
  ROUND(AVG(default_flag)*100, 2) as default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY grade
ORDER BY grade

--Risk by Income
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.risk_by_income` 
AS
SELECT
  income_band,
  COUNT(*) as total_loans,
  ROUND(AVG(default_flag)*100, 2) as default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY income_band
ORDER BY income_band

--Risk by Purpose
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.risk_by_purpose` 
AS
SELECT
  purpose,
  COUNT(*) as total_loans,
  ROUND(AVG(default_flag)*100, 2) as default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY purpose
ORDER BY purpose

--Risk by DTI
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.risk_by_dti` 
AS
SELECT
  dti_band,
  COUNT(*) as total_loans,
  ROUND(AVG(default_flag)*100, 2) as default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY dti_band
ORDER BY dti_band

--Risk by Employment Length
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.risk_by_emp_length` 
AS
SELECT
  emp_length,
  COUNT(*) as total_loans,
  ROUND(AVG(default_flag)*100, 2) as default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY emp_length
ORDER BY emp_length

--Risk by Loan Size
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.risk_by_loan_size` 
AS
SELECT
  loan_size_band,
  COUNT(*) as total_loans,
  ROUND(AVG(default_flag)*100, 2) as default_rate
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
GROUP BY loan_size_band
ORDER BY loan_size_band

--Pricing Strategy Analysis
--Profit by Grade and Term
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.return_by_grade`
AS
SELECT
  grade,
  term,
  COUNT(*) AS total_loans,
  ROUND(AVG(int_rate),2) AS avg_int_rate,
  (SUM(total_pymnt)-SUM(funded_amnt)) AS total_profit, 
  ROUND((SUM(total_pymnt)-SUM(funded_amnt))/COUNT(*),2) AS avg_profit,
  ROUND(((SUM(total_pymnt)/SUM(funded_amnt))-1)*100,2) AS percent_return
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
WHERE loan_outcome = 'Paid'
GROUP BY grade,term
ORDER BY grade,term

--Loss by Grade and Term
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.loss_by_grade`
AS
SELECT
  grade,
  term,
  COUNT(*) AS total_defaults,
  ROUND(AVG(int_rate),2) AS avg_int_rate,
  SUM(funded_amnt) AS total_funded,
  (SUM(funded_amnt)-SUM(total_pymnt)+SUM(collection_recovery_fee)) AS total_loss, 
  ROUND((SUM(funded_amnt)-SUM(total_pymnt)+SUM(collection_recovery_fee))/COUNT(*),2) AS avg_loss,
  100-ROUND((((SUM(total_pymnt)-SUM(collection_recovery_fee))/SUM(funded_amnt)))*100,2) AS percent_loss
FROM `cedar-turbine-501913-v0.lend_club.accepted_clean_final`
WHERE loan_outcome = 'Default'
GROUP BY grade,term
ORDER BY grade,term

--Joined these tables after
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.pricing_strategy`
AS
SELECT
    COALESCE(r.grade, l.grade) AS grade,
    COALESCE(r.term, l.term) AS term,
    r.total_loans AS total_paid_loans,
    l.total_defaults,
    r.avg_int_rate,
    r.total_profit,
    r.avg_profit,
    r.percent_return,
    l.total_loss,
    l.avg_loss,
    l.percent_loss,
    -- Net return after losses
    ROUND(
        ((r.total_profit - l.total_loss) / (r.total_profit + l.total_loss)) * 100,
        2
    ) AS net_return
FROM `cedar-turbine-501913-v0.lend_club.return_by_grade` r
FULL OUTER JOIN `cedar-turbine-501913-v0.lend_club.loss_by_grade` l
ON r.grade = l.grade
AND r.term = l.term
ORDER BY grade, term

--Decided to add net profit column as well
ALTER TABLE cedar-turbine-501913-v0.lend_club.pricing_strategy
ADD COLUMN net_profit FLOAT64;

UPDATE `cedar-turbine-501913-v0.lend_club.pricing_strategy`
SET net_profit = total_profit - total_loss
WHERE grade IS NOT NULL

--Added average loan amount and total loans for analysis
CREATE OR REPLACE TABLE `cedar-turbine-501913-v0.lend_club.pricing_strategy_updated`
AS
SELECT
    p.*,
    s.number_of_loans,
    s.total_loan_amount,
    s.avg_loan_amount
FROM `cedar-turbine-501913-v0.lend_club.pricing_strategy` p
LEFT JOIN (
    SELECT
      grade,
      term,
      COUNT(*) AS number_of_loans,
      SUM(loan_amnt) AS total_loan_amount,
      AVG(loan_amnt) AS avg_loan_amount
    FROM`cedar-turbine-501913-v0.lend_club.accepted_clean_final`
    WHERE loan_outcome IN ('Paid','Default')
    GROUP BY grade,term
) s
ON p.grade = s.grade
AND p.term = s.term

ORDER BY grade,term
