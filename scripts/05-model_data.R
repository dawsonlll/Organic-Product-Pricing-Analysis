#### Preamble ####
# Purpose: Create Bayesian Model
# Author: Dingshuo Li
# Date: 01 December, 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: analysis_data is saved as parquet in data files
# Any other information needed? N/A


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
bayesian_price_model <- stan_glm(
  formula = current_price ~ month + old_price + vendor,  # Defines the regression model
  data = analysis_data,                                 # Specifies the dataset
  family = gaussian(),                                  # Assumes a normal distribution for the response variable
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE), # Sets normal priors for coefficients
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE), # Sets normal prior for the intercept
  prior_aux = exponential(rate = 1, autoscale = TRUE), # Sets exponential prior for auxiliary parameters (e.g., error SD)
  seed = 304                                         # Ensures reproducibility
)


#### Save model ####
saveRDS(
  bayesian_price_model,
  file = "models/bayesian_price_model.rds"
)

