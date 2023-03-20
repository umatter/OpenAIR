#' Extract Model from OpenAI API response 
#'
#' This function extracts the model from the parsed HTTP response of an API call to the
#' OpenAI chat completions endpoint.
#'
#' @param response a list object representing the HTTP response
#' @return a character string representing the model from the response
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#' 
#' 
model <- function(response) {
  # Check if the response is a list
  if (!is.list(response)) {
    stop("Invalid response format. Expected list object.")
  }
  
  # Extract the model from the response
  m <- response$model
  
  # Check if the model is a character string
  if (!is.character(m)) {
    stop("Invalid response format. model must be a character string.")
  }
  
  # Return the model
  return(m)
}
