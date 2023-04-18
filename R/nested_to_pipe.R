#' Convert nested R code to pipe syntax
#'
#' This function takes an R script containing traditional (nested syntax) R code and
#' converts it to magrittr-style syntax, using the pipe (%>%) operator.
#' It also validates the input and output code to ensure proper R syntax.
#'
#' @param r A file path or character string containing the R code to be converted.
#' @param n_tokens_limit The maximum number of tokens allowed in the input text (default: 3000).
#' @param ... Additional arguments passed to the chat_completion function.
#'
#' @return If r is a character string, the function returns the converted R code as a character string. If r is a file path, the function writes the converted code to a new file with the same name and a "-pipe.R" suffix, and returns the path to the output file.
#'
#' @examples
#' \dontrun{
#' # Converting a character string
#' input <- "result <- mean(sqrt(abs(rnorm(10, 0, 1))), na.rm = TRUE)"
#' output <- nested_to_pipe(input)
#' cat(output)
#'
#' # Converting a file
#' # Create a temporary input file
#' input_file <- tempfile(fileext = ".R")
#' write("result <- mean(sqrt(abs(rnorm(10, 0, 1))), na.rm = TRUE)", input_file)
#'
#' # Convert the file using nested_to_pipe
#' output_file <- nested_to_pipe(input_file)
#'
#' # Check the converted file content
#' cat(readLines(output_file))
#' }
#' @export

nested_to_pipe <- function(r, n_tokens_limit=3000, ...) {
  
  # import, process text
  r <- read_text(r)
  text <- 
    r$text %>% 
    paste0(collapse = "\n")
  
  # Make sure intput is an R function
  if (!is_r(text) | nchar(text)==0){
    stop("The input does not contain valid R code.")
  }
  
  # Make sure the text input is not too long
  n_tokens <- count_tokens(text)
  if (n_tokens_limit < n_tokens) {
    stop("Text input contains too many tokens!")
  }
  
  # initial user input
  n_msgs <- nrow(nested_to_pipe_prompt)
  nested_to_pipe_prompt$content[n_msgs] <- 
    sprintf(fmt = nested_to_pipe_prompt$content[n_msgs], text)
  
  # chat
  cli::cli_alert_info("Code writing in progress. Hold on tight!")
  resp <- chat_completion(nested_to_pipe_prompt, ...)
  total_tokens_used <- usage(resp)$total_tokens
  info_token <- paste0("Total tokens used: ", total_tokens_used)
  cli::cli_inform(info_token)
  
  # extract output
  output <- 
    resp %>% 
    messages_content() %>% 
    clean_output()
  
  # validate output
  if (is_r(output)==FALSE){
    cli::cli_alert_warning("The conversion has potentially resulted in invalid R code. Please verify the output code carefully!")
  }

  # Return the processed r as BibTeX entries
  filename <- unique(r$file)
  if (filename == "character string") {
    return(output)
    
  } else {
    output_file <- paste0(replace_file_extension(filename, new_extension = ""), "-pipe.R")
    writeLines(output, output_file)
    return(output_file)
    
  }
  
}



