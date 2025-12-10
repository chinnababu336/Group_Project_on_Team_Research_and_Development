library(tidyverse)

# Load your dataset
food_data <- read_csv("Food_Costs_2013.csv")
names(food_data)
# changeing the first column name
colnames(food_data)[1] <- "State_Agency"
# changing the last column name
food_data <- food_data %>%
  rename(
    Cumulative_Cost = matches("Cumulative", ignore.case = TRUE)
  )

names(food_data)
