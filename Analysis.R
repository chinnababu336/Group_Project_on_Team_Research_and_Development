# Load required library
library(tidyverse)

# Load the dataset
food_data <- read_csv("Food_Costs_2013.csv")

# Knowing about the dataset
print(names(food_data))
print(colnames(food_data))

# Check for missing values
print(colSums(is.na(food_data)))

# Remove rows with all NA values in monthly columns
# Monthly columns (excluding first and last)
monthly_cols <- colnames(food_data)[2:13]

# Drop rows where all monthly values are missing
food_data <- food_data[rowSums(is.na(food_data[, monthly_cols])) < length(monthly_cols),]

# Remove rows where State_Agency is missing (e.g., empty Texas row)
food_data <- food_data[!is.na(food_data$State_Agency), ]


colnames(food_data) <- c("State_Agency",
                         "Oct_2012","Nov_2012","Dec_2012",
                         "Jan_2013","Feb_2013","Mar_2013",
                         "Apr_2013","May_2013","Jun_2013",
                         "Jul_2013","Aug_2013","Sep_2013",
                         "Cumulative_Cost")


monthly_cols_new <- c("Oct_2012","Nov_2012","Dec_2012",
                      "Jan_2013","Feb_2013","Mar_2013",
                      "Apr_2013","May_2013","Jun_2013",
                      "Jul_2013","Aug_2013","Sep_2013")

food_data[monthly_cols_new] <- lapply(food_data[monthly_cols_new],
                                      function(x) as.numeric(as.character(x)))

str(food_data)
summary(food_data)
head(food_data)
