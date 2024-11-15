#### Preamble ####
# Purpose: Tests the structure and validity of the simulated grocery dataset 
# Author: Talia Fabregas, Lexi Knight, Fatimah Yunusa, Aliza Mithwani, Arav Agarwal
# Date: 14 November 2024
# Contact: fatimah.yunusa@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# - 00-simulate_data.R must have been run
# Any other information needed? Make sure you are in the `starter_folder` rproj

# Load libraries
library(dplyr)
library(testthat)

# Test function to validate simulation output
test_simulation <- function(sales_data, products, vendors, n_products, n_vendors, n_sales) {
  
  test_that("Data contains expected number of rows", {
    expect_equal(nrow(sales_data), n_sales)
  })
  
  test_that("ProductID should be within the range of defined products", {
    expect_true(all(sales_data$ProductID %in% products$ProductID))
  })
  
  test_that("Vendor names should match the provided list", {
    expect_true(all(sales_data$Vendor %in% vendors))
  })
  
  test_that("Original Price is always higher than Sale Price", {
    expect_true(all(sales_data$OriginalPrice >= sales_data$SalePrice))
  })
  
  test_that("DiscountPercent values are reasonable", {
    expect_true(all(sales_data$DiscountPercent >= 5 & sales_data$DiscountPercent <= 50))
    expect_equal(sum(is.na(sales_data$DiscountPercent)), 0)  # Ensure no NAs in DiscountPercent
  })
  
  test_that("Timestamps are within expected range", {
    date_range <- range(sales_data$Timestamp)
    expect_true(as.Date("2024-01-01") <= date_range[1] & date_range[2] <= as.Date("2024-12-31"))
  })
  
  test_that("Sale price calculation is correct", {
    calculated_sale_price <- sales_data$OriginalPrice * (1 - sales_data$DiscountPercent / 100)
    expect_equal(sales_data$SalePrice, calculated_sale_price)
  })
  
  test_that("Categories match the expected product categories", {
    expect_true(all(sales_data$Category %in% unique(products$Category)))
  })
  
  test_that("No duplicated sales entries for the same ProductID, Vendor, and Timestamp", {
    expect_equal(nrow(sales_data), nrow(distinct(sales_data, ProductID, Vendor, Timestamp)))
  })
  
}
