#' Obtain feedback on code using OpenAI's chat_completion function
#'
#' This function takes two arguments: task and code. It returns a processed
#' feedback data frame based on the user input of code and task. The feedback
#' is obtained by using OpenAI's chat_completion function and processing the
#' response.
#'
#' @param task A character string that represents the task the user is trying
#' to accomplish.
#' @param code A character string that represents the code that the user has
#' written.
#'
#' @return A data frame with two columns:
#' \itemize{
#'  \item \code{lines}: A character vector containing the lines of code from
#' the user's input.
#'  \item \code{feedback}: A character vector containing feedback on each
#' line of code.
#' }
#'
#' @examples
#' feedback("Solve the FizzBuzz problem", "for(i in 1:100)
#' { if(i %% 3 == 0 && i %% 5 == 0) { print('FizzBuzz') } else if(i %% 3 == 0)
#' { print('Fizz') } else if(i %% 5 == 0)
#' { print('Buzz') } else { print(i) } }")
#'
#' @export
feedback <- function(task, code) {

  requireNamespace("dplyr", quietly = TRUE)

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

      return(feedback)
    }, code, task)

  names(results_list) <- c("lines", "feedback")
  # Stack results
  feedback_df <- dplyr::bind_rows(results_list)

  # Return the processed feedback
  return(feedback_df)
}
