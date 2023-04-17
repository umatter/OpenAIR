#' Convert Java code to R code
#'
#' This function takes Java code as input and returns the corresponding R code.
#' It uses GPT-4 powered chat to perform the code conversion.
#'
#' @param java A character string containing the Java code to be converted to R, or a filename with the Java code.
#'
#' @return If the input is a character string, the resulting R code will be printed and returned as a character string.
#'         If the input is a filename, the resulting R code will be saved as a file with the same name as the input file, but with the extension `.R`, and the filename will be returned.
#'
#' @details This function is not guaranteed to provide perfect conversions and might produce invalid R code in some cases.
#'          Users are encouraged to verify the output code carefully.
#'
#' @examples
#' \dontrun{
#' # Convert a simple Java code snippet to R
#' java_code <- "public class HelloWorld {
#'                public static void main(String[] args) {
#'                  System.out.println(\"Hello, world!\");
#'                }
#'              }"
#' r_code <- java_to_r(java_code)
#' cat(r_code)
#'
#' # Convert Java code from a file and save the result to an R file
#' input_file <- "path/to/java_file.java"
#' output_file <- java_to_r(input_file)
#' }
#'
#' @export


java_to_r <- function(java) {
  
  # import, process text
  java <- read_text(java)
  text <- 
    java$text %>% 
    paste0(collapse = "\n")
  
  # initial user input
  n_msgs <- nrow(java_to_r_prompt)
  java_to_r_prompt$content[n_msgs] <- 
    sprintf(fmt = java_to_r_prompt$content[n_msgs], text)
  
  # chat
  cli::cli_alert_info("Code writing in progress. Hold on tight!")
  resp <- chat_completion(java_to_r_prompt)
  total_tokens_used <- usage(resp)$total_tokens
  info_token <- paste0("Total tokens used: ", total_tokens_used)
  cli::cli_inform(info_token)
  
  
  # extract output
  output <- 
    resp %>% 
    messages_content() %>% 
    clean_output() 
  output <- gsub("^[Jj]ava", "", output)
  
  # validate output
  if (is_r(output)==FALSE){
    cli::cli_alert_warning("The conversion from Java to R has potentially resulted in invalid R code. Please verify the output code carefully!")
  }
  
  # Return the processed java as R code
  filename <- unique(java$file)
  if (filename == "character string") {
    message(output)
    return(output)
    
  } else {
    output_file <- replace_file_extension(filename, new_extension = ".R")
    writeLines(output, output_file)
    return(output_file)
    
  }
  
}


