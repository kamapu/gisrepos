# TODO:   For updating the .gisrepos object
# 
# Author: Miguel Alvarez
################################################################################

library(gisrepos)

# Formatting to data frame
Data <- gisrepos:::read_template("data-raw/gisrepos.ods") # Set next after installing
## Data <- gisrepos:::read_template("data-raw/gisrepos.xlsx", stringsAsFactors=FALSE)

Data <- gisrepos:::df2data(Data)
## Data <- gisrepos:::df2data(Data)

.gisrepos <- Data

# Into new class
## source("R/gisrepos-class.R")

save(.gisrepos, file="data/gisrepos.rda")
