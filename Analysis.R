library(tidyverse)

# Load your dataset
food_data <- read_csv("Food_Costs_2013.csv")
names(food_data)

# renaming the first column to "State_Agency"
colnames(food_data)[1] <- "State_Agency"
# Renaming columns that contain the word "Cumulative" to "Cumulative_Cost"
food_data <- food_data %>%
  rename(
    Cumulative_Cost = matches("Cumulative", ignore.case = TRUE)
  )
names(food_data)
