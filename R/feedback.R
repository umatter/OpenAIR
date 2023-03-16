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

  requireNamespace("dplyr", quietly = TRUE)

  # TODO: Do we really need to transform to TidyText format?
  code <-
    read_text(code)$text %>%
    paste0(collapse = "\n")

  results_list <-
    lapply(code, FUN = function(x) {

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

      return(feedback)
    })

  # Stack results
  feedback_df <- dplyr::bind_rows(results_list)

  # Return the processed feedback
  return(feedback_df)
}