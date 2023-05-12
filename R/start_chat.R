
#' Start a new chat session
#'
#' This function starts a new chat session by initializing a messages object
#' with an initial system message, creating a new log environment to store the
#' messages, and adding the messages object to the log environment.
#'
#' @param initial_role A character string representing the role issueing the
#' initial content (per default: "system")
#' @param initial_content A character string representing the initial message
#' from the system
#' @param show Logical, if TRUE, the current chat log is displayed via View().
#' Default is FALSE.
#' @param chatlog_id A character string representing the ID of this
#' conversation. Per default, this will be set automatically.
#'
#' @return A character string indicating the name of the log environment
#' created for the chat session.
#'
#' @examples
#' # Start a new chat session with the default system message
#' chatlog_id <- start_chat()
#'
#' # Start a new chat session with a custom system message
#' chatlog_id <- start_chat("How can I assist you today?")
#'
#'@export
start_chat <- function(initial_role="system",
  initial_content = "You are a helpful assistant.", show = FALSE,
  chatlog_id = NULL){

 cl <- set_chatlog(initial_role = initial_role,
  initial_content = initial_content, chatlog_id)

  if (show == TRUE) {
    # Open current chatlog
    utils::View(cl@messages,
                title = paste0("Current chat (ID: ",
                               cl@chatlog_id,
                               ")"))
  }

  return(cl)
}
