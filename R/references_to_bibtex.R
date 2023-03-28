#' Convert references in plain text to BibTeX format
#'
#' This function takes a character string or a file path to plain text references and
#' converts them into BibTeX format. The function reads the input text, processes it, and
#' returns a character string containing the references in BibTeX format. If a file path is
#' provided, the function also writes the BibTeX entries to a .bib file in the same
#' directory.
#'
#' @param references A character string or a file path to a file containing the plain text references to convert.
#' @return A character string containing the references in BibTeX format. If a file path is provided, the function also writes the BibTeX entries to a .bib file in the same directory and returns the file path of the newly created .bib file.
#' @author Ulrich Matter umatter@protonmail.com
#' @seealso \url{https://ctan.org/pkg/bibtex} for more information on BibTeX format
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
  n_msgs <- nrow(references_to_bibtex_prompt)
  references_to_bibtex_prompt$content[n_msgs] <- 
    sprintf(fmt = references_to_bibtex_prompt$content[n_msgs], text)
  
  # chat
  resp <- chat_completion(references_to_bibtex_prompt)
  total_tokens_used <- usage(resp)$total_tokens
  message("Total tokens used: ", total_tokens_used)
  
  # extract output
  output <- 
    resp %>% 
    messages_content() %>% 
    clean_output() 

  # Return the processed references as BibTeX entries
  filename <- unique(references$file)
  if (filename == "character string") {
    message(output)
    return(output)
    
  } else {
    output_file <- replace_file_extension(filename, new_extension = ".bib")
    writeLines(output, output_file)
    return(output_file)
    
  }
  
}



