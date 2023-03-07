#' Set up a new chatlog
#'
#' This function sets up a new chatlog object for a conversation.
#'
#' @param initial_system_content A character string representing the initial message from the system
#' @return A new chatlog object
#' @export
#' @examples
#' chat <- set_chatlog("Welcome to our chat!")
#' is_chatlog(chat)
#' chat
set_chatlog <- function(initial_system_content = "You are a helpful assistant.") {
  
  # Create a new data frame with the initial system message
  msgs <- data.frame(role = "system",
                     content = initial_system_content)
  
  # Create the id of the current chat
  chatlog_id <- paste0("chatlog_", format(Sys.time(), "%Y%m%d%H%M%S"))
  
  # Create a new chatlog object
  chatlog <- new("chatlog", 
                 messages = msgs, 
                 chatlog_id = chatlog_id)
  
  # Prepare chat environment, store chatlog object there
  if (!exists(".ChatEnv", envir = .GlobalEnv)) {
    .ChatEnv <- new.env(parent = .GlobalEnv)
  }
  assign(chatlog_id, chatlog, envir=.ChatEnv)
  
  return(chatlog)
  
}
