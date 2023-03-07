
#' Start a new chat session
#'
#' This function starts a new chat session by initializing a messages object with an initial system message,
#' creating a new log environment to store the messages, and adding the messages object to the log environment.
#'
#' @param initial_system_content A character string indicating the initial content of the system message. The default value is "You are a helpful assistant.".
#' @param show Logical, if TRUE, the current chat log is displayed via View(). Default is FALSE.
#'
#' @return A character string indicating the name of the log environment created for the chat session.
#'
#' @examples
#' # Start a new chat session with the default system message
#' chatlog_id <- start_chat()
#'
#' # Start a new chat session with a custom system message
#' chatlog_id <- start_chat("How can I assist you today?")
#'
#'@export
start_chat <- function(initial_system_content = "You are a helpful assistant.", show=FALSE){
  
 cl <- set_chatlog(initial_system_content=initial_system_content)
  
  if (show==TRUE){
    # Open current chatlog
    utils::View(cl@messages,
                title = paste0("Current chat (ID: ",
                               cl@chatlog_id,
                               ")"))  
  }

  return(cl)
}
