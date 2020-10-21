#' @name gisrepos-class
#' 
#' @title An S4 class containing GIS-repositories
#' 
#' @description 
#' This class contains the list of repositories, respective links and categories
#' at slot **tables** plus their relationships at slot **keys** (analogous
#' to foreign keys).
#' 
#' @slot tables A list containing three data frames, namely **data_sets**
#'     (main table), **links** and **keywords** (categories).
#' @slot keys A list containing two data frames relating these three tables,
#'     namely **fk_links** and **fk_keywords**.
#' 
#' @author Miguel Alvarez
#' 
#' @exportClass gisrepos
#' 
setClass("gisrepos",
		# Slots
		slots=c(tables="list", keys="list"),
		# Prototype
		prototype=list(
				tables=list(
						data_sets=data.frame(
								id=integer(),
								name=character(),
								description=character(),
								timestamp=as.Date(NULL),
								stringsAsFactors=FALSE),
						links=data.frame(
								link_id=integer(),
								url=character(),
								stringsAsFactors=FALSE),
						keywords=data.frame(
								kword_id=integer(),
								kword=character(),
								stringsAsFactors=FALSE)),
				keys=list(
						fk_links=data.frame(
								id=integer(),
								link_id=integer()),
						fk_keywords=data.frame(
								id=integer(),
								kword_id=integer()))),
		# Validity checks
		validity=function(object) {
			# Column names in data_sets at tables
			c_names <- c("id", "name", "description", "timestamp")
			if(!all(c_names %in% colnames(object@tables$data_sets)))
				return(paste0("'", paste(c_names[1:(length(c_names) - 1)],
										collapse="', '"),
								"', and '", c_names[length(c_names)],"' are ",
								"mandatory in table 'data_sets'."))
			# Column names in links at tables
			c_names <- c("link_id", "url")
			if(!all(c_names %in% colnames(object@tables$links)))
				return(paste0("'", paste(c_names[1:(length(c_names) - 1)],
										collapse="', '"),
								"', and '", c_names[length(c_names)],"' are ",
								"mandatory in table 'links'."))
			# Column names in keywords at tables
			c_names <- c("kword_id", "kword")
			if(!all(c_names %in% colnames(object@tables$keywords)))
				return(paste0("'", paste(c_names[1:(length(c_names) - 1)],
										collapse="', '"),
								"', and '", c_names[length(c_names)],"' are ",
								"mandatory in table 'keywords'."))
			# Foreign key for links
			if(!all(object@keys$fk_links$id %in% object@tables$data_sets$id))
				return(paste0("Values of 'id' in 'fk_links' missing in ",
								"'data_sets'"))
			if(!all(object@keys$fk_links$link_id %in%
							object@tables$links$link_id))
				return(paste0("Values of 'link_id' in 'fk_links' missing in ",
								"'links'"))
			# Foreign key for keywords
			if(!all(object@keys$fk_keywords$id %in% object@tables$data_sets$id))
				return(paste0("Values of 'id' in 'fk_keywords' missing in ",
								"'data_sets'"))
			if(!all(object@keys$fk_keywords$kword_id %in%
							object@tables$keywords$kword_id))
				return(paste0("Values of 'kword_id' in 'fk_keywords' ",
								"missing in 'keywords'"))
		})
