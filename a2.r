library(tidyverse)
library(janitor)
library(lubridate)

crashes <- read_csv("Motor_Vehicle_Collisions_-_Crashes_20241107.csv")  %>% clean_names()

clean_crashes <- crashes  %>%
  mutate(date = as.Date(crash_date, "%m/%d/%Y"), "%Y%m%d") # fixing dates so they have YYYY MM DD format for sortability

# converting cyclists killed/injured columns from strings to ints
clean_crashes$number_of_cyclist_killed = as.numeric(clean_crashes$number_of_cyclist_killed)
clean_crashes$number_of_cyclist_injured = as.numeric(clean_crashes$number_of_cyclist_injured)

cutoff_date <- as.Date("2023-01-01")


# filtering out every data point thats too old and does not involve cyclists
selected_crashes <- clean_crashes  %>% 
  filter(( number_of_cyclist_killed >= 1 | number_of_cyclist_injured >= 1) & as.Date(date) >= cutoff_date & (!is.na(latitude) & !is.na(longitude))) %>% 
  select(number_of_cyclist_injured, number_of_cyclist_killed, borough, zip_code, latitude, longitude, date)

selected_crashes  %>% write_csv("MVC_cleaned.csv")