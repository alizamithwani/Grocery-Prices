#### Preamble ####
# Purpose: Cleans the raw data from
# Author: Talia Fabregas, Lexi Knight, Aliza Mithwani, Fatimah Yunusa
# Date: 14 November 2024
# Contact: talia.fabregas@mail.utoronto.ca
# License: MIT
# Pre-requisites: download the data in a SQLite file from https://jacobfilipp.com/hammer/
# Any other information needed? No

#### Workspace setup ####
library(tidyverse)
library(readr)
library(sqldf)
library(DBI)
library(RSQLite)
library(arrow)

#### Clean data ####
db_path <- "data/01-raw_data/hammer-2-processed.sqlite"
conn <- dbConnect(SQLite(), dbname = db_path)

# Get the names of all tables in the database
tables <- sqldf("SELECT name FROM sqlite_master WHERE type='table';", dbname = db_path)


joined_table <- dbGetQuery(
  conn,
  "
  SELECT nowtime, vendor, product_id, product_name, brand, current_price, old_price, units, price_per_unit, other 
  FROM raw
  INNER JOIN product
  ON raw.product_id = product.id
  WHERE vendor IN ('Loblaws', 'Walmart');
  "
)


#### Save data ####
write_parquet(joined_table, "data/02-analysis_data/cleaned_data.parquet")
