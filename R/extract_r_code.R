#' Extract R code and comments from a given input string.
#'
#' This function takes an input string, detects R code and comments, and returns a character vector
#' containing the R code and comments. The input string is split into lines based on newline characters,
#' and each line is examined for R code and comment patterns. Only the lines that match either of these
#' patterns are returned.
#'
#' @param input_string A character string containing R code and comments, mixed with other text.
#'                     The string may contain multiple lines separated by newline characters.
#'
#' @return A character vector containing R code and comment lines extracted from the input string.
#'         Each element in the vector corresponds to one line of code or a comment.
#' @export
#'
#' @examples
#' example_string <- 
#' "This is a text string with R code and comments.\n
#' # A comment\n
#' x <- 5\
#' ny = 10\n
#' z <- x + y\n
#' Another line of text."
#' extract_r_code(example_string)
extract_r_code <- function(input_string) {
  
  # Split the input string into lines based on newline characters
  lines <- strsplit(input_string, "\n")[[1]]

  # Define a regular expression pattern to detect R code and comments
  r_code_pattern <- "^\\s*[^#\\s].*(<-|=|\\().*$"
  r_comment_pattern <- "^\\s*#.*$"
  
  # Initialize an empty vector to store the lines containing R code and comments
  # Iterate over each line to identify R code and comment lines
  r_code_and_comment_lines <- character(0)
  for (line in lines) {
    if (grepl(r_code_pattern, line) | grepl(r_comment_pattern, line)) {
      r_code_and_comment_lines <- c(r_code_and_comment_lines, line)
    }
  }
  
  # Return the R code and comment lines
  return(r_code_and_comment_lines)
}
