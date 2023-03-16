#' Provide Feedback on a Piece of Code
#'
#' TODO: FUNCTION_DESCRIPTION
#'
#' @param task A character string containing the description of the coding task.
#' @param code A character string containing the R code to be processed.
#'
#' @return A tibble
#'
#' TODO: EXAMPLES
#'
#' @export
feedback <- function(task, code) {

  results_list <-
    mapply(FUN = function(code, task) {

      # Initial user input
      feedback_input$content[2] <-
        sprintf(fmt = feedback_input$content[2], task, code)

      # Chat
      resp <- chat_completion(feedback_input)
      total_tokens_used <- usage(resp)$total_tokens
      message("Total tokens used: ", total_tokens_used)

      # Process response
      msg_resp <- messages(resp)
      feedback <- readr::read_csv(msg_resp$content)

      names(feedback) <- c("lines", "feedback")

      return(feedback)
    }, code, task)

  # Stack results
  feedback_df <- dplyr::bind_rows(results_list)

  # Return the processed feedback
  return(feedback_df)
}
