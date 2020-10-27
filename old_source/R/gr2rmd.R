# TODO: Add comment
# 
# Author: Miguel Alvarez
###############################################################################


#' @name write_rmd
#' 
#' @title Write an r-markdown script
#' 
#' @description 
#' This function writes an Rmd script to be rendered by rmarkdown.
#' 
#' @keywords internals
#' 
## S3 generic
write_rmd <- function(gr)
	UseMethod("write_rmd", gr)

#' @keywords internal
#' 
## S4 generic
setGeneric("write_rmd", function(gr)
			standardGeneric("write_rmd"))

#' @keywords internal
#' 
## S3 method for class 'gr_list'
write_rmd.gr_list <- function(gr) {
	# Format single repo	
	repo_entry <- function(x) paste(c(paste0("# ", x$name, " (id: ", x$id,
								")\n"),
						paste0(x$description, "\n"),
						paste0(paste(x$keywords, collapse=" - "), "\n"),
						paste(x$links, collapse="\n\n"), "\n"), collapse="\n")
	# 
	
	
	gr <- unlist(lapply(gr, function(x)
						paste(c(x$name, x$description, x$keywords),
								collapse=" ")))
	return(gr)
}

#' @keywords internal
#' 
## S4 method for class 'gisrepos' (in S3 style)
gr2char.gisrepos <- function(gr) {
	gr <- gr2char(gr2list(gr))
	return(gr)
}




gr_rmd <- function(gr)