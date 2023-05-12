#' Extract Messages Content from OpenAI API Response
#'
#' This function extracts the messages content from the HTTP response of an API
#' call to the OpenAI chat completions endpoint.
#'
#' @param response a list object representing the HTTP response
#' @return a character string representing the choices/messages from the
#' response
#'
#' @author Ulrich Matter umatter@protonmail.com
#'
#' @export
messages_content <- function(response) {
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
  mc <- choices$message$content

  # Return the choices
  return(mc)
}
