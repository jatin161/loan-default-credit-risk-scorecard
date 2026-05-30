
# Model Card: Loan Default Prediction and Credit Risk Scorecard

## 1. Model Overview

This model predicts borrower loan default risk using historical loan-level data. The model output is used to rank borrowers by relative credit risk and segment them into Low Risk, Medium Risk, High Risk, and Critical Risk bands.

The model is designed as a credit risk decision-support tool for underwriting prioritization, portfolio monitoring, and risk reporting.

## 2. Business Objective

The objective is to support lenders in identifying borrowers with higher likelihood of default so that underwriting teams can prioritize manual review, monitor portfolio risk, and improve credit risk visibility.

The model is not designed to automatically approve or decline borrowers.

## 3. Dataset Used

The project uses public LendingClub accepted loan data.

The dataset includes borrower attributes, loan characteristics, credit profile indicators, and final loan outcome information.

## 4. Target Variable

Target variable: `default_flag`

Definition:

- `1` = Charged Off, Default, Late (31-120 days), or charged-off non-policy loan
- `0` = Fully Paid or fully-paid non-policy loan

Loans with incomplete outcomes, such as Current or In Grace Period, were excluded from supervised model training.

## 5. Features Used

The model uses borrower, loan, and credit profile features available at or near loan origination.

Main feature groups:

- Loan characteristics: loan amount, term, installment, interest rate
- Borrower capacity: annual income, debt-to-income ratio, loan-to-income ratio
- Credit profile: revolving balance, revolving utilization, open accounts, total accounts
- Credit history: credit history length, delinquencies, recent inquiries
- Application profile: purpose, home ownership, employment length, verification status
- Engineered risk flags: high DTI flag, high utilization flag, recent inquiry flag, long-term loan flag

## 6. Leakage Prevention

Post-origination repayment and collection variables were excluded to prevent data leakage.

Examples of excluded leakage variables:

- Total payments received
- Principal and interest recovered
- Recoveries
- Last payment date
- Outstanding principal
- Settlement status
- Hardship status
- Collection recovery fee

Only variables that would reasonably be available before or at loan origination were used for modeling.

## 7. Models Tested

The project compared multiple classification models:

| Model | Purpose |
|---|---|
| Naive Baseline | Benchmark using average default rate |
| Logistic Regression | Interpretable benchmark |
| Weighted Logistic Regression | Handles class imbalance |
| Regularized Weighted Logistic Regression | Improves stability and reduces overfitting |
| Decision Tree | Simple non-linear benchmark |
| Random Forest | Non-linear ensemble model |
| HistGradientBoosting | Efficient gradient boosting benchmark |
| XGBoost | Gradient boosting model for structured data |
| LightGBM | Champion gradient boosting model |

## 8. Champion Model

Champion model: LightGBM

The LightGBM model was selected because it achieved the strongest overall ranking and classification performance among tested models.

## 9. Model Performance

| Metric | Value |
|---|---:|
| ROC-AUC | 0.7287 |
| PR-AUC | 0.4196 |
| Gini | 0.4574 |
| KS Statistic | 0.3330 |
| Brier Score | 0.2107 |
| Observed Default Rate | 21.24% |
| Average Raw Model Score | 45.29% |

## 10. Decile Analysis

The model showed strong risk ranking power.

| Risk Decile | Observed Default Rate | Lift | Cumulative Default Capture |
|---|---:|---:|---:|
| 1 | 51.07% | 2.41 | 24.05% |
| 2 | 36.37% | 1.71 | 41.18% |
| 3 | 28.95% | 1.36 | 54.81% |
| 10 | 3.89% | 0.18 | 100.00% |

The top 10% highest-risk borrowers captured 24.05% of all defaults. The top 25% High + Critical Risk borrowers captured 48.36% of all defaults.

## 11. Risk Bands

Risk bands were created using score percentiles because the raw model probabilities were not fully calibrated.

| Risk Band | Portfolio Share | Observed Default Rate | Recommended Action |
|---|---:|---:|---|
| Low Risk | 50% | 10.34% | Standard approval path; routine monitoring |
| Medium Risk | 25% | 23.18% | Standard review; monitor risk indicators |
| High Risk | 15% | 34.42% | Manual underwriting review recommended |
| Critical Risk | 10% | 51.07% | Senior review, additional documentation, or decline consideration |

## 12. Threshold Decision

A threshold of 0.50 was used as the initial manual review threshold.

At this threshold:

- Precision: 34.60%
- Recall: 67.88%
- F1-score: 45.84%
- Manual review rate: 41.66%
- Default capture rate: 67.88%

This threshold provides a practical balance between default detection and operational review volume for a portfolio project. In production, threshold selection should be based on underwriting capacity, expected credit loss, approval impact, and governance requirements.

## 13. Calibration

Calibration analysis showed that raw LightGBM model scores overestimated observed default rates. Therefore, model outputs should be interpreted as relative risk-ranking scores rather than fully calibrated probability of default estimates.

Before production use as true PD estimates, the model should be calibrated using methods such as Platt scaling or isotonic regression and validated on recent internal lending data.

## 14. Intended Use

The model is intended for:

- Credit risk segmentation
- Manual underwriting review prioritization
- Portfolio monitoring
- Risk reporting
- Model evaluation demonstration
- Credit risk analytics portfolio work

## 15. Not Intended For

The model is not intended for:

- Fully automated loan approval
- Fully automated loan rejection
- Real lending decisions without validation
- Regulatory credit adjudication
- Use with real customer data without privacy and compliance review
- Production deployment without model governance

## 16. Limitations

- The dataset is U.S.-based and may not fully represent the Canadian credit market.
- Public loan data may not include all credit bureau variables used by real lenders.
- Historical borrower behaviour may not reflect future economic conditions.
- Raw model probabilities are not calibrated.
- `issue_year` was an important feature, which may reflect time-based portfolio, policy, or economic effects.
- Fairness testing is limited because sensitive demographic variables are not available.
- The model was developed for portfolio demonstration, not production lending.

## 17. Bias and Fairness Risks

Potential fairness risks include:

- Income-related disparities
- Employment history proxy effects
- Home ownership proxy effects
- Historical lending policy bias
- Risk of over-reliance on model scores without human review

The model should be reviewed for adverse impact and fairness before any real-world lending use.

## 18. Monitoring Plan

Recommended monitoring includes:

- Monthly default rate by risk band
- Predicted score distribution drift
- Observed default rate by decile
- Calibration drift
- Feature drift
- Approval/review rate by segment
- Manual override rate
- Performance by borrower segment
- Champion/challenger model comparison

## 19. Retraining Recommendation

The model should be reviewed or retrained:

- Every 6 to 12 months
- When borrower mix changes materially
- When default rates shift materially
- After major economic changes
- If calibration deteriorates
- If model ranking performance declines
- If lending policy changes

## 20. Responsible Use Statement

This model should be used as a decision-support tool. Final lending decisions should include human judgment, policy review, fairness assessment, and model governance controls.
EOF