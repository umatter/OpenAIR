#' Extract roxygen2 documentation lines from a function definition
#'
#' This function takes a character vector containing the lines of a function
#' definition and returns a character string containing only the lines
#' belonging to the roxygen2 documentation (lines starting with "#'").
#'
#' @param func_def A character vector containing the lines of a function definition
#' @return A character string containing the roxygen2 documentation lines
#' @export
#' @examples
#' func_def <- c(
#'   "#' Extracts object from a response list",
#'   "#'",
#'   "#' @export",
#'   "object <- function(response) {",
#'   "  if (!is.list(response)) {",
#'   "    stop('Invalid response format. Expected list object.')",
#'   "  }",
#'   "}")
#'
#' roxygen2_docu <- extract_roxygen2(func_def)
#' print(roxygen2_docu)
extract_roxygen2 <- function(func_def) {
  
  func_def <- strsplit(func_def, split = "\\n")[[1]]
  roxygen2_lines <- grep("^#'", func_def, value = TRUE)
  roxygen2_docu <- paste(roxygen2_lines, collapse = "\n")
  
  return(roxygen2_docu)
}
