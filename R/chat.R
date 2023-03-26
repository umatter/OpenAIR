#' Start or continue a chat conversation
#'
#' This function starts or continues a chat conversation and adds the user's message to the conversation.
#' If the conversation does not exist, a new one will be initiated.
#'
#' @param message The message to be added to the chat conversation
#' @param chatlog_id The ID of the chat conversation to start or continue. Default is "__CURRENTCHAT__".
#' @param output The output format of the response. Default is "message_to_console".
#' Valid options are "message_to_console", "message", or "response_object".
#' @author Ulrich Matter umatter@protonmail.com
#' @return Depending on the value of the 'output' argument, this function returns one of the following:
#' * "message_to_console": a message containing the response text to be printed to the console.
#' * "message": the response text as a character vector.
#' * "response_object": the full response object from the ChatGPT API.
#'
#' @export

chat <- function(message, chatlog_id = ".__CURRENTCHAT__", output="message_to_console"){
  
  # check input validity
  if (!output %in% c("message_to_console", "message", "response_object")){
    stop("Argument output needs to be one of 'message_to_console', 'message', or 'response_object")
  }
  
  # check if chat is ongoing
  # if not, initiate new chat
    if (!exists(chatlog_id, envir = OpenAIR_env)){
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
    messages() %>%
    add_to_chatlog(chatlog_id)
  
  if (output=="message_to_console") {
    # process response
    messages <-   
      resp %>% 
      messages()
    
    # show response message in console
    return(message(messages$content))
  } 
  
  if (output=="message") {
    
    # process response
    messages <-   
      resp %>% 
      messages()
    
    return(messages$content)
    
  }
  
  if (output == "response_object") {
    # return full response object
    return(resp)
  }
  

}
