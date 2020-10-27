# TODO:   Write data set for package 'gisrepos'
# 
# Author: Miguel Alvarez
################################################################################

## # Install and load package
## remotes::install_github("kamapu/gisrepos")
## library(gisrepos)

# Import reference list
# TODO: In a final version the object will be imported from On-Line database
load("data-raw/gisrepos_list.rda")
gisrepos_list$data_sets$timestamp <- Sys.Date()

# creates a new object using the prototype
.gisrepos <- with(gisrepos_list, new("gisrepos",
				tables=list(
						data_sets=data_sets,
						links=links,
						keywords=keywords),
				keys=list(
						fk_links=fk_links,
						fk_keywords=fk_keywords)))

# In case of duplicated names
.gisrepos@tables$data_sets$name[duplicated(.gisrepos@tables$data_sets$name)] <-
		with(.gisrepos@tables, {
					paste(data_sets$name[duplicated(data_sets$name)], "(dupl)")
		})

# write object
save(.gisrepos, file="data/gisrepos.rda")
