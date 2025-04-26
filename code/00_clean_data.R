library(here)
here::i_am("code/00_clean_data.R")

absolute_path_to_data <- here::here("data/AirQualityUCI.csv")
data <- read.csv(absolute_path_to_data, sep = ";", dec = ",", 
                 na.strings = c("NA", "-200"), header = TRUE)
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H.%M.%S")
library(tidyverse)
data <- data %>% select(-X, -X.1)
data_clean <- na.omit(data)


saveRDS(
  data_clean,
  file = here::here("output/data_clean.rds")
)
