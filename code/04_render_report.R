here::i_am("code/04_render_report.R")
library(rmarkdown)

render(
  input = here::here("final_project.Rmd"),
  output_file = "final_report.html"
)

