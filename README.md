# Air Quality Analysis Project

This repository contains a reproducible pipeline for analyzing air quality data collected in an Italian city from March 2004 to February 2005. The dataset includes hourly measurements of air pollutants and meteorological conditions. The analysis focuses on cleaning the data, summarizing key variables, visualizing patterns, and building regression models to predict benzene levels.

------------------------------------------------------------------------

## Project Overview

This project performs the following steps:

1.  **Data Cleaning**
    -   Merges date and time into a single `DateTime` column\
    -   Removes rows/columns with only missing values\
    -   Saves cleaned data as `data_clean.rds`
2.  **Descriptive Summary Table**
    -   `code/01_make_table.R` creates two tables:
        -   A variable description table\
        -   A summary statistics table for key variables
3.  **Visualizations**
    -   `code/02_make_plot.R` generates:
        -   A **correlation heatmap** of numeric variables (`corr_plot.png`)\
        -   A **time series plot** of benzene concentration (`time_series_plot.png`)
4.  **Modeling**
    -   `code/03_make_model.R` fits a full linear regression model to predict benzene\
    -   Applies **BIC-based stepwise selection** to choose the best model\
    -   Outputs regression summary tables and calculates RMSE
5.  **Final Report**
    -   Compiled using `final_project.Rmd`\
    -   Summarizes the methodology, EDA, and modeling results\
    -   Output: `final_report.html`

------------------------------------------------------------------------

## How to Reproduce
### Package Environment Setup

This project also uses [`renv`](https://rstudio.github.io/renv/) to ensure package reproducibility.

1.  Before building the project, confirm that you has the `renv` package installed, run the following code in Console:

``` r
"renv" %in% row.names(installed.packages())
```

If the above command returns `FALSE`, install the `renv` package using `install.packages("renv")` in Console.

2.  To restore the project-specific package environment using the `renv.lock` file, run:

``` bash
make install
```

This will ensure all required packages are installed with the correct versions for full reproducibility.

### Requirements

1.  Make sure you have R and the following packages installed first, run:

``` r
install.packages(c("here", "tidyverse", "yaml", "kableExtra", "gtsummary", "ggcorrplot", "gt", "broom.helpers", "cardx", "car", "parameters"))
```

2.  To reproduce the full analysis and generate the final report from scratch, execute the following commands in your project root:

``` bash
make clean
```

This will clean previously generated outputs.

3.  Then to build the entire project pipeline (data cleaning, tables, plots, models, and report), run:

``` bash
make 
```

This will re-run all necessary scripts and render the final report as `final_report.html`.


