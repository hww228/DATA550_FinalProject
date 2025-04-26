FROM rocker/tidyverse

RUN apt-get update && apt-get install -y libnode-dev pandoc cmake && rm -rf /var/lib/apt/lists/*


RUN mkdir /project
WORKDIR /project

RUN mkdir -p renv
COPY renv.lock renv.lock
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
RUN mkdir renv/.cache
ENV RENV_PATHS_CACHE renv/.cache
RUN Rscript -e "renv::restore(prompt = FALSE)"

RUN mkdir code
RUN mkdir output
RUN mkdir data

COPY data data
COPY code code
COPY Makefile .
COPY final_project.Rmd .



RUN mkdir final_report
RUN apt-get update && apt-get install -y libnode-dev pandoc cmake && rm -rf /var/lib/apt/lists/*

# Due to file system constraints during containerized execution, 
# the `mv final_report.html final_report/` operation is handled within the Makefile rather than inside the Dockerfile.
# Although the Dockerfile retains the mv command for redundancy, 
# the Makefile ensures correct file management without requiring a full Docker image rebuild,
# which is super time-consuming
CMD make && mv final_report.html final_report


