# Automating GESIS EU SILC setup routines in R
This script serves as a master script to the R version of the [GESIS setup routines](https://www.gesis.org/en/missy/materials/EU-SILC/setups) for the EU-SILC. Please adjust accordingly, depening on version of the setup routines and version of the panel. 

The required inputs are four directories and the script version you are using (see titles of the scripts)
1. The directory where the CSV files are saved, grouped by country and year.
2. The directory where the scripts are saved.
3. The directory where the .rda files should be saved.
4. The directory where the R packages are saved (retrieve with command .libPaths())
