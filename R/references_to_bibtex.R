#' Convert references in plain text to BibTeX format
#'
#' This function takes a character string or file path to plain text references and 
#' converts them to BibTeX format.
#'
#' @param references A character string or file path to a file containing the plain text references to convert.
#' @return A character string containing the references in BibTeX format.
#' @author Ulrich Matter <umatter@protonmail.com>
#' @examples
#' \dontrun{
#' # Convert plain text references to BibTeX format
#' references <- "Doe, J., & Smith, J. (2020). The title of the paper.
#' Journal of Scientific Computing, 12, 45-67."
#' references_to_bibtex(references)
#' }
 #' @export


references_to_bibtex <- function(references) {
  
  # import, process text
  references <- read_text(references)
  text <- 
    references$text %>% 
    paste0(collapse = "\n")
  
  # initial user input
  n_msgs <- nrow(references_to_bibtex_input)
  references_to_bibtex_input$content[n_msgs] <- 
    sprintf(fmt = references_to_bibtex_input$content[n_msgs], text)
  
  # chat
  resp <- chat_completion(references_to_bibtex_input)
  total_tokens_used <- usage(resp)$total_tokens
  message("Total tokens used: ", total_tokens_used)
  
  # extract output
  output <- 
    resp %>% 
    messages_content() %>% 
    clean_output() 
  
  # test output
  
  
  # Return the processed references as BibTeX entries
  if (references$file == "character string") {
    message(output)
  } else {
    output_file <- replace_file_extension(references$file)
    writeLines(output, output_file)
  }
  
  return(output)
}



