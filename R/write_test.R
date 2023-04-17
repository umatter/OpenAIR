#' Write test for an R function
#'
#' This function reads an R function from a file and generates a test file with documentation. 
#' 
#' @param file The file path of the R function.
#' @return If the input is a character string, the function returns the generated output without creating a test file. Otherwise, it creates a test file and returns the file name.
#' @export
#' @examples 
#' \dontrun{
#' # Write test for an R function
#' write_test("path/to/file.R")
#' }
#' 


write_test <- function(file) {
  
  # import, process text
  r_function <- read_text(file)

  # Read the content of the file
  text <- 
    r_function$text %>% 
    paste0(collapse = "\n")
  
  # Make sure intput is an R function
  if (!contains_r_func(text) | nchar(text)==0){
    stop("The input does not contain a valid R function.")
  }

  # Create user input 
  n_msgs <- nrow(write_test_prompt)
  write_test_prompt$content[n_msgs] <- 
    sprintf(fmt = write_test_prompt$content[n_msgs], text)

  # chat
  cli::cli_alert_info("Test-writing in progress. Hold on tight!")
  resp <- chat_completion(r_to_python_prompt)
  total_tokens_used <- usage(resp)$total_tokens
  info_token <- paste0("Total tokens used: ", total_tokens_used)
  cli::cli_inform(info_token)

  # extract output
  output <- 
    resp %>% 
    messages_content()

  # Prepare/process output
  filename <- unique(r_function$file)

  if (filename == "character string") {
    return(output)
    
  } else {
    filename <- paste0(replace_file_extension(filename, new_extension = ""), "-test.R")
    file.edit(filename)
    return(filename)
    
  }
  
}
