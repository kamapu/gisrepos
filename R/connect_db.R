#' @name connect_db
#' 
#' @title Connect to PostgreSQL database
#' 
#' @description
#' This function opens a prompt to insert connection details to a PostgreSQL
#' database. Alternatively the package `RPostgres` or `RPostgreSQL` can be used
#' (see argument `package`).
#' 
#' @param dbname,host,port,user,password Each a character value passed to
#'     [DBI::dbConnect()]. They can also be modified in the prompt.
#' @param package A character value indicating the name of the package to be
#'     used for connecting the database (either "RPostgres" or "RPostgreSQL").
#' @param ... Further arguments passed to [DBI::dbConnect()].
#' 
#' @author Miguel Alvarez
#' 
#' @references 
#'     http://r.789695.n4.nabble.com/tkentry-that-exits-after-RETURN-tt854721.html#none
#'     https://gist.github.com/mages/2aed2a053e355e3bfe7c#file-getlogindetails-r
#'     Dalgaard (2001)
#' 
#' @export connect_db
#' 
connect_db <- function(dbname="", host="localhost", port="5432", user="",
		password="", package=c("RPostgres", "RPostgreSQL"), ...) {
	# Top level
	tt <- tktoplevel()
	tkwm.title(tt, "Connect Database")
	# Preset values
	DB <- tclVar(dbname)
	Host <- tclVar(host)
	Port <- tclVar(port)
	User <- tclVar(user)
	Password <- tclVar(password)
	# Labels
	label_DB <- tklabel(tt, text="Database:")
	label_Host <- tklabel(tt, text="Host:")
	label_Port <- tklabel(tt, text="Port:")
	label_User <- tklabel(tt, text="User:")
	label_Password <- tklabel(tt, text="Password:")
	# Boxes
	entry_DB <- tkentry(tt, width="30", textvariable=DB)
	entry_Host <- tkentry(tt, width="30", textvariable=Host)
	entry_Port <- tkentry(tt, width="30", textvariable=Port)
	entry_User <- tkentry(tt, width="30", textvariable=User)
	entry_Password <- tkentry(tt, width="20", show="*", textvariable=Password)
	# The grid	
	#tkgrid(tklabel(tt, text="Enter your login details"))
	tkgrid(label_DB, entry_DB)
	tkgrid(label_Host, entry_Host)
	tkgrid(label_Port, entry_Port)
	tkgrid(label_User, entry_User)
	tkgrid(label_Password, entry_Password)
	# Nicier arrangements
	tkgrid.configure(entry_DB, entry_Host, entry_Port, entry_User,
			entry_Password, sticky="w")
	tkgrid.configure(label_DB, label_Host, label_Port, label_User,
			label_Password, sticky="e")
	# Actions
	OnOK <- function()
	{ 
		tkdestroy(tt) 
	}
	OK_but <-tkbutton(tt, text=" OK ", command=OnOK)
	tkbind(entry_Password, "<Return>", OnOK)
	tkgrid(OK_but)
	tkfocus(tt)
	tkwait.window(tt)
	# Alternative connections
	if(!package %in% c("RPostgres", "RPostgreSQL"))
		stop(paste0("The value '", package, "' in argument 'package'",
						" is not valid"))
	if(package == "RPostgres") {
		invisible(RPostgres::dbConnect(RPostgres::Postgres(),
						dbname=tclvalue(DB),
						host=tclvalue(Host),
						port=tclvalue(Port),
						user=tclvalue(User),
						password=tclvalue(Password),
						...))
	}
	if(package == "RPostgreSQL") {
		invisible(RPostgreSQL::dbConnect("PostgreSQL",
						dbname=tclvalue(DB),
						host=tclvalue(Host),
						port=tclvalue(Port),
						user=tclvalue(User),
						password=tclvalue(Password),
						...))
	}
}
