#' Check if a text file or character string contains an R function definition
#'
#' This function parses a text file or a character string and returns TRUE if it contains
#' a valid R function definition. It uses a regex pattern to identify
#' possible R function definitions and then attempts to parse the matched
#' lines as R code.
#'
#' @param input A character string specifying the path to the text file, or a character
#'   string containing the text to be checked for an R function definition.
#' @return A logical value (TRUE or FALSE) indicating whether the input
#'   contains a valid R function definition.
#' @examples
#' # Create a temporary file with an R function definition
#' temp_file <- tempfile(fileext = ".R")
#' writeLines("example_function <- function(x) {\n  return(x * 2)\n}", temp_file)
#'
#' # Check if the temporary file contains an R function definition
#' result <- contains_r_function(temp_file)
#' print(result) # Should print TRUE
#'
#' # Check if a character string contains an R function definition
#' result <- contains_r_function("example_function <- function(x) { return(x * 2) }")
#' print(result) # Should print TRUE
#'
#' # Remove the temporary file
#' file.remove(temp_file)
contains_r_func <- function(input) {
  # Check if the input is a file path or a character string
  is_file <- file.exists(input)
  
  # Read the lines
  lines <- if (is_file) readLines(input) else strsplit(input, split = "\\n")[[1]]
  
  # Define the regex pattern to identify an R function definition
  pattern <- "^\\s*\\w+\\s*<-\\s*function\\s*\\("
  
  # Check if any line in the input contains a function definition
  match_indices <- which(sapply(lines, function(line) grepl(pattern, line, perl = TRUE)))
  
  # If no match is found, return FALSE
  if (length(match_indices) == 0) {
    return(FALSE)
  }
  
  # Otherwise, check if the matched code is valid R code
  for (i in match_indices) {
    # Extract the function definition and save it as a temporary file
    func_def <- lines[i:(i + 1)]
    temp_file <- tempfile(fileext = ".R")
    writeLines(func_def, temp_file)
    
    # Attempt to parse the temporary file
    error_occurred <- FALSE
    tryCatch({
      parse(file = temp_file)
    }, error = function(e) {
      error_occurred <- TRUE
    })
    
    # Remove the temporary file
    file.remove(temp_file)
    
    # If parsing succeeded, return TRUE
    if (!error_occurred) {
      return(TRUE)
    }
  }
  
  # If none of the matched lines were valid R code, return FALSE
  return(FALSE)
}
