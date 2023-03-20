#' Extract choices/messages from OpenAI API response
#'
#' This function extracts the choices/messages from the HTTP response of an API call to the
#' OpenAI chat completions endpoint.
#'
#' @param response a list object representing the HTTP response
#' @return a dataframe representing the choices/messages from the response
#' @author Ulrich Matter umatter@protonmail.com
#' @export
messages <- function(response) {
  # Check if the response is a list
  if (!is.list(response)) {
    stop("Invalid response format. Expected list object.")
  }
  
  # Extract the choices from the response
  choices <- response$choices
  # Check if the choices are a list
  if (!is.list(choices)) {
    stop("Invalid response format. Choices must be a list object.")
  }
  # flatten
  message <- choices$message

  # Return the choices
  return(message)
}
