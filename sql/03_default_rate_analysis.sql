-- ============================================================
-- Project: Loan Default Prediction and Credit Risk Scorecard
-- File: 03_default_rate_analysis.sql
-- Purpose: Analyze observed default rates by borrower and loan segments
-- ============================================================

-- Overall default rate
SELECT
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_modeling_features;

-- Default rate by grade
SELECT
    grade,
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_modeling_features
GROUP BY grade
ORDER BY grade;

-- Default rate by term
SELECT
    term_months,
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_modeling_features
GROUP BY term_months
ORDER BY term_months;

-- Default rate by DTI band
SELECT
    dti_band,
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_modeling_features
GROUP BY dti_band
ORDER BY default_rate_pct DESC;

-- Default rate by income band
SELECT
    income_band,
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_modeling_features
GROUP BY income_band
ORDER BY default_rate_pct DESC;

-- Default rate by purpose
SELECT
    purpose,
    COUNT(*) AS loan_count,
    SUM(default_flag) AS default_count,
    ROUND(AVG(default_flag) * 100, 2) AS default_rate_pct
FROM loan_modeling_features
GROUP BY purpose
HAVING COUNT(*) >= 1000
ORDER BY default_rate_pct DESC;
