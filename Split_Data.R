# =============================================================================
# Split_Data.R
# Splits the marketing dataset into training (80%) and test (20%) sets.
# =============================================================================

library(caret)
library(ggplot2)

# Load the marketing dataset
data(marketing, package = "datarium")

dim(marketing)
str(marketing)

# Create an 80/20 train/test split using a fixed random seed for reproducibility
set.seed(100)
training.idx <- sample(1:nrow(marketing), size = nrow(marketing) * 0.8)
train.data   <- marketing[training.idx, ]
test.data    <- marketing[-training.idx, ]
