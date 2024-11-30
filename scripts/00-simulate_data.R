 #### Preamble ####
# Purpose: Simulates a dataset of Jacob Filipp's groceries 
# Author: Dingshuo Li
# Date: 25 November 2024
# Contact: dawson.li@utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
set.seed(304)


#### Simulate data ####
n <- 10000  # Number of rows to simulate
vendors <- c("Metro", "Walmart", "NoFrills", "TandT")
products <- c("Organic", "Non-Organic")
months <- 1:12


simulated_data <- data.frame(
  vendor = sample(vendors, n, replace = TRUE),
  current_price = round(runif(n, min = 0.5, max = 50), 2),
  old_price = round(runif(n, min = 1.5, max = 60), 2),
  product_name = sample(products, n, replace = TRUE),
  month = sample(months, n, replace = TRUE)
)

write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")

