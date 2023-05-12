#' Extract usage data from OpenAI API response
#'
#' This function extracts the usage data from the parsed HTTP response of an
#' API call to the OpenAI chat completions endpoint.
#'
#' @param response a list object representing the HTTP response
#' @return a data frame with the usage statistics of the API call
#' (how many tokens used)
#'
#' @export
#'
usage <- function(response) {
  # Check if the response is a list
  if (!is.list(response)) {
    stop("Invalid response format. Expected list object.")
  }

  # Extract the usage stats from the response
  u <- response$usage

  # Check if the usage stats object is a list
  if (!is.list(u)) {
    stop("Invalid response format. usage must be a character string.")
  }

  # Convert to data frame
  u <- as.data.frame(u)

  # Return the usage stats
  return(u)
}
