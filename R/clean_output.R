#' Clean Output From Code Responses
#'
#' This function extracts the content from a given text string that is enclosed between the '```' markers. It can be used to extract any kind of code or text content.
#'
#' @param text A character string containing the code or text content with '```' markers.
#'
#' @return A character string containing the extracted code or text content.
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#' @examples
#' code_text <- "```
#' example_code <- function(x) {
#'   return(x * 2)
#' }
#'```"
#' clean_output(code_text)

clean_output <- function(text) {
  # Define the pattern with the (?s) flag for dot-matching newline characters
  pattern <- "(?s)```(.*?)```"
  
  # Match the pattern using gregexpr and extract the content
  matches <- gregexpr(pattern, text, perl = TRUE)
  
  # Check if there's a match
  if (length(matches[[1]]) > 0 && matches[[1]][1] != -1) {
    content <- regmatches(text, matches)[[1]]
    
    # Remove the '```' markers from the content
    cleaned_content <- gsub("^[a-zA-Z]*(```)", "", content)
    cleaned_content <- gsub("(```)", "", cleaned_content)
    
    
    return(cleaned_content)
  } else {
    # If there's no match, return the original text
    return(text)
  }
}
