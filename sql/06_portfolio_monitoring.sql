-- ============================================================
-- Project: Loan Default Prediction and Credit Risk Scorecard
-- File: 06_portfolio_monitoring.sql
-- Purpose: Monitor portfolio risk by model score, risk band, and borrower segment
-- ============================================================

-- Portfolio risk by risk band
SELECT
    risk_band,
    COUNT(*) AS loan_count,
    SUM(actual_default) AS default_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS portfolio_share_pct,
    ROUND(AVG(actual_default) * 100, 2) AS observed_default_rate_pct,
    ROUND(AVG(predicted_model_score) * 100, 2) AS avg_model_score_pct
FROM model_scores
GROUP BY risk_band
ORDER BY
    CASE risk_band
        WHEN 'Low Risk' THEN 1
        WHEN 'Medium Risk' THEN 2
        WHEN 'High Risk' THEN 3
        WHEN 'Critical Risk' THEN 4
        ELSE 5
    END;

-- High and critical risk default capture
SELECT
    SUM(CASE WHEN risk_band IN ('High Risk', 'Critical Risk') THEN actual_default ELSE 0 END)
        / NULLIF(SUM(actual_default), 0) AS high_critical_default_capture_rate,
    COUNT(CASE WHEN risk_band IN ('High Risk', 'Critical Risk') THEN 1 END)
        * 1.0 / COUNT(*) AS high_critical_portfolio_share
FROM model_scores;

-- Monitoring by grade and risk band
SELECT
    f.grade,
    s.risk_band,
    COUNT(*) AS loan_count,
    SUM(s.actual_default) AS default_count,
    ROUND(AVG(s.actual_default) * 100, 2) AS observed_default_rate_pct,
    ROUND(AVG(s.predicted_model_score) * 100, 2) AS avg_model_score_pct
FROM model_scores s
JOIN loan_modeling_features f
    ON s.loan_id = f.loan_id
GROUP BY f.grade, s.risk_band
ORDER BY f.grade, s.risk_band;

-- Monitoring by loan purpose and risk band
SELECT
    f.purpose,
    s.risk_band,
    COUNT(*) AS loan_count,
    SUM(s.actual_default) AS default_count,
    ROUND(AVG(s.actual_default) * 100, 2) AS observed_default_rate_pct,
    ROUND(AVG(s.predicted_model_score) * 100, 2) AS avg_model_score_pct
FROM model_scores s
JOIN loan_modeling_features f
    ON s.loan_id = f.loan_id
GROUP BY f.purpose, s.risk_band
HAVING COUNT(*) >= 500
ORDER BY observed_default_rate_pct DESC;
