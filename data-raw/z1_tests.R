# TODO: Add comment
# 
# Author: Miguel Alvarez
###############################################################################

remotes::install_github("kamapu/gisrepos")
library(gisrepos)

gr <- gisrepos:::gr2list(.gisrepos)


Test <- gr2char(gr)

Test2 <- gr2char(.gisrepos)

