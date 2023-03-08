
chat <- function(message){
  
  chatlog_id = ".__CURRENTCHAT__"
  
  # check if chat is ongoing
  # if not, initiate new chat
    if (!exists(chatlog_id, envir = .GlobalEnv)){
      # initialize chatlog
      cl <- start_chat(chatlog_id=chatlog_id)
    
    } else {
      # fetch current chat status
      cl <- get_chatlog(chatlog_id)
 
    }
  
  # add new message to conversation, send
  resp <- 
  initialize_messages(initial_role = "user", initial_content = message)  %>% 
    add_to_chatlog(chatlog_id)  %>%  
    chat_completion()
  
  # update chatlog
  resp %>% 
    add_to_chatlog(chatlog_id)
  
  # process response
  output <-   
    resp %>% 
    messages()

  return(message(output$content))
}
