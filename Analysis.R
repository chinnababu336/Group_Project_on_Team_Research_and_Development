library(tidyverse)

# 1. Load dataset
food_data <- read_csv("Food_Costs_2013.csv")

# Show original column names
print(names(food_data))

# 2. Rename key columns

# Rename first column to State_Agency
colnames(food_data)[1] <- "State_Agency"

# Rename cumulative column (matches anything with "Cumulative")
food_data <- food_data %>%
  rename(
    Cumulative_Cost = matches("Cumulative", ignore.case = TRUE)
  )

# Check names after rename
print(names(food_data))


# 3. Remove rows that are completely NA for monthly columns
monthly_cols <- colnames(food_data)[2:13]  # monthly columns

# Remove rows where all monthly values = NA
food_data <- food_data[rowSums(is.na(food_data[, monthly_cols])) < length(monthly_cols), ]

# 4. Remove empty duplicate row (Texas issue)
food_data <- food_data[!is.na(food_data$State_Agency), ]


# 5. Rename monthly columns explicitly

colnames(food_data) <- c("State_Agency",
                         "Oct_2012","Nov_2012","Dec_2012",
                         "Jan_2013","Feb_2013","Mar_2013",
                         "Apr_2013","May_2013","Jun_2013",
                         "Jul_2013","Aug_2013","Sep_2013",
                         "Cumulative_Cost")


# 6. Convert monthly columns to numeric

monthly_cols_new <- c("Oct_2012","Nov_2012","Dec_2012",
                      "Jan_2013","Feb_2013","Mar_2013",
                      "Apr_2013","May_2013","Jun_2013",
                      "Jul_2013","Aug_2013","Sep_2013")

food_data[monthly_cols_new] <- lapply(food_data[monthly_cols_new],
                                      function(x) as.numeric(as.character(x)))


# 7. Verify final cleaned dataset

str(food_data)
summary(food_data)
head(food_data)
