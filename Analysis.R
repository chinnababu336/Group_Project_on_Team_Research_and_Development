library(tidyverse)

# Load the dataset
food_data <- read_csv("Food_Costs_2013.csv")

# Check column names
names(food_data)

# Rename first column to State_Agency
colnames(food_data)[1] <- "State_Agency"

# Rename cumulative column automatically
food_data <- food_data %>%
  rename(
    Cumulative_Cost = matches("Cumulative", ignore.case = TRUE)
  )

# Verify the changes yourself
names(food_data)
