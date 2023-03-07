#' Initialize a new messages object for OpenAI API chat completions
#'
#' This function initializes a new messages object as a template for messages sent to the OpenAI API
#' https://api.openai.com/v1/chat/completions endpoint. By default, the template contains a single message from
#' the system to the user with the initial content "You are a helpful assistant.", but you can customize the content
#' by specifying a different value for the "initial_system_content" parameter.
#'
#' @param initial_system_content A character string indicating the initial content of the system message.
#' The default value is "You are a helpful assistant.".
#'
#' @return A data frame containing a single message from the system to the user, with columns for the
#' message role and content.
#'
#' @examples
#' messages <- initialize_messages()
#' messages_custom <- initialize_messages("Hello! How can I assist you today?")
#'
#' @export

initialize_messages <- function(initial_system_content = "You are a helpful assistant.") {
  # Create a new data frame with the system message
  messages <- data.frame(role = "system",
                         content = initial_system_content)
  
  # Return the resulting data frame
  return(messages)
}
