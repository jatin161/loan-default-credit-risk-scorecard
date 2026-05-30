-- ============================================================
-- Project: Loan Default Prediction and Credit Risk Scorecard
-- File: 05_vintage_analysis.sql
-- Purpose: Monitor default rates by origination cohort
-- ============================================================

-- Vintage analysis by issue year and issue month
SELECT
    issue_year,
    issue_month,
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS observed_default_rate_pct,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    ROUND(AVG(dti), 2) AS avg_dti
FROM loan_modeling_features
GROUP BY issue_year, issue_month
ORDER BY issue_year, issue_month;

-- Vintage analysis by grade
SELECT
    issue_year,
    grade,
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS observed_default_rate_pct,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate
FROM loan_modeling_features
GROUP BY issue_year, grade
ORDER BY issue_year, grade;
