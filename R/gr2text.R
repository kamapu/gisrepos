#' @name gr2char
#' 
#' @title Gisrepos to text
#' 
#' @description 
#' Internal function to extract a character vector from gisrepos object.
#' 
#' @keywords internal
#' 
## S3 generic
gr2char <- function(gr)
	UseMethod("gr2char", gr)

#' @keywords internal
#' 
## S4 generic
setGeneric("gr2char", function(gr)
			standardGeneric("gr2char"))

#' @keywords internal
#' 
## S3 method for class 'gr_list'
gr2char.gr_list <- function(gr) {
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
