# Load required library
library(tidyverse)

# Load the dataset
food_data <- read_csv("Food_Costs_2013.csv")

# Knowing about the dataset
print(head(food_data))
#printing the columns names in the dataset
print(colnames(food_data))

# Check for missing values
print(colSums(is.na(food_data)))

# Remove rows with all NA values in monthly columns
# Monthly columns (excluding first and last)
monthly_cols <- colnames(food_data)[2:13]

# Drop rows where all monthly values are missing
food_data <- food_data[rowSums(is.na(food_data[, monthly_cols])) < length(monthly_cols),]

# Handle the Texas duplicate row (row 41 is empty, row 42 has data)
food_data <- food_data[!is.na(food_data$State_Agency), ]

# Rename columns for easier handling
colnames(food_data) <- c("State_Agency",
                         "Oct_2012","Nov_2012","Dec_2012",
                         "Jan_2013","Feb_2013","Mar_2013",
                         "Apr_2013","May_2013","Jun_2013",
                         "Jul_2013","Aug_2013","Sep_2013",
                         "Cumulative_Cost")

# Convert monthly columns to numeric (handle any remaining issues)
monthly_cols_new <- c("Oct_2012","Nov_2012","Dec_2012",
                      "Jan_2013","Feb_2013","Mar_2013",
                      "Apr_2013","May_2013","Jun_2013",
                      "Jul_2013","Aug_2013","Sep_2013")
# column variables changes into numeric
for(col in monthly_cols_new) {
  food_data[[col]] <- as.numeric(food_data[[col]])
}
