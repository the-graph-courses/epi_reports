# Load necessary packages using pacman, which will install them if they're not already installed.
# - rmarkdown: For rendering R Markdown documents.
# - purrr: For functional programming tools.
# - stringr: For string manipulation.
pacman::p_load(rmarkdown, purrr, stringr, dplyr)

# Define a vector of countries for which the report will be generated.
# Each country in this vector will have a separate report.
countries <- c("Angola", "Nigeria", "Mali")

# Generate a tibble (data frame) containing the filenames and parameters for each report.
# - filename: Constructs the name of the output file for each report, based on the country name.
# - params: A list of parameters, where each list contains the country name to be passed to the R Markdown document.
reports <- tibble(
  filename = str_c("hiv_report_", countries, ".html"),
  params = map(countries, ~list(country = .))
)

# Use pwalk from the purrr package to iterate over each row in the 'reports' tibble.
# For each row, render the R Markdown document using the specified parameters.
# - output_file: The name of the file where the report will be saved.
# - params: The parameters passed to the R Markdown document, specifying the country for the report.
# - input: The path to the R Markdown template document.
# - output_dir: The directory where the rendered reports will be saved.
reports %>%
  select(output_file = filename, params) %>%
  pwalk(rmarkdown::render, input = "hiv_incidence_report.Rmd", output_dir = "output/")
