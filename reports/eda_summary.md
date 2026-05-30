# Exploratory Data Analysis Summary

## Objective

The objective of the exploratory analysis was to identify borrower, loan, and credit profile characteristics associated with higher default risk.

## Key Findings

### 1. Overall Default Rate

The cleaned modeling dataset contains completed loan outcomes only. The observed default rate is approximately 21%, which provides a meaningful classification target for credit risk modeling.

### 2. Loan Grade

Default risk increases as loan grade weakens. This confirms that grade and sub-grade are strong risk indicators and useful for both modeling and dashboard segmentation.

### 3. Loan Term

Longer-term loans show higher default risk compared with shorter-term loans. This is relevant because longer repayment periods create more uncertainty and exposure to borrower financial stress.

### 4. Debt-to-Income Ratio

Borrowers with higher DTI levels show higher default risk. DTI is a core borrower capacity indicator and should be included in model development and portfolio monitoring.

### 5. Loan Purpose

Default rates vary across loan purposes. This supports including loan purpose in the model and monitoring risk by purpose segment.

### 6. Credit History

Borrowers with shorter or weaker credit history patterns may show different default behaviour. Credit history length is useful as a borrower stability feature.

### 7. Interest Rate

Defaulted loans tend to have higher interest rates. This is expected because interest rates often reflect borrower risk. However, interest rate should be interpreted carefully because it may embed the lender's internal risk assessment.

## Modeling Implications

Based on the EDA, the following variables are expected to be important in modeling:

- Loan grade and sub-grade
- Interest rate
- Loan term
- DTI
- Revolving utilization
- Annual income
- Loan-to-income ratio
- Installment-to-income ratio
- Credit history length
- Loan purpose
- Recent inquiries
- Delinquency history

## Business Implications

The EDA supports a risk segmentation framework where borrowers with weaker grades, higher DTI, higher utilization, longer loan terms, and higher loan burden relative to income are monitored more closely or routed to manual underwriting review.