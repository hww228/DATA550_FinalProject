here::i_am("code/01_make_table.R")

data_clean <- readRDS(
  file = here::here("output/data_clean.rds")
)

library(kableExtra)
library(tidyverse)
# Create a data frame with variable descriptions
variable_descriptions <- data.frame(
  Variable = c("CO(GT)", "PT08.S1(CO)", "C6H6(GT)", "PT08.S2(NMHC)", "NOx(GT)", 
               "PT08.S3(NOx)", "NO2(GT)", "PT08.S4(NO2)", "PT08.S5(O3)", "T", "RH", "AH"),
  Description = c("Carbon monoxide concentration (mg/m^3)", 
                  "Tin oxide sensor (CO) concentration", 
                  "Benzene concentration (μg/m^3)", 
                  "Titania sensor concentration (NMHC)", 
                  "Nitrogen oxides concentration (ppb)", 
                  "Tungsten oxide sensor concentration (NOx)", 
                  "Nitrogen dioxide concentration (μg/m^3)", 
                  "Tungsten oxide sensor concentration (NO2)", 
                  "Tungsten oxide sensor concentration (O3)", 
                  "Temperature (°C)", 
                  "Relative humidity (%)", 
                  "Absolute humidity (g/m^3)")
)

# Display the table
table_description <- kable(variable_descriptions, caption = "Description of Variables in the Air Quality Dataset")

#Select key variables for further analysis
key_vars <- data_clean %>% 
  select(CO.GT., `PT08.S1.CO.`, `PT08.S2.NMHC.`, `PT08.S3.NOx.`, `PT08.S4.NO2.`,
         `PT08.S5.O3.`, NMHC.GT., NO2.GT., RH)
summary_stats <- summary(key_vars) 

table_stats <- kable(summary_stats, caption = "Summary Statistics of Key Variables in Air Quality Dataset")


saveRDS(
  table_description,
  file = here::here("output/table_description.rds")
)

saveRDS(
  table_stats,
  file = here::here("output/table_stats.rds")
)

