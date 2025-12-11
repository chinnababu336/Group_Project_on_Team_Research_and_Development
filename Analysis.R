# Load required library
library(tidyverse)

# ======================================================
# 1. Load the dataset
# ======================================================
food_data <- read_csv("Food_Costs_2013.csv")

# Display original column names
print(names(food_data))

# ======================================================
# 2. Rename key columns
# ======================================================

# Rename first column to a meaningful name
colnames(food_data)[1] <- "State_Agency"

# Standardize the cumulative cost column name
food_data <- food_data %>%
  rename(
    Cumulative_Cost = matches("Cumulative", ignore.case = TRUE)
  )

# Show updated column structure
print(names(food_data))

# ======================================================
# 3. Remove rows with no monthly data
# ======================================================

# Identify monthly columns (Oct 2012 – Sep 2013)
monthly_cols <- colnames(food_data)[2:13]

# Drop rows where all monthly values are missing
food_data <- food_data[rowSums(is.na(food_data[, monthly_cols])) < length(monthly_cols), ]

# ======================================================
# 4. Remove empty or duplicate entries
# ======================================================

# Remove rows where State_Agency is missing (e.g., empty Texas row)
food_data <- food_data[!is.na(food_data$State_Agency), ]

# ======================================================
# 5. Assign consistent names to monthly columns
# ======================================================
colnames(food_data) <- c("State_Agency",
                         "Oct_2012","Nov_2012","Dec_2012",
                         "Jan_2013","Feb_2013","Mar_2013",
                         "Apr_2013","May_2013","Jun_2013",
                         "Jul_2013","Aug_2013","Sep_2013",
                         "Cumulative_Cost")

# ======================================================
# 6. Convert monthly cost values to numeric
# ======================================================
monthly_cols_new <- c("Oct_2012","Nov_2012","Dec_2012",
                      "Jan_2013","Feb_2013","Mar_2013",
                      "Apr_2013","May_2013","Jun_2013",
                      "Jul_2013","Aug_2013","Sep_2013")

food_data[monthly_cols_new] <- lapply(food_data[monthly_cols_new],
                                      function(x) as.numeric(as.character(x)))

# ======================================================
# 7. Inspect the cleaned dataset
# ======================================================
str(food_data)
summary(food_data)
head(food_data)
