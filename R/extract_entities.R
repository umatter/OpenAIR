#' Extract Entities from a Text
#'
#' This function takes a character string or a path to a text file and returns a tibble describing the entities found in the text.
#' The type of entities to be searched for and extracted can be defined by the user.
#'
#' @param text A character string containing the text to be processed, or a path to a text file
#' @param entity_types A character vector containing names of entity types to be extracted. Defaults to c("locations", "persons", "organizations").
#' @param batch_size An integer indicating the size of each batch, if the text input is supposed to be processed in batches. Set this to NULL to process all at once.
#' 
#' @return A tibble
#' 
#' @examples
#'  \dontrun{
#' extract_entities("Hello, how are you?")
#' extract_entities("path/to/text/file.txt",  batch_size = 100)
#' }
#' 
#' @export
extract_entities <- function(text, entity_types=c("locations", "persons", "organizations"), batch_size = NULL) {
  
  requireNamespace("dplyr", quietly = TRUE)
  
  if (is.null(batch_size)) {
    # process the entire text at once
    # import, process text
    text <- 
      read_text(text)$text %>% 
      paste0(collapse = "n")
  } else {
    text <- 
      read_text_batches(text, batch_size = batch_size)  %>% 
      lapply(FUN= function(x) paste0(x$text, collapse = ""))
  }
  
  results_list <- 
    lapply(text, FUN = function(tbatch) {
      
      # initial user input
      entity_types <- paste0(entity_types, collapse = ", ")
      extract_entities_input$content[2] <- sprintf(fmt = extract_entities_input$content[2], entity_types, text)
      
      # extract_entities_input <- data.frame(role=c("system", "user"),
      #                          content=c("You extract entities of different types from a text.",
      #                          "Please extract the following entities from the text below: %s .\n
      #                          %s
      #                          \n For each entity identified, indicate to which entity type it belongs and add a short description of the entity.
      #                          Return all of this information in a CSV-file format with the three columns name, entity_type, and description. \n
      #                          Thereby please place each CSV cell value in double quotes in order to make sure that the CSV can be parsed properly. Thanks!"))
      # 
      # # # initial user input
      # user_input <- 
      #   paste0("Please extract the following entities from the text below: ",
      #          paste0(entity_types, collapse = ", "), ".\n") %>% 
      #   paste(text) %>% 
      #   paste("\n For each entity identified, indicate to which entity type it belongs and add a short description of the entity. 
      #       Return all of this information in a CSV-file format with the three columns name, entity_type, and description")  %>% 
      #   paste0("\n Thereby please place each CSV cell value in double quotes in order to make sure that the CSV can be parsed properly. Thanks!")
      
      # chat
      resp <- chat_completion(extract_entities_input)
      total_tokens_used <- usage(resp)$total_tokens
      message("Total tokens used: ", total_tokens_used)

      # process response
      msg_resp <- messages(resp)
      entities <- readr::read_csv(msg_resp$content)
      
      return(entities)
  })
  
  # stack results
  entities_df <- dplyr::bind_rows(results_list)
  
  # Return the processed text
  return(entities_df)
}



