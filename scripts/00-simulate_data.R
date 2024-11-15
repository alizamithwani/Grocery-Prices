#### Preamble ####
# Purpose: Simulates a dataset of grocery baskets
# Author: Talia Fabregas, Lexi Knight, Fatimah Yunusa, Aliza Mithwani, Arav Agarwal
# Date: 14 November 2024
# Contact: fatimah.yunusa@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj









```{r}
# Load library
install.packages(dplyr)
library(dplyr)

# Set parameters for the simulation
set.seed(400)  # For reproducibility
n_products <- 100  # Number of unique products
n_vendors <- 3  # Number of vendors
n_sales <- 300  # Total number of sale events

# Define product categories and vendors
product_categories <- c("Produce", "Dairy", "Bakery", "Snacks", "Beverages")
vendors <- c("Loblaws", "Sobeys", "Metro")

# Generate a data frame of products
products <- data.frame(
  ProductID = 1:n_products,
  Category = sample(product_categories, n_products, replace = TRUE),
  OriginalPrice = runif(n_products, min = 5, max = 50)  # Set a baseline price between 5 and 50
)

# Function to simulate sales data
simulate_sales <- function(products, vendors, n_sales) {
  sales_data <- data.frame(
    ProductID = sample(products$ProductID, n_sales, replace = TRUE),
    Vendor = sample(vendors, n_sales, replace = TRUE),
    Timestamp = as.Date('2024-01-01') + sample(0:365, n_sales, replace = TRUE),  # Random dates within a year
    DiscountPercent = sample(seq(5, 50, by = 5), n_sales, replace = TRUE)  # Discount percentages
  )
  
  # Merge with original prices and calculate sale price
  sales_data <- sales_data %>%
    left_join(products, by = "ProductID") %>%
    mutate(
      SalePrice = OriginalPrice * (1 - DiscountPercent / 100)
    ) %>%
    select(ProductID, Vendor, Category, OriginalPrice, SalePrice, DiscountPercent, Timestamp)
  
  return(sales_data)
}

# Simulate sales data
sales_data <- simulate_sales(products, vendors, n_sales)

# Display the first few rows of the simulated dataset
head(sales_data)

```