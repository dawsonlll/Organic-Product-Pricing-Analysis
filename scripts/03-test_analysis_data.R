#### Preamble ####
# Purpose: Tests... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 26 September 2024 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(dplyr)
library(testthat)
library(readr)
setwd(here::here())

analysis_data <- read_csv("data/02-analysis_data/analysis_data.csv")


#### Test data ####
# Test that the dataset has 4275 rows
test_that("dataset has 4275 rows", {
  expect_equal(nrow(analysis_data), 4275)
})

# Test that the dataset has 5 columns
test_that("dataset has 5 columns", {
  expect_equal(ncol(analysis_data), 5)
})

# Test that the 'vendor' column is character type
test_that("'vendor' is character", {
  expect_type(analysis_data$vendor, "character")
})

# Test that the 'product_name' column is character type
test_that("'product_name' is character", {
  expect_type(analysis_data$product_name, "character")
})

# Test that the 'current_price' column is of numeric type
test_that("'current_price' is numeric", {
  expect_type(analysis_data$current_price, "double")  
})

# Test all current price are positive
test_that("Current prices are positive", {
  expect_true(all(analysis_data$current_price > 0))
})

# Test all product are organic
test_that("Only 'organic' products are included", {
  expect_true(all(grepl("organic", tolower(analysis_data$product_name))))
})

# Test list of expected vendors
expected_vendors <- c("Metro", "NoFrills", "Walmart", "Voila", "TandT", "Galleria")
test_that("Vendor list contains only specified vendors", {
  actual_vendors <- unique(analysis_data$vendor)
  expect_equal(sort(actual_vendors), sort(expected_vendors))
})

# Test that there are no missing values in the dataset
test_that("no missing values in dataset", {
  expect_true(all(!is.na(analysis_data)))
})

# Test that the 'month' column contains only valid months
valid_months <- 1:12  # since the data spans from month 1 to 12
test_that("'month' contains valid month numbers", {
  expect_true(all(analysis_data$month %in% valid_months))
})

# Test that there are no empty strings in 'vendor', 'product_name' columns
test_that("no empty strings in 'vendor', 'product_name' columns", {
  expect_false(any(analysis_data$vendor == "" | analysis_data$product_name == ""))
})
