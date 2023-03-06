#' Extract Created DateTime from OpenAI API response 
#'
#' This function extracts the date-time string of when the response was created from the parsed HTTP response of an API call to the
#' OpenAI chat completions endpoint.
#'
#' @param response a list object representing the HTTP response
#' @return a Date object representing the date-time string of when the response was created
#'
#' @export
#' 
#' 
created <- function(response) {
  # Check if the response is a list
  if (!is.list(response)) {
    stop("Invalid response format. Expected list object.")
  }
  
  # Extract the created date-time integer from the response
  datetime <- response$created
  # Check if the ID is a character integer
  if (!is.integer(datetime)) {
    stop("Invalid response format. created must be an integer.")
  }
  # Convert to more user-friendly Date()
  datetime <- lubridate::as_datetime(datetime)
  
  # Return the ID
  return(datetime)
}
