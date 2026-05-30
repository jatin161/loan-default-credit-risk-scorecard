-- ============================================================
-- Project: Loan Default Prediction and Credit Risk Scorecard
-- File: 04_decile_analysis.sql
-- Purpose: Evaluate model ranking power using decile analysis
-- ============================================================

WITH scored AS (
    SELECT
        loan_id,
        actual_default,
        predicted_model_score,
        NTILE(10) OVER (ORDER BY predicted_model_score DESC) AS risk_decile
    FROM model_scores
),

decile_summary AS (
    SELECT
        risk_decile,
        COUNT(*) AS loan_count,
        SUM(actual_default) AS default_count,
        AVG(predicted_model_score) AS avg_model_score,
        AVG(actual_default) AS observed_default_rate
    FROM scored
    GROUP BY risk_decile
),

portfolio AS (
    SELECT
        SUM(actual_default) AS total_defaults,
        AVG(actual_default) AS portfolio_default_rate
    FROM scored
)

SELECT
    d.risk_decile,
    d.loan_count,
    d.default_count,
    ROUND(d.avg_model_score * 100, 2) AS avg_model_score_pct,
    ROUND(d.observed_default_rate * 100, 2) AS observed_default_rate_pct,
    ROUND(d.default_count / NULLIF(p.total_defaults, 0) * 100, 2) AS default_capture_rate_pct,
    ROUND(d.observed_default_rate / NULLIF(p.portfolio_default_rate, 0), 2) AS lift
FROM decile_summary d
CROSS JOIN portfolio p
ORDER BY d.risk_decile;
