#' Regenerate the last response in an ongoing chat
#'
#' This function removes the last response in a chatlog, generates a new response
#' based on the updated chatlog, and updates the chatlog accordingly. The output
#' can be displayed as a message in the console, returned as a message, or returned
#' as a response object.
#'
#' @param chatlog_id A character string specifying the ID of the chatlog (default: '.__CURRENTCHAT__')
#' @param output A character string specifying the output format. Options are 'message_to_console', 'message', or 'response_object' (default: 'message_to_console')
#' @return If output is 'message_to_console', the function returns NULL and prints the message to the console.
#'         If output is 'message', the function returns a character string containing the message.
#'         If output is 'response_object', the function returns the full response object.
#' @examples
#' \dontrun{
#' # Start a new chat and save the chatlog ID
#' chatlog_id <- chat("Hello, how are you?")
#'
#' # Regenerate the last response in the chat and display it in the console
#' regenerate(chatlog_id)
#'
#' # Regenerate the last response in the chat and return it as a message
#' message <- regenerate(chatlog_id, output = "message")
#' print(message)
#'
#' # Regenerate the last response in the chat and return it as a response object
#' response_object <- regenerate(chatlog_id, output = "response_object")
#' print(response_object)
#' }
regenerate <- function(chatlog_id = ".__CURRENTCHAT__", output="message_to_console"){
  
  # check input validity
  if (!output %in% c("message_to_console", "message", "response_object")){
    stop("Argument output needs to be one of 'message_to_console', 'message', or 'response_object")
  }
  
  # check if chat is ongoing
    if (!exists(chatlog_id, envir = OpenAIR_env)){
      stop("No chatlog found. Please start a new chat with chat() first.")
    } else {
      # fetch current chat status
      cl <- get_chatlog(chatlog_id)
    }
  
  # remove last chatlog entry
  cl@messages <- cl@messages[-nrow(cl@messages),]
  assign(chatlog_id, cl, envir = OpenAIR_env)
  
  # regenerate
  resp <- chat_completion(cl)

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
