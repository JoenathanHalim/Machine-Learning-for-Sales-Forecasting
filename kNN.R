# =============================================================================
# kNN.R
# Fits and evaluates a k-Nearest Neighbors regression model for sales
# forecasting using the marketing dataset.
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
# kNN Regression with 4-fold cross-validation
# -----------------------------------------------------------------------------
# The training set contains 160 observations. With 4-fold CV, each fold holds
# 40 observations — a reasonable minimum for a dataset of this size.
# Ten candidate values of k are evaluated to identify the optimal neighborhood size.
set.seed(101)
model <- train(
  sales ~ .,
  data       = train.data,
  method     = "knn",
  trControl  = trainControl("cv", number = 4),
  preProcess = c("center", "scale"),
  tuneLength = 10
)

# Plot cross-validation RMSE across candidate values of k
plot(model)

# Best k selected by cross-validation
model$bestTune
# k = 5

# Evaluate prediction error on the held-out test set
predictions <- predict(model, test.data)
RMSE(predictions, test.data$sales)
# RMSE ≈ 1.37

# Visualize prediction performance
plot(test.data$sales, predictions,
     main = "Prediction Performance: kNN Regression",
     xlab = "Observed Sales", ylab = "Predicted Sales")
abline(0, 1, col = "red")
# The kNN model achieves accurate predictions with k = 5 neighbors.

