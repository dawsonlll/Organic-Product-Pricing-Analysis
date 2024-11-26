#### Preamble ####
# Purpose: Tests the structure and validity of the simulated groceries data
# Author: Dingshuo Li
# Date: 25 November, 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the rproj


#### Workspace setup ####
library(tidyverse)

test_simulate_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
if (exists("test_simulate_data")) {
  message("Test Passed: The dataset was successfully loaded.")
} else {
  stop("Test Failed: The dataset could not be loaded.")
}


#### Test data ####

# Check if the dataset has 10000 rows
if (nrow(test_simulate_data) == 10000) {
  message("Test Passed: The dataset has 10000 rows.")
} else {
  stop("Test Failed: The dataset does not have 10000 rows.")
}

# Check if the dataset has 5 columns
if (ncol(test_simulate_data) == 5) {
  message("Test Passed: The dataset has 5 columns.")
} else {
  stop("Test Failed: The dataset does not have 3 columns.")
}

# Check if 'month' column contains only valid months
valid_months <- 1:12
if (all(test_simulate_data$month %in% valid_months)) {
  message("Test Passed: The 'month' column contains only valid month numbers.")
} else {
  stop("Test Failed: The 'month' column contains invalid month numbers.")
}

# Check if there are any missing values in the dataset
if (all(!is.na(test_simulate_data))) {
  message("Test Passed: The dataset contains no missing values.")
} else {
  stop("Test Failed: The dataset contains missing values.")
}

# Check if there are no empty strings in vendor.
if (all(test_simulate_data$vendor != "")) {
  message("Test Passed: There are no empty strings in vendor.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Check if there are no empty strings in product_name.
if (all(test_simulate_data$product_name != "")) {
  message("Test Passed: There are no empty strings in product_name.")
} else {
  stop("Test Failed: There are empty strings in one or more columns.")
}

# Ensure current_price is always greater or equal to 0.
if (all(test_simulate_data$current_price >= 0)) {
  message("Test Passed: Current prices are always greater or equal to 0.")
} else {
  stop("Test Failed: Some current prices are less than 0.")
}

# Ensure old_price is always greater or equal to 0.
if (all(test_simulate_data$old_price >= 0)) {
  message("Test Passed: Old prices are always greater or equal to 0.")
} else {
  stop("Test Failed: Old current prices are less than 0.")
}

