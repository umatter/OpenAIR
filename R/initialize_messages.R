#' Initialize a new messages object for OpenAI API chat completions
#'
#' This function initializes a new messages object as a template for messages sent to the OpenAI API
#' https://api.openai.com/v1/chat/completions endpoint. By default, the template contains a single message from
#' the system to the user with the initial content "You are a helpful assistant.", but you can customize the content
#' by specifying a different value for the "initial_system_content" parameter.
#'
#' @param initial_role A character string representing the role issueing the initial content (per default: "system")
#' @param initial_content A character string representing the initial message from the system
#'
#' @return A data frame containing a single message from the system to the user, with columns for the
#' message role and content.
#' @author Ulrich Matter umatter@protonmail.com
#' @examples
#' messages <- initialize_messages()
#' messages_custom <- initialize_messages("Hello! How can I assist you today?")
#'
#' @export

initialize_messages <- function(initial_role="system", initial_content = "You are a helpful assistant.") {
  # Create a new data frame with the message
  messages <- data.frame(role = initial_role,
                         content = initial_content)
  
  # Return the resulting data frame
  return(messages)
}
