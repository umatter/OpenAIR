#' Convert R Code to Python Code
#'
#' This function takes an R code file as input and uses a language model to convert the R code to Python code. The converted Python code is then either returned as a character string or written to a file, depending on the input.
#'
#' @param r The R code file to be converted to Python code. This should be a file path in the form of a character string.
#'
#' @return If the input filename is a "character string", the converted Python code will be returned as a character string. Otherwise, a new Python file will be created with the same name as the input file but with a ".py" extension, and the function will return the file path of the newly created Python file.
#'
#' @examples
#' \dontrun{
#' # Convert R code to Python code and display the result as a character string
#' r_to_python("example.R")
#'
#' # Convert R code to Python code and save it to a file
#' r_to_python("example.R", output_file = "example.py")
#'}
#' @export
r_to_python <- function(r) {
  
  # import, process text
  r <- read_text(r)
  text <- 
    r$text %>% 
    paste0(collapse = "\n")
  
  # initial user input
  n_msgs <- nrow(r_to_python_prompt)
  r_to_python_prompt$content[n_msgs] <- 
    sprintf(fmt = r_to_python_prompt$content[n_msgs], text)
  
  # chat
  resp <- chat_completion(r_to_python_prompt)
  total_tokens_used <- usage(resp)$total_tokens
  message("Total tokens used: ", total_tokens_used)
  
  # extract output
  output <- 
    resp %>% 
    messages_content() %>% 
    clean_output()
  
  output <- gsub("^python", "", output)
  
  # validate output
  if (is_python(output)==FALSE){
    warning("The conversion from R to Python has potentially resulted in invalid Python code. Please verify the output code carefully!")
  }

  # Return the processed r as BibTeX entries
  filename <- unique(r$file)
  if (filename == "character string") {
    message(output)
    return(output)
    
  } else {
    output_file <- replace_file_extension(filename, new_extension = ".py")
    writeLines(output, output_file)
    return(output_file)
    
  }
  
}



