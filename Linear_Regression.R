# =============================================================================
# Linear_Regression.R
# Fits and evaluates linear regression models (baseline and quadratic) for
# sales forecasting using the marketing dataset.
# =============================================================================

library(caret)
library(ggplot2)

# Load the marketing dataset
data(marketing, package = "datarium")

dim(marketing)
str(marketing)

# Create an 80/20 train/test split
set.seed(100)
training.idx <- sample(1:nrow(marketing), size = nrow(marketing) * 0.8)
train.data   <- marketing[training.idx, ]
test.data    <- marketing[-training.idx, ]

# -----------------------------------------------------------------------------
# Model 1: Baseline linear regression with all three predictors
# -----------------------------------------------------------------------------
lmodel <- lm(sales ~ ., data = train.data)
summary(lmodel)
# R² = 0.89: the model explains approximately 89% of the variance in sales.

predictions <- predict(lmodel, test.data)
RMSE(predictions, test.data$sales)
# RMSE ≈ 1.95

plot(test.data$sales, predictions,
     main = "Prediction Performance: Baseline Linear Regression",
     xlab = "Observed Sales", ylab = "Predicted Sales")
abline(0, 1, col = "red")

# Residual diagnostics
par(mfrow = c(2, 2))
plot(lmodel)
par(mfrow = c(1, 1))
# The residual plot reveals observation #131 as a potential outlier and
# suggests a quadratic trend, indicating that second-order terms may improve fit.

# -----------------------------------------------------------------------------
# Model 2: Quadratic regression — adding squared terms for youtube and facebook
# -----------------------------------------------------------------------------
lmodel.2 <- lm(
  sales ~ youtube + facebook + newspaper + I(youtube^2) + I(facebook^2),
  data = train.data
)
summary(lmodel.2)
# R² = 0.918

predictions <- predict(lmodel.2, test.data)
RMSE(predictions, test.data$sales)
# RMSE ≈ 1.95 — no meaningful improvement over the baseline model.

# -----------------------------------------------------------------------------
# Model 3: Quadratic regression with youtube × facebook interaction term
# -----------------------------------------------------------------------------
lmodel.2 <- lm(
  sales ~ youtube + facebook + newspaper +
    I(youtube^2) + I(youtube * facebook) + I(facebook^2),
  data = train.data
)
summary(lmodel.2)
# R² = 0.98: the model now explains nearly all variance in sales.
# youtube, youtube², and the youtube × facebook interaction are highly significant.

predictions <- predict(lmodel.2, test.data)
RMSE(predictions, test.data$sales)
# RMSE ≈ 0.51 — a substantial improvement over both earlier models.

plot(test.data$sales, predictions,
     main = "Prediction Performance: Quadratic Linear Regression",
     xlab = "Observed Sales", ylab = "Predicted Sales")
abline(0, 1, col = "red")
# Predicted values are closely aligned with observed sales.

# Residual diagnostics for the improved model
par(mfrow = c(2, 2))
plot(lmodel.2)
par(mfrow = c(1, 1))
# Residuals show no systematic pattern (horizontal band around zero).
# Observation #131 remains mildly influential but does not invalidate the model.
# This quadratic regression model is selected as the final model based on its low RMSE.
# Both YouTube and Facebook advertising budgets have statistically significant
# impacts on sales; newspaper does not.
