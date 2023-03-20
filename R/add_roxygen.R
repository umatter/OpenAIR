#' Add Roxygen2 Documentation to R Function
#' 
#' This function reads in an R file, adds Roxygen2 documentation using chat input, and outputs the processed R file with Roxygen2 documentation.
#' 
#' @param file character string with the name of the R file to process
#' @return NULL
#' @author Ulrich Matter umatter@protonmail.com
#' @examples
#' add_roxygen("myRfile.R")
#' 
#' 
#' @export
add_roxygen <- function(file) {
  
  # import, process text
  r_function <- read_text(file)
  text <- 
    r_function$text %>% 
    paste0(collapse = "\n")
  
  # initial user input
  input <- add_roxygen_input
  n_msgs <- nrow(add_roxygen_input)
  input$content[n_msgs] <- 
    sprintf(fmt = input$content[n_msgs], text)
  
  # chat
  resp <- chat_completion(input)
  total_tokens_used <- usage(resp)$total_tokens
  message("Total tokens used: ", total_tokens_used)
  
  # extract output
  output <- 
    resp %>% 
    messages_content()

  # Return the processed r_function with Roxygen2 documentation
  filename <- unique(r_function$file)
  if (filename == "character string") {
    message(output)
    return(output)
    
  } else {
    cat(output, file=filename)
    message("Added documentation to ", filename)
    return(NULL)
    
  }
  
}