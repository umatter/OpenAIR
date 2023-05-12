#' Extract ID from OpenAI API response
#'
#' This function extracts the ID from the parsed HTTP response of an API call
#' to the OpenAI chat completions endpoint.
#'
#' @param response a list object representing the HTTP response
#' @return a character string representing the ID from the response
#'
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#'
#'
id <- function(response) {
  # Check if the response is a list
  if (!is.list(response)) {
    stop("Invalid response format. Expected list object.")
  }

  # Extract the ID from the response
  id <- response$id

  # Check if the ID is a character string
  if (!is.character(id)) {
    stop("Invalid response format. ID must be a character string.")
  }

  # Return the ID
  return(id)
}
