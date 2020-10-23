#' @name summary
#' 
#' @title Summary of gisrepos object
#' 
#' @description
#' A brief overview of the content of the object. This overview will be also
#' printed in the console when calling it as a symbol.
#' 
#' @param object,x A [gisrepos-class] object.
#' @param ... Further arguments passed among methods.
#' 
#' @rdname summary
#' 
#' @exportMethod summary
#' 
if(!isGeneric("summary"))
	setGeneric("summary",
			function(object, ...)
				standardGeneric("summary")
	)

#' @rdname summary
#' 
#' @aliases summary,gisrepos-method
#' 
setMethod("summary", signature(object="gisrepos"),
		function(object, ...) {
			cat(paste0("## Object of class 'gisrepos'\n",
							"## Number of repositories: ",
							nrow(object@tables$data_sets), "\n\n",
							"## Categories\n"))
			# Statistics of categories
			Stats <- aggregate(formula=id ~ kword_id,
					data=object@keys$fk_keywords, FUN=length)
			Stats <- Stats[order(Stats$id, decreasing=TRUE), ]
			# Print categories
			for(i in Stats$kword_id) {
				cat(paste0("   ", object@tables$keywords$kword[
										object@tables$keywords$kword_id == i],
								": ",
								Stats$id[Stats$kword_id == i],
								"\n")
				)}
		}
)

#' @rdname summary
#' 
#' @aliases show,gisrepos-method
#' 
#' @exportMethod show
#' 
setMethod("show", signature(object="gisrepos"),
		function(object) {
			summary(object)
		}
)

#' @exportMethod print
#' 
if(!isGeneric("print"))
	setGeneric("print",
			function(x, ...)
				standardGeneric("print")
	)

#' @rdname summary
#' 
#' @aliases print,gisrepos-method
#' 
setMethod("print", signature(x="gisrepos"),
		function(x, ...) {
			summary(x, ...)
		}
)

