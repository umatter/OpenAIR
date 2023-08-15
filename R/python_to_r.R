#' Convert Python code to R code
#'
#' This function takes a Python code file or character string as input and
#' attempts to convert the code to R using the OpenAI API. The function provides
#' feedback on the total tokens used during the conversion and warns if the
#' output might not be valid R code.
#'
#' @param py A file path or character string containing the Python code to be
#' converted.
#' @param ... Additional arguments to pass to the chat_completion() function.
#'
#' @return If the input is a character string, the function returns the
#' converted R code as a character string. If the input is a file, the function
#' writes the converted R code to a new file with the same name and a ".R"
#' extension, and returns the output file path.
#'
#' @examples
#' \dontrun{
#' # Convert a Python code string to R code
#' python_code <- "x = 5"
#' r_code <- python_to_r(python_code)
#' print(r_code)
#'
#' # Convert a Python code file to an R code file
#' python_file <- "path/to/your/python_file.py"
#' r_file <- python_to_r(python_file)
#' cat(readLines(r_file), sep = "\n")
#' }
#'
#' @export

python_to_r <- function(py, ...) {

  # import, process text
  py <- read_text(py)
  text <-
    py$text %>%
    paste0(collapse = "\n")

  # initial user input
  n_msgs <- nrow(r_to_python_prompt)
  r_to_python_prompt$content[n_msgs] <-
    sprintf(fmt = r_to_python_prompt$content[n_msgs], text)

  # chat
  cli::cli_alert_info("R-code writing in progress. Hold on tight!")
  resp <- chat_completion(r_to_python_prompt, ...)
  total_tokens_used <- usage(resp)$total_tokens
  info_token <- paste0("Total tokens used: ", total_tokens_used)
  cli::cli_inform(info_token)

  # extract output
  output <-
    resp %>%
    messages_content() %>%
    clean_output()
  output <- gsub("^python", "", output)

  # validate output
  if (is_r(output) == FALSE){
    cli::cli_alert_warning(paste0("The conversion from Python to R has ",
    "potentially resulted in invalid R code. Please verify the output code ",
    "carefully!"))
  }

  # Return the processed py as R                                                                                                                                                                       
  if (is.null(py$file) || length(py$file) == 0) {                                                                                                                                                      
    return(output)                                                                                                                                                                                     
  } else {                                                                                                                                                                                             
    filename <- unique(py$file)                                                                                                                                                                        
    if (filename == "character string") {                                                                                                                                                              
      return(output)                                                                                                                                                                                   
    } else {                                                                                                                                                                                           
      output_file <- replace_file_extension(filename, new_extension = ".R")                                                                                                                            
      writeLines(output, output_file)                                                                                                                                                                  
      return(output_file)                                                                                                                                                                              
    }                                                                                                                                                                                                  
  }    
}