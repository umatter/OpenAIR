#' Edit code based on user's input
#'
#' The `edit_code` function prompts the user to provide a plain English description of how the code in a given file
#' should be modified. The function then generates the modified code based on the user's input
#' and writes it back to the specified file.
#'
#' @param filename A character string representing the name of the file containing the code to be edited.
#' @param chatlog_id An optional character string representing the chatlog ID. Defaults to ".__CURRENTCODEFILE__".
#'                   This ID is used to maintain the conversation history with the AI.
#' 
#' @return Returns the name of the file containing the modified code.
#'
#' @examples
#' \dontrun{
#' # Edit code in an existing file based on user input
#' modified_code_file <- edit_code("example_code.R")
#' 
#' # Check the content of the modified code file
#' cat(readLines(modified_code_file))
#' }
#' @export
edit_code <- 
  function(filename, chatlog_id = ".__CURRENTCODEFILE__") {
    
    if (!file.exists(filename)){
      stop("Did not find ", filename, " !", "Are you sure this is the right path?\n")
    }
    
    # check if code writing session was already initialized
    # if not, initialize new session
    if (!exists(chatlog_id, envir = OpenAIR_env)){
      # initialize chatlog
      cl <- start_chat(chatlog_id=chatlog_id)
      
    } else {
      # fetch current chat status
      cl <- get_chatlog(chatlog_id)
      
    }
    
    # open the file to edit
    file.edit(filename)
    
    # Initialize an empty character vector to store input text
    input_text <- character(0)
    
    # Prompt the user for input, and add each line to the input vector
    cat("Explain in plain English how the code should be modified. Type 'GO!' to finish.\n")
    while (TRUE) {
      input_line <- readline("Instruction:")
      if (tolower(input_line) == "go!") {
        break
      }
      input_text <- c(input_text, input_line)
    }
    
    # make prompt more robust
    instructions <- "Return everything in one code block! Do not add any explanations, simply return the code."
    input_text <- c(input_text, instructions)
    message <- paste0(input_text, collapse = "\n")
    
    # add new message to conversation, send
    resp <- 
      initialize_messages(initial_role = "user", initial_content = message)  %>% 
      add_to_chatlog(chatlog_id)  %>%  
      chat_completion()
    
    
    # process response
    messages <-   
      resp %>% 
      messages()
    
    # update chatlog
    add_to_chatlog(messages)
    
    # Write the output to the file
    writeLines(clean_output(messages$content), filename)
    file.edit(filename)
    
    cli::cli_alert_success("Here you go!")
    
    return(filename)
  }