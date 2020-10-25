#' @name gr2list
#' 
#' @title Coerce gisrepos objects into list
#' 
#' @description 
#' For convenience repositories will be organized in a list format, where each
#' element in the list corresponds to a repository entry.
#' 
#' @param gr An object of class [gisrepos-class].
#' @param ... Further arguments passed among methods.
#' 
#' @rdname gr2list
#' 
#' @exportMethod gr2list
#' 
if(!isGeneric("gr2list"))
	setGeneric("gr2list",
			function(gr, ...)
				standardGeneric("gr2list")
	)

#' @rdname gr2list
#' 
#' @aliases gr2list,gisrepos-method
#' 
setMethod("gr2list", signature(gr="gisrepos"),
		function(gr, ...) {
			# Preparing links
			fk_links <- gr@keys$fk_links
			fk_links$url <- gr@tables$links$url[match(fk_links$link_id,
							gr@tables$links$link_id)]
			# Preparing keys
			fk_keywords <- gr@keys$fk_keywords
			fk_keywords$kword <- gr@tables$keywords$kword[
					match(fk_keywords$kword_id, gr@tables$keywords$kword_id)]
			# Produce output lists
			# TODO: Avoid loop for efficiency
			OUT <- list()
			for(i in gr@tables$data_sets$id) {
				temp <- gr@tables$data_sets[gr@tables$data_sets$id == i, ]
				OUT[[paste(i)]] <- list(
						id=i,
						name=temp$name,
						description=temp$description,
						timestamp=temp$timestamp,
						links=fk_links$url[fk_links$id == i],
						keywords=fk_keywords$url[fk_keywords$id == i]
						)
			}
			# Defined as S3 class
			class(OUT) <- c("gr_list", "list")
			return(OUT)
		})
