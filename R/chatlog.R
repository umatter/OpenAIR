#' Extract chatlog from OpenAI API response object
#'
#' This function extracts the current chatlog as a data.frame/tibble from the response of an API call to the
#' OpenAI chat completions endpoint.
#'
#' @param x either a list object representing a prompt response, or a character string representing the id of a current chatlog.
#' @return a dataframe representing the chat log
#'
#' @export
chatlog <- function(x) {

  # verify type of input to extract chatlog (needs to be improved)
  if (is.list(x)) {
    chatlog_id <- unique(x$chatlog_id)
  } else {
    chatlog_id <- x
  }
  
  # Extract the choices from the response
  clog <- get(chatlog_id, envir = .ChatEnv)
  # Check if the choices are a list
  if (!is.list(clog)) {
    stop("Invalid response format. Choices must be a list object.")
  }

  # Return the choices
  return(clog)
}
