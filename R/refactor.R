#' Refactor R Code with AI Assistance
#' 
#' This function refactors R code with the assistance of an AI chatbot.
#' 
#' @param file character, file name of a file containing R code to be refactored
#' or a character string containing R code to be refactored
#' @param ... Additional arguments to pass to the chat_completion() function.
#' 
#' @return The refactored code either to the console (if the input `file` was a
#' character string) or written to a file (if the input was a file name).
#' 
#' @examples
#' \dontrun{
#' # Create a sample R function file
#' cat("my_sum <- function(a, b) {", "return(a + b)", "}",
#'  file = "sample_function.R")
#'
#' # Refactor the R function and return the output
#' refactored_function <- refactor(file = "sample_function.R")
#'
#' # Refactor the R function and write the output to the same file
#' refactor(file = "sample_function.R")
#' }
#' @export
refactor <- function(file, ...) {

  # import, process text
  r_code <- read_text(file)
  text <-
    r_code$text %>%
    paste0(collapse = "\n")
  text_commented_out <-
    r_code$text %>%
    paste0("# ") %>%
    paste0(collapse = "\n")

  # Make sure intput is R code
  if (!is_r(text) | nchar(text) == 0) {
    stop("The input does not contain a valid R code.")
  }

  # initial user input
  n_msgs <- nrow(refactor_prompt)
  refactor_prompt$content[n_msgs] <-
    sprintf(fmt = refactor_prompt$content[n_msgs], text)


  # chat
  cli::cli_alert_info("Code writing in progress. Hold on tight!")
  resp <- chat_completion(refactor_prompt, ...)
  total_tokens_used <- usage(resp)$total_tokens
  info_token <- paste0("Total tokens used: ", total_tokens_used)
  cli::cli_inform(info_token)

  # extract refactored R code
  output <-
    resp %>%
    messages_content() %>%
    clean_output()

  # validate output
  if (is_r(output) == FALSE) {
    cli::cli_alert_warning(paste0("Refactoring has potentially resulted in ",
      "invalid R code. Verify the generated code carefully!"))
  }

  # prepare output
  filename <- unique(r_code$file)
  if (filename == "character string") {
    return(output)

  } else {
    cat(output,
        "\n\n # OLD VERSION ---\n\n",
        text_commented_out,
        file = filename)
    cli::cli_alert_success(paste0("Wrote refactored version to ", filename))

    return(filename)
  }

}