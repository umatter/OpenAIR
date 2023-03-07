#' Get the current chatlog
#'
#' This function extracts the current chatlog of a given chat from the chat environment.
#'
#' @param x either a chatlog object r, or a character string representing the id of a chatlog.
#' @return a chatlog object
#'
#' @export
get_chatlog <- function(x) {

  # verify type of input to extract chatlog (needs to be improved)
  if (is_chatlog(x)) {
    chatlog_id <- x@chatlog_id
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
