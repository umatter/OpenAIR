#' Write Test 
#'
#' Writes a test file with Roxygen2 documentation 
#'
#' @param file A file to test documentation for
#'
#' @return The processed r_function with the Roxygen2 documentation 
#'
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#' @examples
#' write_test("inst/text/func.R")
#' 
#' 

write_test <- function(file) {
  
  # import, process text
  r_function <- read_text(file)

  # Read the content of the file
  text <- 
    r_function$text %>% 
    paste0(collapse = "\n")

  # Create user input 
  input <- write_test_input
  n_msgs <- nrow(write_test_input)
  input$content[n_msgs] <- 
    sprintf(fmt = input$content[n_msgs], text)

  # Generate response output by chatting 
  resp <- chat_completion(input)
  total_tokens_used <- usage(resp)$total_tokens
  
  # Display the total use of tokens
  message("Total tokens used: ", total_tokens_used)

  # extract output
  output <- 
    resp %>% 
    messages_content()

  # Prepare/process output
  filename <- unique(r_function$file)

  if (filename == "character string") {
    message(output)
    return(output)
    
  } else {
    filename <- paste0(replace_file_extension(filename, ""), "-test.R")
    cat(output, file=filename)
    message("Added documentation to ", filename)
    return(NULL)
    
  }
  
}