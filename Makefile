final_report.html: code/04_render_report.R final_project.Rmd descriptive_analysis
	Rscript code/04_render_report.R
	mv final_report.html final_report/

# Data cleaning
output/data_clean.rds: code/00_clean_data.R data/AirQualityUCI.csv
	Rscript code/00_clean_data.R

# Table creation
output/table_stats.rds: code/01_make_table.R output/data_clean.rds
	Rscript code/01_make_table.R

# Plots
output/corr_plot.png output/time_series_plot.png: code/02_make_plot.R output/data_clean.rds
	Rscript code/02_make_plot.R

# Model
output/best_regression_table.rds: code/03_make_model.R output/data_clean.rds
	Rscript code/03_make_model.R


.PHONY: descriptive_analysis
descriptive_analysis: output/best_regression_table.rds output/table_stats.rds output/corr_plot.png \
	output/time_series_plot.png


.PHONY: clean 
clean:
	rm -f output/*.rds && rm -f output/*.png && rm -f final_report/*.html
	
.PHONY: install
install:
	Rscript -e "renv::restore(prompt = FALSE)"

.PHONY: build_image
build_image:
	docker build -t final_project_image .
	
.PHONY: docker_run
docker_run:
	mkdir -p final_report
	docker run --rm -v "$$(pwd)/final_report":/project/final_report youweihu/final_project_image bash -c "make"

