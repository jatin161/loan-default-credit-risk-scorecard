-- ============================================================
-- Project: Loan Default Prediction and Credit Risk Scorecard
-- File: 02_feature_engineering.sql
-- Purpose: Create modeling features from raw loan data
-- ============================================================

WITH base AS (
    SELECT
        loan_id,
        loan_amnt,
        funded_amnt,
        CAST(REPLACE(term, ' months', '') AS INT) AS term_months,
        int_rate,
        installment,
        grade,
        sub_grade,
        CASE
            WHEN grade = 'A' THEN 1
            WHEN grade = 'B' THEN 2
            WHEN grade = 'C' THEN 3
            WHEN grade = 'D' THEN 4
            WHEN grade = 'E' THEN 5
            WHEN grade = 'F' THEN 6
            WHEN grade = 'G' THEN 7
            ELSE NULL
        END AS grade_risk_numeric,
        emp_length,
        home_ownership,
        annual_inc,
        verification_status,
        purpose,
        dti,
        delinq_2yrs,
        earliest_cr_line,
        inq_last_6mths,
        open_acc,
        pub_rec,
        revol_bal,
        revol_util,
        total_acc,
        application_type,
        mort_acc,
        pub_rec_bankruptcies,
        issue_d,
        EXTRACT(YEAR FROM issue_d) AS issue_year,
        EXTRACT(MONTH FROM issue_d) AS issue_month,
        loan_status,
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Late (31-120 days)',
                'Does not meet the credit policy. Status:Charged Off'
            ) THEN 1
            WHEN loan_status IN (
                'Fully Paid',
                'Does not meet the credit policy. Status:Fully Paid'
            ) THEN 0
            ELSE NULL
        END AS default_flag
    FROM raw_lendingclub_loans
),

engineered AS (
    SELECT
        loan_id,
        loan_amnt,
        funded_amnt,
        term_months,
        int_rate,
        installment,
        grade,
        sub_grade,
        grade_risk_numeric,
        CASE
            WHEN emp_length = '< 1 year' THEN 0
            WHEN emp_length = '10+ years' THEN 10
            WHEN emp_length IS NULL THEN NULL
            ELSE CAST(REPLACE(REPLACE(emp_length, ' years', ''), ' year', '') AS NUMERIC)
        END AS emp_length_years,
        home_ownership,
        annual_inc,
        verification_status,
        purpose,
        dti,
        delinq_2yrs,
        inq_last_6mths,
        open_acc,
        pub_rec,
        revol_bal,
        revol_util,
        total_acc,
        application_type,
        mort_acc,
        pub_rec_bankruptcies,
        issue_year,
        issue_month,
        (
            (EXTRACT(YEAR FROM issue_d) - EXTRACT(YEAR FROM earliest_cr_line)) * 12
            + (EXTRACT(MONTH FROM issue_d) - EXTRACT(MONTH FROM earliest_cr_line))
        ) AS credit_history_months,
        loan_amnt / NULLIF(annual_inc, 0) AS loan_income_ratio,
        (installment * 12) / NULLIF(annual_inc, 0) AS installment_income_ratio,
        CASE WHEN dti >= 30 THEN 1 ELSE 0 END AS high_dti_flag,
        CASE WHEN revol_util >= 80 THEN 1 ELSE 0 END AS high_revol_util_flag,
        CASE WHEN inq_last_6mths >= 2 THEN 1 ELSE 0 END AS recent_inquiry_flag,
        CASE WHEN term_months = 60 THEN 1 ELSE 0 END AS long_term_flag,
        CASE
            WHEN annual_inc < 40000 THEN 'Low Income'
            WHEN annual_inc < 80000 THEN 'Middle Income'
            WHEN annual_inc < 120000 THEN 'Upper Middle Income'
            ELSE 'High Income'
        END AS income_band,
        CASE
            WHEN dti < 10 THEN 'Low DTI'
            WHEN dti < 20 THEN 'Moderate DTI'
            WHEN dti < 30 THEN 'High DTI'
            ELSE 'Very High DTI'
        END AS dti_band,
        CASE
            WHEN (
                (EXTRACT(YEAR FROM issue_d) - EXTRACT(YEAR FROM earliest_cr_line)) * 12
                + (EXTRACT(MONTH FROM issue_d) - EXTRACT(MONTH FROM earliest_cr_line))
            ) < 36 THEN 'Short Credit History'
            WHEN (
                (EXTRACT(YEAR FROM issue_d) - EXTRACT(YEAR FROM earliest_cr_line)) * 12
                + (EXTRACT(MONTH FROM issue_d) - EXTRACT(MONTH FROM earliest_cr_line))
            ) < 84 THEN 'Moderate Credit History'
            WHEN (
                (EXTRACT(YEAR FROM issue_d) - EXTRACT(YEAR FROM earliest_cr_line)) * 12
                + (EXTRACT(MONTH FROM issue_d) - EXTRACT(MONTH FROM earliest_cr_line))
            ) < 180 THEN 'Established Credit History'
            ELSE 'Long Credit History'
        END AS credit_history_band,
        default_flag
    FROM base
    WHERE default_flag IS NOT NULL
)

SELECT *
FROM engineered;
