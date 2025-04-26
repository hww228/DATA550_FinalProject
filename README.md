# Air Quality Analysis Project

This repository contains a reproducible pipeline for analyzing air quality data collected in an Italian city from March 2004 to February 2005. The dataset includes hourly measurements of air pollutants and meteorological conditions. The analysis focuses on cleaning the data, summarizing key variables, visualizing patterns, and building regression models to predict benzene levels.

---

## Project Overview

This project performs the following steps:

1. **Data Cleaning** (`code/00_clean_data.R`)
2. **Descriptive Summary Table** (`code/01_make_table.R`)
3. **Visualizations** (`code/02_make_plot.R`)
4. **Modeling** (`code/03_make_model.R`)
5. **Final Report Rendering** (`code/04_render_report.R`)

All scripts save their outputs in the `output/` directory. The final report is rendered as `final_report.html` in the `final_report/` directory.

---

## How to Reproduce the Report Locally

This project uses [`renv`](https://rstudio.github.io/renv/) to ensure package reproducibility.

1.  Before building the project, confirm that you has the `renv` package installed, run the following code in Console:

``` r
"renv" %in% row.names(installed.packages())
```

If the above command returns `FALSE`, install the `renv` package using `install.packages("renv")` in Console.

2. Install necessary R packages (if needed):

```r
install.packages(c("here", "tidyverse", "yaml", "kableExtra", "gtsummary", "ggcorrplot", "gt", "broom.helpers", "cardx", "car", "parameters"))
```

3.  Restore package environment using the `renv.lock` file:

``` bash
make install
```
4.  Clean previous outputs (optional):

``` bash
make clean
```

5. Build the full project and generate `final_report/final_report.html`:

``` bash
make
```

---

## Docker Instructions

This project includes a Dockerfile that builds an image to fully reproduce the analysis inside a containerized environment.

1. How to Build the Docker Image

First, clone this repository:

``` bash
git clone git@github.com:hww228/DATA550_FinalProject.git
cd DATA550_FinalProject
```
Then, build the Docker image (you must have Docker installed):
``` bash
docker build -t final_project_image .
```
or simply:
``` bash
make build_image
```


2. DockerHub Image

You can also pull the pre-built image directly from DockerHub:
``` bash
docker pull youweihu/final_project_image
```
[DockerHub link](https://hub.docker.com/repositories/youweihu)


3. How to Run the Docker Container to Generate the Report

Use the Makefile target to run everything automatically:

``` bash
make docker_run
```
This will:
- Create a `final_report/` folder locally (if not already present)
- Mount it inside the container
- Run the project pipeline
- Output the generated `final_report.html` inside the `final_report/` folder.
After it finishes, you can find your report locally at `final_report/final_report.html`











