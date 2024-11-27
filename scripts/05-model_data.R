#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
first_model <- stan_glm(
  formula = current_price ~ month + old_price + vendor,  # Defines the regression model
  data = analysis_data,                                 # Specifies the dataset
  family = gaussian(),                                  # Assumes a normal distribution for the response variable
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE), # Sets normal priors for coefficients
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE), # Sets normal prior for the intercept
  prior_aux = exponential(rate = 1, autoscale = TRUE), # Sets exponential prior for auxiliary parameters (e.g., error SD)
  seed = 304                                         # Ensures reproducibility
)

second_model <- stan_glm(
  formula = current_price ~ month + current_price + vendor,  # Defines the regression model
  data = analysis_data,                                 # Specifies the dataset
  family = gaussian(),                                  # Assumes a normal distribution for the response variable
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE), # Sets normal priors for coefficients
  prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE), # Sets normal prior for the intercept
  prior_aux = exponential(rate = 1, autoscale = TRUE), # Sets exponential prior for auxiliary parameters (e.g., error SD)
  seed = 304                                         # Ensures reproducibility
)

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)

saveRDS(
  second_model,
  file = "models/second_model.rds"
)

