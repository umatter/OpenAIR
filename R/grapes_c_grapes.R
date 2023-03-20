#' Send a message to ChatGPT and assign the response to a variable
#'
#' This function sends a message to the ChatGPT API using the 'chat()' function and returns the response in the specified output format.
#'
#' @param message A character string containing the message to be sent to the ChatGPT API.
#' @param output A character string specifying the output format. Valid options are "message_to_console", "message", or "response_object". Default is "message_to_console".
#'
#' @return Depending on the value of the 'output' argument, this function returns one of the following:
#' * "message_to_console": a message containing the response text to be printed to the console.
#' * "message": the response text as a character vector.
#' * "response_object": the full response object from the ChatGPT API.
#'
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#' 
#' @examples
#' \dontrun{
#' # Send a message and assign the response to a variable
#' response_var <- "Hello, ChatGPT!" %c% "message"
#' 
#' # Print the response
#' print(response_var)
#'
#' # Send a message and return the full response object
#' response_obj <- "Hello, ChatGPT!" %c% "response_object"
#' 
#' # Print the response
#' print(response_obj)
#'}
`%c%` <- function(message, output) {
  
  # send message to ChatGPT and return the response
  chat(message = message, output=output )
  

}
