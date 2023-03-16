#' Explain a Piece of R Code
#'
#' TODO: FUNCTION_DESCRIPTION
#'
#' @param code A character string containing the R code to be processed.
#'
#' @return NULL 
#'
#' @export
explain_code <- function(code) {

  explanation <-
    lapply(code, FUN = function(code) {

      # Initial user input
      explain_code_input$content[2] <-
        sprintf(fmt = explain_code_input$content[2], code)

      # Chat
      resp <- chat_completion(explain_code_input)
      total_tokens_used <- usage(resp)$total_tokens
      message("Total tokens used: ", total_tokens_used)

      # Process response
      msg_resp <- messages(resp)
      explanation <- msg_resp$content

      return(explanation)
    })

  # Output the message and return NULL
  message(explanation)
  return(NULL)
}
