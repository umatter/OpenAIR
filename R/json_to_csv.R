#' Convert JSON input to CSV
#'
#' This function takes a file with JSON input and processes it to generate 
#' corresponding output in CSV format. If the input is a character string, 
#' the output will be printed to the console. Otherwise, a CSV file will be 
#' generated with the same name as the input file but with a .csv extension.
#'
#' @param file A character string representing the path to the file with JSON input
#'
#' @return If the input is a character string, the function returns the output 
#' as a character string and prints it to the console. Otherwise, the function returns 
#' the output as a data frame and generates a CSV file with the same name as the input file 
#' but with a .csv extension.
#'
#' @examples
#' 
#' json_string <- '{"employees":[
#' { "firstName":"John", "lastName":"Doe" },
#' { "firstName":"Anna", "lastName":"Smith" },
#' { "firstName":"Peter", "lastName":"Jones" }
#' ]}'
#' json_to_csv(json_string)
#' 
#' @export
json_to_csv <- function(file) {
  
  # import, process text
  r_function <- read_text(file)
  text <- 
    r_function$text %>% 
    paste0(collapse = "\n")
  
  if (unique(r_function$file)=="character string") {
    if (!is_json(text)){
      stop("No valid JSON string provided!")
    }
  }

  # Create user input 
  input <- json_to_csv_input
  n_msgs <- nrow(json_to_csv_input)
  input$content[n_msgs] <- 
    sprintf(fmt = input$content[n_msgs], text)

  # Generate response output by chatting 
  resp <- chat_completion(input)
  total_tokens_used <- usage(resp)$total_tokens
  message("Total tokens used: ", total_tokens_used)

  # extract output
  output <- 
    resp %>% 
    messages_content()

  # Check if filename is a character string 
  # process output
  filename <- unique(r_function$file)
  
  if (filename == "character string") {
    message(output)
    return(output)
    
  } else {
    # file name for csv file
    filename <- replace_file_extension(filename, ".csv")
    # parse and write csv
    output_df <- readr::read_csv(output)
    readr::write_csv(output_df, file = filename)
    message("CSV-file generated: ", filename)
    return(output_df)
    
  }
  
}