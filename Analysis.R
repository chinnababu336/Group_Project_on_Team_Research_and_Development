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

# Rename columns for easier handling
colnames(food_data) <- c("State_Agency",
                         "Oct_2012","Nov_2012","Dec_2012",
                         "Jan_2013","Feb_2013","Mar_2013",
                         "Apr_2013","May_2013","Jun_2013",
                         "Jul_2013","Aug_2013","Sep_2013",
                         "Cumulative_Cost")

# Handle the Texas duplicate row (row 41 is empty, row 42 has data)
food_data <- food_data[!is.na(food_data$State_Agency), ]

# Convert monthly columns to numeric (handle any remaining issues)
monthly_cols_new <- c("Oct_2012","Nov_2012","Dec_2012",
                      "Jan_2013","Feb_2013","Mar_2013",
                      "Apr_2013","May_2013","Jun_2013",
                      "Jul_2013","Aug_2013","Sep_2013")
# column variables changes into numeric
for(col in monthly_cols_new) {
  food_data[[col]] <- as.numeric(food_data[[col]])
}

# Remove rows where State_Agency name is empty or NA
food_data <- food_data[!is.na(food_data$State_Agency) & food_data$State_Agency != "", ]
cat("\nTotal number of agencies:", nrow(food_data), "\n")

# Calculate total costs by month
monthly_totals <- food_data %>%
  select(all_of(monthly_cols_new)) %>%
  colSums(na.rm = TRUE)
print(monthly_totals)

# Overall statistics
cat("\nOverall Statistics for Monthly Costs:\n")
all_monthly_values <- unlist(food_data[, monthly_cols_new])
all_monthly_values <- all_monthly_values[!is.na(all_monthly_values)]
cat("Mean:", mean(all_monthly_values), "\n")
cat("Median:", median(all_monthly_values), "\n")
cat("Standard Deviation:", sd(all_monthly_values), "\n")
cat("Minimum:", min(all_monthly_values), "\n")
cat("Maximum:", max(all_monthly_values), "\n")

cat("\nADDITIONAL INSIGHTS\n")
# Identify state agencies vs tribal organizations
state_agencies <- food_data %>%
  filter(!grepl("Indian|Tribal|Nation|Pueblo|Tribe|Sioux|Cherokee|Choctaw|Chickasaw|Creek|Potawatomi|Osage|Otoe|Wichita|Caddo|Delaware|Acoma|Laguna|Pueblos|Isleta|San Felipe|Santo Domingo|Zuni|Navajo|Ute|Omaha|Santee|Winnebago|Standing Rock|Three Affiliated|Cheyenne River|Rosebud|Northern Arapahoe|Shoshone|Inter-Tribal", State_Agency, ignore.case = TRUE))

tribal_orgs <- food_data %>%
  filter(grepl("Indian|Tribal|Nation|Pueblo|Tribe|Sioux|Cherokee|Choctaw|Chickasaw|Creek|Potawatomi|Osage|Otoe|Wichita|Caddo|Delaware|Acoma|Laguna|Pueblos|Isleta|San Felipe|Santo Domingo|Zuni|Navajo|Ute|Omaha|Santee|Winnebago|Standing Rock|Three Affiliated|Cheyenne River|Rosebud|Northern Arapahoe|Shoshone|Inter-Tribal",State_Agency, ignore.case = TRUE))

cat("\nNumber of State Agencies:", nrow(state_agencies), "\n")
cat("Number of Tribal Organizations:", nrow(tribal_orgs), "\n")

cat("\nTotal Cost - State Agencies:", sum(state_agencies$Cumulative_Cost, na.rm = TRUE), "\n")
cat("Total Cost - Tribal Organizations:", sum(tribal_orgs$Cumulative_Cost, na.rm = TRUE), "\n")
