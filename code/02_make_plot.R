here::i_am("code/02_make_plot.R")
data_clean <- readRDS(
  file = here::here("output/data_clean.rds")
)

library(ggcorrplot)
library(tidyverse)

numeric_data <- data_clean %>% select_if(is.numeric)
corr_matrix <- cor(numeric_data)
corr_plot <- ggcorrplot(corr_matrix, lab = TRUE, lab_size = 1, title = "Correlation Matrix of Air Quality Variables")

library(ggplot2)
time_series_plot <- ggplot(data_clean, aes(x = DateTime, y = C6H6.GT.)) +
  geom_line(color = "blue") +
  labs(title = "Time Series of Benzene Concentration (C6H6.GT.)",
       x = "Date and Time",
       y = "Benzene Concentration") +
  theme_minimal()

ggsave(
  here::here("output/corr_plot.png"),
  plot = corr_plot,
  device = "png"
)
ggsave(
  here::here("output/time_series_plot.png"),
  plot = time_series_plot,
  device = "png"
)
