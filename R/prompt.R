#' Prompt the chat model with user input
#'
#' This function prompts the chat model with new user input.
#'
#' @param x Either a character string indicating the name of the chat log object or a messages object (data.frame).
#' @param text A character string indicating the user input text.
#' @param show Logical, if TRUE, the current chat log is displayed via View(). Default is FALSE.
#'
#' @return A response from the chat model as a character string.
#'
#' @examples
#' \dontrun{
#' # Start a new chat session
#' chatlog_id <- start_chat()
#'
#' # Prompt the chat model with user input
#' resp <- prompt(chatlog_id, "Hello!")
#' }
#'@export
prompt <- 
  function(x, text, show = FALSE) {
    
    if (is_chatlog(x)) {
      chatlog_id <- x$chatlog_id
    } else {
      chatlog_id <- x
    }
    
    # Wrap prompt text in message container
    msg_df <- data.frame(role = "user", 
                         content = text,
                         chatlog_id = chatlog_id)
    
    # Add user message to the chat log
    add_to_chatlog(msg_df, chatlog_id)
    
    # Get response from chat model
    resp <- 
      chatlog_id %>% 
      get_chatlog() %>%  
      chat_completion()
    
    # update chatlog, add to response
    resp %>% 
      messages() %>% 
      add_to_chatlog(chatlog_id)

    if (show==TRUE){
      # Open current chatlog
      utils::View(chatlog(chatlog_id), 
           title = paste0("Current chat (ID: ", chatlog_id, ")"))  
    }
    
    return(chatlog(chatlog_id))
  }
