# Machine Learning for Sales Forecasting

## Overview
This project applies supervised machine learning techniques — **linear regression** and **k-Nearest Neighbors (kNN) regression** — to a marketing dataset to forecast sales. The goal is to predict sales units based on advertising budgets across three media channels, and to quantify the impact of each channel on sales performance.

## Dataset
The `marketing` dataset is sourced from the R package [`datarium`](https://cran.r-project.org/package=datarium). It contains **200 observations** with the following variables:

| Variable    | Description                                  |
|-------------|----------------------------------------------|
| `youtube`   | Advertising budget allocated to YouTube (USD)|
| `facebook`  | Advertising budget allocated to Facebook (USD)|
| `newspaper` | Advertising budget allocated to newspapers (USD)|
| `sales`     | Sales units generated (outcome variable)     |

## Project Structure

```
├── Dataset.R          # Data loading, exploration, and visualization
├── Split_Data.R       # Train/test split (80/20)
├── Linear_Regression.R # Linear and quadratic regression models
├── kNN.R              # kNN regression with cross-validation tuning
└── README.md
```

## Methods

### 1. Data Exploration (`Dataset.R`)
- Loads the `marketing` dataset and inspects its structure and summary statistics.
- Visualizes the distribution of the `sales` variable using a histogram.
- Uses `pairs.panels` to display pairwise relationships and individual distributions.

### 2. Data Splitting (`Split_Data.R`)
- Splits the dataset into a **training set (80%)** and a **test set (20%)** using a fixed random seed for reproducibility.

### 3. Linear Regression (`Linear_Regression.R`)
- **Baseline model**: Linear regression using all three predictors.
  - R² = 0.89; RMSE ≈ 1.95
- **Improved model**: Adds second-order (quadratic) terms and an interaction term for `youtube` and `facebook`.
  - R² = 0.98; RMSE ≈ 0.51
- Residual diagnostics are performed to assess model fit.

### 4. kNN Regression (`kNN.R`)
- Trains a kNN regression model with 4-fold cross-validation to select the optimal number of neighbors *k*.
- Features are centered and scaled prior to training.
- Best *k* = 5; RMSE ≈ 1.37

## Results Summary

| Model                              | R²    | Test RMSE |
|------------------------------------|-------|-----------|
| Linear Regression (baseline)       | 0.89  | 1.95      |
| kNN Regression (k = 5)             | —     | 1.37      |
| Linear Regression (quadratic terms)| 0.98  | 0.51      |

The quadratic regression model — incorporating `youtube²`, `facebook²`, and a `youtube × facebook` interaction — achieves the best predictive performance. Analysis confirms that **YouTube** and **Facebook** advertising budgets have significant impacts on sales, while **newspaper** advertising does not.

## Requirements

- **R** (≥ 4.0)
- R packages: `caret`, `ggplot2`, `psych`, `datarium`

Install required packages with:
```r
install.packages(c("caret", "ggplot2", "psych", "datarium"))
```

## Usage

Run the scripts in the following order:

```r
source("Dataset.R")          # Explore and visualize the data
source("Split_Data.R")       # Create train/test splits
source("Linear_Regression.R") # Fit and evaluate linear regression models
source("kNN.R")              # Fit and evaluate kNN regression
```

