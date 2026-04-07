# Credit-card-fraud-detection-using-R-language
## Project Overview
This project focuses on detecting fraudulent credit card transactions using a complete Data Science pipeline implemented in R. The dataset contains anonymized transaction details, and machine learning models are applied to classify transactions as fraudulent or legitimate.

---

## Objectives
- Analyze and understand transaction data
- Handle class imbalance in fraud detection
- Build and compare machine learning models
- Evaluate model performance using appropriate metrics
- Develop an interactive dashboard for visualization

---

## Dataset
- Source: Kaggle (Credit Card Fraud Detection dataset)
- Contains ~284,000 transactions
- Highly imbalanced dataset (fraud cases < 1%)

---

## Methodology

### 1. Data Preprocessing
- Removed irrelevant features (Time)
- Scaled numerical features (Amount)
- Checked for missing values (none found)

### 2. Exploratory Data Analysis (EDA)
- Class distribution analysis
- Data visualization (histogram, boxplot, heatmap)
- Correlation analysis

### 3. Handling Imbalanced Data
- Applied undersampling to balance fraud and normal classes

### 4. Model Building
- Random Forest
- Logistic Regression
- Support Vector Machine (SVM)

### 5. Model Evaluation
- Confusion Matrix
- Precision, Recall, F1-score

---

## Results
- Random Forest performed best among all models
- Improved fraud detection using balanced dataset
- Recall and F1-score used as key metrics due to imbalance

---

## Dashboard
- Built using Shiny and Plotly
- Interactive feature selection
- Dynamic visualizations
- Special handling for categorical vs numerical variables

---

## Technologies Used
- R Programming
- randomForest, e1071, caret
- corrplot
- shiny, plotly

---

## Key Insights
- Dataset is highly imbalanced, making fraud detection challenging
- Accuracy alone is not sufficient; recall is critical
- Feature importance helps identify influential variables

---

## Conclusion
The project demonstrates a complete data science workflow for fraud detection. The models effectively classify transactions, and the dashboard provides an intuitive way to explore data.

---

## Future Work
- Implement SMOTE for better imbalance handling
- Deploy model as a web application
- Use deep learning techniques for improved performance
