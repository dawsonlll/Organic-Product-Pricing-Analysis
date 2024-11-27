#### Preamble ####
# Purpose: Explore data analysis
# Author: Dingshuo Li
# Date: 27 November, 2024
# Contact: dawson.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: analysis data is in the folder
# Any other information needed? N/A


#### Workspace setup ####
library(readr)
library(dplyr)
library(ggplot2)

#### Read data ####
analysis_data <- read_parquet("data/02-analysis_data/analysis_data.parquet")
### EDA ####

# Summarize the anlaysis data
summary(analysis_data)

# Frequency of categorical data like 'vendor'
table(analysis_data$vendor)

# Distribution of current_price
ggplot(analysis_data, aes(x = current_price)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black") +
  labs(title = "Distribution of Current Prices", x = "Current Price", y = "Frequency")

#  Outliers or trends in pricing between different vendors
ggplot(analysis_data, aes(x = vendor, y = current_price)) +
  geom_boxplot() +
  labs(title = "Current Prices by Vendor", x = "Vendor", y = "Current Price") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Compare old and current price
ggplot(analysis_data, aes(x = current_price, y = old_price)) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "lm", color = "red") +
  labs(title = "Comparison of Current and Old Prices", x = "Current Price", y = "Old Price")


# Products offered by Vendor.
ggplot(analysis_data, aes(x = vendor)) +
  geom_bar(fill = "blue") +
  labs(title = "Number of Products by Vendor", x = "Vendor", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Explore relationship
cor_analysis <- cor(analysis_data[, sapply(analysis_data, is.numeric)])
print(cor_analysis)



