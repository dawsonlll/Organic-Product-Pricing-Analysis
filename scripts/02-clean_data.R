#### Preamble ####
# Purpose: Cleans the raw groceries data
# Author: Dingshuo Li
# Date: 25 Nov 2024 
# Contact: dawson.lir@utoronto.ca
# License: MIT
# Pre-requisites: The raw data is downloaded and is in folder
# Any other information needed? N/A

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)
library(lubridate)
library(dplyr)
library(stringr)

#### Clean data ####
raw_data <- read_csv("data/01-raw_data/hammer-4-raw.csv")
product_data <- read_csv("data/01-raw_data/hammer-4-product.csv")

joined_data <- raw_data %>%
  inner_join(product_data, by = c("product_id" = "id")) %>%
  select(nowtime,
         vendor,
         product_id,
         product_name,
         brand,
         current_price,
         old_price,
         units,
         price_per_unit)

cleaned_data <- joined_data %>%
  filter(vendor %in% c("Metro", "NoFrills", "Walmart", "Voila", "TandT", "Galleria")) %>%
  select(nowtime, vendor, current_price, old_price, product_name) %>%
  mutate(
    month = month(nowtime),
    current_price = parse_number(current_price), # Ensure numerical parsing
    old_price = parse_number(str_replace_all(old_price, "[^0-9.]", "")) # Remove non-numeric chars
  ) %>%
  filter(!is.na(current_price) & current_price > 0) %>% # Remove non-numeric or invalid values
  filter(str_detect(tolower(product_name), "organic")) %>%
  select(-nowtime) %>%
  tidyr::drop_na()

#### Save data ####
write_parquet(x = cleaned_data, sink = "data/02-analysis_data/analysis_data.parquet")

