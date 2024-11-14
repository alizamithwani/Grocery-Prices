#### Preamble ####
# Purpose: Cleans the raw data from
# Author: Talia Fabregas, Lexi Knight, Aliza Mithwani, Fatimah Yunusa
# Date: 14 November 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
library(tidyverse)
library(readr)
library(sqldf)

#### Clean data ####
db_path <- "data/01-raw_data/hammer-2-processed.sqlite"

# get the products table
product <- sqldf("SELECT * FROM product", db=db_path)

# get the raw table
raw <- sqldf("SELECT * FROM raw", db=db_path)

#### Save data ####
# write_csv(cleaned_data, "outputs/data/analysis_data.csv")
