#' Get the current chatlog
#'
#' This function extracts the current chatlog of a given chat from the chat environment.
#'
#' @param x either a chatlog object r, or a character string representing the id of a chatlog (the default is ".__CURRENTCHAT__", the current log of the chat()-function)
#' @return a chatlog object
#' 
#' @author Ulrich Matter umatter@protonmail.com
#'
#' @export
get_chatlog <- function(x=".__CURRENTCHAT__") {

  # verify type of input to extract chatlog (needs to be improved)
  if (is_chatlog(x)) {
    chatlog_id <- x@chatlog_id
  } else {
    chatlog_id <- x
  }
  
  # Extract the choices from the response
  clog <- get(chatlog_id, envir = OpenAIR_env)

  # Return the choices
  return(clog)
}
