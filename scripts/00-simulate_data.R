#### Preamble ####
# Purpose: Simulates a dataset of grocery baskets
# Author: Talia Fabregas, Lexi Knight, Fatimah Yunusa, Aliza Mithwani, Arav Agarwal
# Date: 14 November 2024
# Contact: fatimah.yunusa@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


# Load library
library(dplyr)

# Set parameters for the simulation
set.seed(400)  # For reproducibility
n_products <- 10000  # Number of unique products
n_vendors <- 3  # Number of vendors
n_sales <- 300  # Total number of sale events

# Define product categories and vendors
product_categories <- c("Produce", "Dairy", "Bakery", "Snacks", "Beverages")
vendors <- c("Loblaws", "Sobeys", "Metro")
dates <- seq(as.Date("2024-01-01"), as.Date("2024-11-01"), by = "day")
time_sequence <- seq(from = as.POSIXct("00:00:00", format="%H:%M:%S"),
                     to = as.POSIXct("23:59:00", format="%H:%M:%S"),
                     by = "min")


simulated_data <- tibble(
  product_id = 1:n_products,
  date = sample(dates, n_products, replace=TRUE),
  time = sample(time_sequence, n_products, replace = TRUE),
  product_type = sample(product_categories, n_products, replace=TRUE),
  vendor = sample(vendors, n_products, replace=TRUE),
  original_price = runif(n_products, min = 5, max = 50),
  current_price = runif(n_products, min = 5, max = 50)
)

simulated_data <- simulated_data %>%
  arrange(date, time)

#### Save the simulated data ####
write_parquet(simulated_data, "data/00-simulated_data/simulated_data.parquet")
