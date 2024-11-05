# Define the parameters
start_year <- 2004
end_year <- 2021
types <- c("d", "h", "p", "r")
script_version <- "ver_2023_release2_v2"
base_dir <- "/Users/maxreichert/SURF/12_PhD/12_data_analysis/12_datadir/eusilc/00_scripts_routines/cross_setup/r" # Path where R scripts are stored
csv_path <- "/Users/maxreichert/SURF/12_PhD/12_data_analysis/12_datadir/eusilc/10_csv_og/Cross" # Path to CSV files
rda_path <- "/Users/maxreichert/SURF/12_PhD/12_data_analysis/12_datadir/eusilc/cross_rda" # Path where RDA files will be saved
package_dir <- "/Library/Frameworks/R.framework/Versions/4.4-arm64/Resources/library" # Path to R packages

# Load necessary libraries
library(plyr)
library(sjlabelled)

# Function to modify and source each script
run_script <- function(year, type) {
  script_name <- sprintf("%d_cross_eu_silc_%s_%s.r", year, type, script_version)
  script_path <- file.path(base_dir, script_name)
  rda_file <- file.path(rda_path, gsub(".r$", ".rda", script_name))
  
  # Read the script
  script_content <- readLines(script_path)
  
  # Remove everything above the configuration end line
  config_end_index <- grep("# CONFIGURATION SECTION - End", script_content)
  script_content <- script_content[(config_end_index + 1):length(script_content)]
  
  # Modify the configuration section
  script_content <- c(
    sprintf('csv_path <- "%s"', csv_path),
    sprintf('rda_file <- "%s"', rda_file),
    sprintf('.libPaths("%s")', package_dir),
    script_content
  )
  
  # Write the modified script to a temporary file
  temp_script_path <- tempfile()
  writeLines(script_content, temp_script_path)
  
  # Debug: Print the modified script content to check before executing
  cat(readLines(temp_script_path), sep = "\n")
  
  # Source the temporary script
  source(temp_script_path)
  
  # Remove the temporary file
  unlink(temp_script_path)
}

# Loop through each year and type, running the corresponding script
for (year in start_year:end_year) {
  for (type in types) {
    run_script(year, type)
  }
}

# Notify completion
print("All scripts have been processed successfully.")
