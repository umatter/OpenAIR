#' Add Roxygen2 documentation to an R function
#'
#' This function adds Roxygen2 documentation to an R function.
#'
#' @param file A character string indicating the path to the file containing the R function.
#' 
#' @return If the path provided is a character string, this function returns the documented function in a 
#' message to the console. If the Roxygen2 documentation was added successfully, this function returns a message indicating 
#' that documentation was added to the file.
#' @author Ulrich Matter umatter@protonmail.com
#' 
#' @export
add_roxygen <- function(file) {
  
  # import, process text
  r_function <- read_text(file)
  text <- 
    r_function$text %>% 
    paste0(collapse = "\n")
  
  # Make sure intput is an R function
  if (!contains_r_func(text) | nchar(text)==0){
    stop("The input does not contain a valid R function.")
  }

  # initial user input
  input <- add_roxygen_input
  n_msgs <- nrow(input)
  input$content[n_msgs] <- 
    sprintf(fmt = input$content[n_msgs], text)

  # chat
  resp <- chat_completion(input)
  total_tokens_used <- usage(resp)$total_tokens
  message("Total tokens used: ", total_tokens_used)

  # extract roxygen2 documentation
  output <- 
    resp %>% 
    messages_content() %>% 
    extract_roxygen2()
  
  # prepare output
  filename <- unique(r_function$file)
  if (filename == "character string") {
    message(output)
    return(output)
    
  } else {
    rfunc <- readLines(filename)
    rfunc_documented <- c(output, rfunc)
    output <- paste0(rfunc_documented, collapse="\n")
    cat(output, file = filename)
    message("Added documentation to ", filename)

  }

}