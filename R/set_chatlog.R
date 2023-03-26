#' Set up a new chatlog
#'
#' This function sets up a new chatlog object for a conversation.
#'
#' @param initial_role A character string representing the role issueing the initial content (per default: "system")
#' @param initial_content A character string representing the initial message from the system
#' @param chatlog_id A character string representing the ID of this conversation. Per default, this will be set automatically.
#' @return A new chatlog object
#' @export
#' @examples
#' chat <- set_chatlog("Welcome to our chat!")
#' is_chatlog(chat)
#' chat
set_chatlog <- function(initial_role="system", initial_content = "You are a helpful assistant.", chatlog_id=NULL) {
  
  # Create a new data frame with the initial system message
  msgs <- data.frame(role = initial_role,
                     content = initial_content)
  
  # Create the id of the current chat
  if (is.null(chatlog_id)){
    chatlog_id <- paste0(".chatlog_", format(Sys.time(), "%Y%m%d%H%M%S"))
  }
  
  # Create a new chatlog object
  chatlog <- new("chatlog", 
                 messages = msgs, 
                 chatlog_id = chatlog_id)
  
  # Prepare chat environment, store chatlog object there
  assign(chatlog_id, chatlog, envir=OpenAIR_env)
  
  return(chatlog)
  
}
