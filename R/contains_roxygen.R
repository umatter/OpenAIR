#' Check if a text file or character string contains Roxygen2 documentation
#'
#' This function parses a text file or a character string and returns TRUE if it
#' contains
#' Roxygen2 documentation. It uses a regex pattern to identify
#' possible Roxygen2 documentation lines.
#'
#' @param input A character string specifying the path to the text file, or a
#' character
#'   string containing the text to be checked for Roxygen2 documentation.
#' @return A logical value (TRUE or FALSE) indicating whether the input
#'   contains Roxygen2 documentation.
#' @export
contains_roxygen <- function(input) {
  # Check if the input is a file path or a character string
  is_file <- file.exists(input)

  # Read the lines
  lines <- if (is_file) readLines(input) else strsplit(input,
    split = "\\n")[[1]]

  # Define the regex pattern to identify Roxygen2 documentation
  pattern <- "^#'"

  # Check if any line in the input contains Roxygen2 documentation
  result <- any(sapply(lines, function(line) grepl(pattern, line, perl = TRUE)))

  return(result)
}
