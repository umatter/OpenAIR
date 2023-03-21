#' Process and tidy air data from a CSV file or a data.frame
#'
#' This function takes a CSV file or a data.frame containing air data as input,
#' processes the data using the tidyair package, and returns a tidied data.frame
#' if the input is a data.frame or the file path of the generated CSV file.
#' If the input is a CSV file, the function also writes the tidied data to a new CSV file
#' with the same name and path as the input file but with a "-tidy.csv" suffix.
#'
#' @param file A character string specifying the path to a CSV file, or a data.frame
#'   containing air data to be processed.
#' @return A data.frame containing the processed and tidied air data if the input is
#'   a data.frame, or a character string with the file path of the generated CSV file if the input is a file.
#' @author Ulrich Matter umatter@protonmail.com
#' 
#' @export
#' 
#' @examples
#' # Create a data.frame with air data
#' air_data <- data.frame(
#'   Time = c("2021-01-01", "2021-01-02", "2021-01-03"),
#'   PM25 = c(10, 12, 15),
#'   PM10 = c(20, 25, 30),
#'   stringsAsFactors = FALSE
#' )
#'
#' # Process the data.frame using tidyair
#' tidied_data <- tidyair(air_data)
#' print(tidied_data)
tidyair <- function(file) {
  
  is_df <- is.data.frame(file)
  if (is_df) {
    file <- df_to_csv(file)
  }
  
  # import, process text
  r_function <- read_text(file)
  text <- 
    r_function$text %>% 
    paste0(collapse = "\n")
  
  # Create user input 
  input <- tidyair_input
  n_msgs <- nrow(tidyair_input)
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
  
  # process output
  filename <- unique(r_function$file)
  
  if (filename == "character string") {
    # console/df input is returned as df
    output_df <- readr::read_csv(output)
    return(output_df)
    
  } else {
    # file name for csv file
    filename <- paste0(replace_file_extension(filename, ""), "-tidy.csv")
    
    # parse and write csv
    output_df <- readr::read_csv(output)
    readr::write_csv(output_df, file = filename)
    message("CSV-file generated: ", filename)
    
    return(filename)
  }
  
}
