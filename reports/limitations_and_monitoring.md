
# Limitations and Monitoring Plan

## 1. Project Limitations

This project was developed as a portfolio-level credit risk analytics and machine learning project. It demonstrates practical modeling, risk segmentation, and reporting concepts, but it is not a production lending model.

## 2. Dataset Limitations

The project uses public LendingClub loan data. While the dataset is useful for demonstrating credit risk analytics, it has several limitations:

- The data is U.S.-based and may not reflect Canadian lending behaviour.
- LendingClub borrowers may not represent bank, credit union, or fintech borrowers in Canada.
- Public data may exclude important credit bureau and affordability variables.
- Some fields may reflect LendingClub-specific policy or pricing decisions.
- The data may not reflect current economic conditions.

## 3. Model Limitations

The champion LightGBM model performed well for borrower risk ranking, but it has limitations:

- Raw model scores are not fully calibrated.
- Average predicted model score was higher than the observed default rate.
- Model output should be interpreted as a relative risk score, not a fully reliable probability of default.
- The model may learn historical lending policy patterns.
- The model may be sensitive to time-based shifts in borrower mix and underwriting rules.
- `issue_year` was an important feature, which may reflect macroeconomic, portfolio, or policy effects rather than borrower-level risk alone.

## 4. Calibration Limitation

Calibration analysis showed that the model overestimated observed default rates.

Example:

- Highest score band had average raw model score of 78.16%
- Observed default rate in that band was 51.07%

This means the model can rank borrowers effectively, but raw scores should not be treated as exact probability of default estimates without calibration.

Recommended next step:

- Apply probability calibration using Platt scaling or isotonic regression.
- Validate calibrated probabilities on a holdout time-based validation set.

## 5. Business Use Limitation

The model should not be used for automatic approval or rejection.

Appropriate use:

- Manual review prioritization
- Portfolio monitoring
- Risk segmentation
- Reporting and analytics
- Policy discussion support

Inappropriate use:

- Automatic decline decisions
- Regulatory credit adjudication
- Production use without validation
- Use with real customer data without privacy and governance review

## 6. Fairness and Ethical Limitations

This project does not fully evaluate fairness or adverse impact because the public dataset does not include all required demographic and policy variables.

Potential fairness risks include:

- Income proxy effects
- Employment history proxy effects
- Home ownership proxy effects
- Historical approval bias
- Differential impact across borrower groups

Before real-world use, the model should be tested for fairness and reviewed by compliance, credit policy, and model risk teams.

## 7. Monitoring Plan

A production-style monitoring framework should track the following areas.

### 7.1 Performance Monitoring

Track monthly:

- ROC-AUC
- PR-AUC
- Gini
- KS statistic
- Precision
- Recall
- F1-score
- Default capture rate
- Decile default rates

### 7.2 Calibration Monitoring

Track:

- Predicted score vs observed default rate
- Calibration curve
- Brier Score
- Risk band observed default rate
- Difference between expected and observed default rates

### 7.3 Data Drift Monitoring

Track feature distribution changes for:

- Annual income
- DTI
- Revolving utilization
- Loan amount
- Interest rate
- Credit history length
- Loan purpose
- Grade and sub-grade
- Term

### 7.4 Population Stability

Use Population Stability Index or similar drift metrics to monitor changes in:

- Score distribution
- Risk band distribution
- Borrower profile distribution
- Portfolio origination mix

### 7.5 Business Monitoring

Track:

- Manual review volume
- Approval rate by risk band
- Decline rate by risk band
- Override rate
- Default rate by risk band
- Exposure by risk band
- High and Critical Risk portfolio share
- High and Critical Risk default capture

### 7.6 Fairness Monitoring

Where legally and ethically appropriate, monitor:

- Model performance across borrower groups
- Approval and review rates across groups
- False positive rates
- False negative rates
- Adverse impact indicators

## 8. Retraining Triggers

Retraining or recalibration should be considered when:

- Default rate materially changes
- Borrower population changes
- Lending policy changes
- Economic conditions change
- Model calibration deteriorates
- ROC-AUC or KS declines materially
- Risk band default rates no longer separate clearly
- Data drift exceeds acceptable thresholds

## 9. Recommended Review Frequency

| Review Area | Frequency |
|---|---|
| Model performance | Monthly |
| Calibration | Monthly or quarterly |
| Feature drift | Monthly |
| Risk band monitoring | Monthly |
| Fairness review | Quarterly |
| Full model validation | Semi-annually or annually |
| Retraining assessment | Every 6-12 months |

## 10. Governance Recommendation

Before production use, the model should have:

- Approved model card
- Independent validation
- Data lineage documentation
- Feature definition documentation
- Threshold policy
- Fairness assessment
- Monitoring dashboard
- Escalation process
- Retraining policy
- Human review process

## 11. Final Responsible Use Statement

This model should support human decision-making, not replace it. The model can help identify higher-risk borrowers and improve portfolio visibility, but final credit decisions require policy judgment, human review, compliance oversight, and model governance.
EOF