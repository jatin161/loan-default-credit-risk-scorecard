-- ============================================================
-- Project: Loan Default Prediction and Credit Risk Scorecard
-- File: 01_create_schema.sql
-- Purpose: Create core tables for loan-level credit risk analysis
-- ============================================================

DROP TABLE IF EXISTS raw_lendingclub_loans;
DROP TABLE IF EXISTS loan_modeling_features;
DROP TABLE IF EXISTS model_scores;

CREATE TABLE raw_lendingclub_loans (
    loan_id BIGINT PRIMARY KEY,
    loan_amnt NUMERIC,
    funded_amnt NUMERIC,
    term VARCHAR(20),
    int_rate NUMERIC,
    installment NUMERIC,
    grade VARCHAR(5),
    sub_grade VARCHAR(5),
    emp_length VARCHAR(30),
    home_ownership VARCHAR(30),
    annual_inc NUMERIC,
    verification_status VARCHAR(50),
    issue_d DATE,
    loan_status VARCHAR(100),
    purpose VARCHAR(100),
    dti NUMERIC,
    delinq_2yrs NUMERIC,
    earliest_cr_line DATE,
    inq_last_6mths NUMERIC,
    open_acc NUMERIC,
    pub_rec NUMERIC,
    revol_bal NUMERIC,
    revol_util NUMERIC,
    total_acc NUMERIC,
    application_type VARCHAR(50),
    mort_acc NUMERIC,
    pub_rec_bankruptcies NUMERIC
);

CREATE TABLE loan_modeling_features (
    loan_id BIGINT PRIMARY KEY,
    loan_amnt NUMERIC,
    funded_amnt NUMERIC,
    term_months INT,
    int_rate NUMERIC,
    installment NUMERIC,
    grade VARCHAR(5),
    sub_grade VARCHAR(5),
    grade_risk_numeric INT,
    emp_length_years NUMERIC,
    home_ownership VARCHAR(30),
    annual_inc NUMERIC,
    verification_status VARCHAR(50),
    purpose VARCHAR(100),
    dti NUMERIC,
    delinq_2yrs NUMERIC,
    inq_last_6mths NUMERIC,
    open_acc NUMERIC,
    pub_rec NUMERIC,
    revol_bal NUMERIC,
    revol_util NUMERIC,
    total_acc NUMERIC,
    application_type VARCHAR(50),
    mort_acc NUMERIC,
    pub_rec_bankruptcies NUMERIC,
    issue_year INT,
    issue_month INT,
    credit_history_months INT,
    loan_income_ratio NUMERIC,
    installment_income_ratio NUMERIC,
    high_dti_flag INT,
    high_revol_util_flag INT,
    recent_inquiry_flag INT,
    long_term_flag INT,
    income_band VARCHAR(50),
    dti_band VARCHAR(50),
    credit_history_band VARCHAR(50),
    default_flag INT
);

CREATE TABLE model_scores (
    loan_id BIGINT PRIMARY KEY,
    actual_default INT,
    predicted_model_score NUMERIC,
    score_percentile NUMERIC,
    risk_band VARCHAR(50),
    model_name VARCHAR(100),
    score_date DATE
);
