#' Extract object information from OpenAI API response 
#'
#' This function extracts the object data from the parsed HTTP response of an API call to the
#' OpenAI chat completions endpoint (provides information about the endpoint).
#'
#' @param response a list object representing the HTTP response
#' @return a data frame with the usage statistics of the API call (how many tokens used)
#'
#' @export
#' 
#' 
object <- function(response) {
  # Check if the response is a list
  if (!is.list(response)) {
    stop("Invalid response format. Expected list object.")
  }
  
  # Extract the object from the response
  object <-  response$object
  
  # Check if the object is a character string
  if (!is.character(object)) {
    stop("Invalid response format. object must be a character string.")
  }
  
  # Return the object
  return(object)
}
