
# Executive Summary

## Project Title

Loan Default Prediction and Credit Risk Scorecard

## Overview

This project developed an end-to-end credit risk analytics and machine learning framework to predict loan default risk, segment borrowers into risk bands, and support underwriting and portfolio monitoring decisions.

The project uses public LendingClub loan data to simulate a practical credit risk use case relevant to banking, fintech lending, credit unions, and financial analytics teams.

## Business Problem

Lenders need to identify borrowers who are more likely to default before making or reviewing credit decisions. Approving high-risk borrowers without appropriate review can increase credit losses, while overly conservative lending decisions can reduce growth and reject creditworthy applicants.

This project addresses that problem by building a model that ranks borrowers by default risk and converts the output into practical risk bands for business use.

## What Was Built

The project includes:

- Data cleaning and feature engineering workflow
- SQL-based credit risk analytics layer
- Exploratory default risk analysis
- Multiple machine learning models
- Champion model selection
- Decile, lift, Gini, KS, and calibration analysis
- Threshold tuning
- Credit risk scorecard
- Dashboard-ready reporting tables
- Model card and governance documentation

## Champion Model

The best-performing model was LightGBM.

Model performance:

| Metric | Value |
|---|---:|
| ROC-AUC | 0.7287 |
| PR-AUC | 0.4196 |
| Gini | 0.4574 |
| KS Statistic | 0.3330 |
| Observed Default Rate | 21.24% |

The model demonstrated useful borrower risk ranking power, especially through decile and risk band analysis.

## Key Findings

The model and analysis found that default risk is strongly associated with:

- Weaker loan grades
- Longer loan terms
- Higher debt-to-income ratios
- Higher revolving credit utilization
- Higher interest rates
- Higher loan burden relative to income
- Shorter credit history
- Certain loan purposes

Exploratory analysis showed that default rates increased from 6.57% for Grade A loans to 50.91% for Grade G loans. Similarly, 60-month loans showed a default rate of 34.27%, compared with 17.03% for 36-month loans.

## Risk Segmentation Results

The final scorecard grouped borrowers into four risk bands:

| Risk Band | Portfolio Share | Observed Default Rate | Recommended Action |
|---|---:|---:|---|
| Low Risk | 50% | 10.34% | Standard approval path |
| Medium Risk | 25% | 23.18% | Standard review and monitoring |
| High Risk | 15% | 34.42% | Manual underwriting review |
| Critical Risk | 10% | 51.07% | Senior review or additional documentation |

The High and Critical Risk segments represented 25% of scored loans but captured 48.36% of observed defaults. This shows that the model can support manual review prioritization and risk monitoring.

## Business Use

The model can support:

- Underwriting triage
- Manual review prioritization
- Portfolio risk monitoring
- Risk band reporting
- Credit policy analysis
- Early warning analytics

The model should not be used as a fully automated approval or rejection engine.

## Limitations

The model has important limitations:

- The dataset is U.S.-based and may not fully represent Canadian borrowers.
- Public data does not include all credit bureau variables used by real lenders.
- Raw model scores overestimate observed default rates.
- Probability calibration is required before using scores as true probability of default estimates.
- Model fairness cannot be fully assessed without additional borrower demographic and policy data.
- Production use would require validation, monitoring, privacy review, and governance approval.

## Recommendations

Recommended next steps before production use:

1. Calibrate model probabilities.
2. Validate the model using recent internal lending data.
3. Test fairness and adverse impact across borrower segments.
4. Define threshold policy based on review capacity and credit loss tolerance.
5. Monitor model drift and calibration monthly.
6. Maintain model card and governance documentation.
7. Use model output for decision support, not automatic decline decisions.

## Conclusion

This project demonstrates how credit risk analytics can combine SQL, Python, machine learning, scorecard design, model evaluation, and business reporting to support practical lending decisions. The final model is most useful as a risk-ranking and manual review prioritization tool, with additional calibration and governance required before production use.
EOF