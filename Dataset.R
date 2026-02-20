# =============================================================================
# Dataset.R
# Data loading, exploration, and visualization for the marketing dataset.
# =============================================================================

library(caret)
library(ggplot2)
library(psych)

# Load the marketing dataset from the datarium package
data(marketing, package = "datarium")

# Inspect dataset dimensions, structure, and summary statistics
dim(marketing)
str(marketing)     # Variable types and first few observations
summary(marketing) # Descriptive statistics; check for missing values

# Visualize the distribution of the outcome variable (sales)
ggplot(marketing, aes(sales)) +
  geom_histogram(binwidth = 2, fill = "steelblue", color = "white") +
  labs(title = "Distribution of Sales", x = "Sales", y = "Count")

# Pairwise scatterplot matrix: shows bivariate relationships and
# individual variable distributions simultaneously.
pairs.panels(
  marketing,
  method   = "pearson",
  hist.col = "steelblue",
  pch      = 21,
  density  = TRUE,
  ellipses = FALSE
)
# YouTube and Facebook budgets show strong positive correlations with sales;
# newspaper budget shows a comparatively weak association.
