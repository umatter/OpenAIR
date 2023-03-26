#' Extract messages from a response object or a chatlog object
#'
#' This function takes a response object or a chatlog object as input and
#' returns the messages. If the input is a response object, the function
#' extracts and returns the messages from the choices. If the input is a
#' chatlog object, the function returns the messages directly.
#'
#' @param x A list representing a response object or a chatlog object
#' @return A data.frame containing the messages
#' @export
#' @examples
#' \dontrun{
#' # Using a response object
#' response <- list(choices = list(message = "This is a message."))
#' messages_from_response <- messages(response)
#' print(messages_from_response)
#'
#' # Using a chatlog object
#' chatlog_id <- chat("Hello, how are you?")
#' chatlog <- get_chatlog(chatlog_id)
#' messages_from_chatlog <- messages(chatlog)
#' print(messages_from_chatlog)
#' }
messages <- function(x) {
  # Check input format
  if (!is.list(x) & !is_chatlog(x)) {
    stop("Invalid parameter value. Expecting list or chatlog object.")
  }
  
  if (is_chatlog(x)) {
    return(x@messages)
  }
  
  # Extract the choices from the x
  choices <- x$choices
  # Check if the choices are a list
  if (!is.list(choices)) {
    stop("Invalid response format. Choices must be a list object.")
  }
  # flatten
  message <- choices$message

  # Return the choices
  return(message)
}
