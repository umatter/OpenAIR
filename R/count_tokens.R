#' Count the number of tokens in a text string
#'
#' This function takes a file path, URL or character string as input and
#' returns the number of tokens in the text. Tokens are defined as words and/or
#' special characters.
#'
#' @param text A file path, URL or character string representing the text to be
#'   tokenized.
#'
#' @return An integer representing the number of tokens in the text.
#'
#' @examples
#' \dontrun{
#' # Example 1: File path
#' test_file_path <- tempfile()
#' writeLines("This is a test.", test_file_path)
#' expect_equal(count_tokens(test_file_path), 5)
#' file.remove(test_file_path)
#'
#' # Example 2: URL
#' url <- "https://www.gutenberg.org/files/2701/2701-0.txt"
#' count_tokens(url)
#'
#' # Example 3: Character string
#' text <- "This is a test string."
#' count_tokens(text)
#' }
#'
#' @importFrom stringi stri_split_regex
#' @importFrom httr GET content
#' @importFrom R.utils isUrl
#' @importFrom data.table data.table .N
#'
#' @export
count_tokens <- function(text) {
  
  # Check if input is a file path
  if (is.character(text) && file.exists(text)) {
    text_string <- readLines(text, warn = FALSE)
    
    # Check if input is a URL
  } else if (isUrl(text)) {
    response <- GET(text)
    text_string <- content(response, "text")
    
    # Check if input is a character string
  } else if (is.character(text)) {
    text_string <- text
    
    # If input is not valid, return an error message
  } else {
    stop("Input must be a file path, a valid URL, or a character string.")
  }
  
  # Tokenize the text
  tokens <- stri_split_regex(text_string, "\\s+|(?=\\W)|(?<=\\W)")
  tokens <- unlist(tokens)
  
  # Remove empty and whitespace-only tokens
  tokens <- tokens[tokens != "" & !grepl("^\\s+$", tokens)]
  
  # Count the number of non-empty tokens using data.table package
  tokens_dt <- data.table(tokens)
  num_tokens <- tokens_dt[, .N, by = NULL][[1]]
  
  return(num_tokens)
}
