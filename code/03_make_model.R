here::i_am("code/03_make_model.R")

data_clean <- readRDS(
  file = here::here("output/data_clean.rds")
)
library(tidyverse)
library(gtsummary)
library(gt)

data_clean <- data_clean %>% arrange(DateTime)

# Split the data: first 80% as training, remaining 20% as testing
n <- nrow(data_clean)
train_index <- 1:floor(0.8 * n)
train_data <- data_clean[train_index, ]
test_data <- data_clean[(floor(0.8 * n) + 1):n, ]

model_full <- lm(C6H6.GT. ~ CO.GT. + `PT08.S1.CO.` + `PT08.S2.NMHC.`+ `PT08.S3.NOx.`
                 +`PT08.S4.NO2.`+ `PT08.S5.O3.`+ NMHC.GT. + NOx.GT. + NO2.GT. + T + RH + AH, data = train_data)

primary_regression_table <-
  tbl_regression(model_full) %>% 
  add_global_p() %>% 
  add_glance_source_note(
    include = c("sigma", "r.squared", "adj.r.squared", "statistic")
  )%>%
  as_gt() %>%
  tab_header(
    title = "Full Model Regression Analysis"
  )


# Perform stepwise selection using BIC
n_train <- nrow(train_data)
best_model_bic <- step(model_full, direction = "both", k = log(n_train))

best_regression_table <-
  tbl_regression(best_model_bic) %>% 
  add_global_p() %>% 
  add_glance_source_note(
    include = c("sigma", "r.squared", "adj.r.squared", "statistic")
  ) %>%
  as_gt() %>%
  tab_header(
    title = "Best Model Regression Analysis"
  )


predictions <- predict(best_model_bic , test_data)
mse <- mean((predictions - test_data$C6H6.GT.)^2)
rmse <- sqrt(mse)


saveRDS(
  primary_regression_table,
  file = here::here("output/primary_regression_table.rds")
)

saveRDS(
  best_regression_table,
  file = here::here("output/best_regression_table.rds")
)

saveRDS(
  rmse,
  file = here::here("output/rmse.rds")
)




