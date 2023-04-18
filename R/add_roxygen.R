#' Add Roxygen2 documentation to an R function
#'
#' This function adds Roxygen2 documentation to an R function.
#'
#' @param file A character string indicating the path to the file containing the R function.
#' @return If the path provided is a character string, this function returns the documented function as a character string. If the input is a file path, this function returns the path of the file to which documentation was added to the file.
#' @export
#' @author Ulrich Matter umatter@protonmail.com
#' 

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
  n_msgs <- nrow(add_roxygen_prompt)
  add_roxygen_prompt$content[n_msgs] <- 
    sprintf(fmt = add_roxygen_prompt$content[n_msgs], text)

  # chat
  cli::cli_alert_info("Code documentation in progress. Hold on tight!")
  resp <- chat_completion(add_roxygen_prompt)
  total_tokens_used <- usage(resp)$total_tokens
  info_token <- paste0("Total tokens used: ", total_tokens_used)
  cli::cli_inform(info_token)

  # extract roxygen2 documentation
  output <- 
    resp %>% 
    messages_content() %>% 
    extract_roxygen2()
  
  # prepare output
  filename <- unique(r_function$file)
  if (filename == "character string") {
    return(output)
    
  } else {
    rfunc <- readLines(filename)
    rfunc_documented <- c(output, rfunc)
    output <- paste0(rfunc_documented, collapse="\n")
    cat(output, file = filename)
    cli::cli_alert_success(paste0("Added documentation to ", filename))
    return(filename)
  }
}