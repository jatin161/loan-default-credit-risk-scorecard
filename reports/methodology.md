# Methodology

## 1. Business Understanding

The project is framed as a credit risk decision-support solution for a lender. The goal is to estimate borrower probability of default and support underwriting review, risk segmentation, and portfolio monitoring.

## 2. Data Understanding

The project uses public LendingClub loan data. The dataset includes loan characteristics, borrower financial attributes, credit history indicators, loan purpose, loan grade, and final loan status.

## 3. Target Variable Definition

The target variable is `default_flag`.

- `1` = Charged Off, Default, or severe delinquency
- `0` = Fully Paid

Loans with incomplete or current status are excluded from supervised model training.

## 4. Leakage Prevention

Only variables available at or before loan origination are used. Post-origination repayment fields such as payments received, recoveries, outstanding principal, last payment date, and settlement fields are excluded.

## 5. Feature Engineering

Feature engineering includes:

- Loan-to-income ratio
- Installment-to-income ratio
- Credit history length
- DTI bands
- Income bands
- High utilization flag
- Recent inquiry flag
- Long-term loan flag
- Ordered grade risk mapping

## 6. Exploratory Data Analysis

EDA focuses on business risk patterns:

- Default rate by grade
- Default rate by term
- Default rate by DTI band
- Default rate by income band
- Default rate by purpose
- Default concentration by borrower profile

## 7. Modeling

The modeling workflow includes:

- Naive baseline model
- Logistic regression
- Regularized logistic regression
- Decision tree
- Random forest
- Gradient boosting model

## 8. Model Evaluation

Models are evaluated using:

- ROC-AUC
- PR-AUC
- Precision
- Recall
- F1-score
- Confusion matrix
- Lift chart
- Decile analysis
- Gini coefficient
- KS statistic
- Calibration curve
- Brier score

## 9. Scorecard and Risk Bands

Predicted probabilities are converted into business-friendly risk bands:

- Low Risk
- Medium Risk
- High Risk
- Critical Risk

Each band is linked to a recommended underwriting or monitoring action.

## 10. Model Governance

The project includes a model card, limitations, monitoring plan, retraining recommendations, and responsible-use guidance.