# TODO:   For updating the .gisrepos object
# 
# Author: Miguel Alvarez
################################################################################

library(gisrepos)


.gisrepos$data_sets$timestamp <- Sys.Date()

.gisrepos <- new("gisrepos",
		tables=with(.gisrepos, list(data_sets=data_sets, links=links,
						keywords=keywords)),
		keys=with(.gisrepos, list(fk_links=fk_links, fk_keywords=fk_keywords)))
