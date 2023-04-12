#' Write code based on user's input
#'
#' The `write_code` function prompts the user to provide a plain English description of a program or function
#' and the programming language it should be written in. The function then generates the code based on the user's input
#' and writes it to a specified file.
#'
#' @param filename A character string representing the name of the file where the generated code will be saved.
#' @param chatlog_id An optional character string representing the chatlog ID. Defaults to ".__CURRENTCODEFILE__".
#'                   This ID is used to maintain the conversation history with the AI.
#' 
#' @return Returns the name of the file containing the generated code.
#'
#' @examples
#' \dontrun{
#' # Generate code based on user input and save it to a file
#' generated_code_file <- write_code("example_code.R")
#' 
#' # Check the content of the generated code file
#' cat(readLines(generated_code_file))
#' }
#' @export

write_code <- 
  function(filename, chatlog_id = ".__CURRENTCODEFILE__") {
    
    # check if code writing session was already initialized
    # if not, initialize new session
    if (!exists(chatlog_id, envir = OpenAIR_env)){
      # initialize chatlog
      cl <- start_chat(chatlog_id=chatlog_id)
      
    } else {
      # fetch current chat status
      cl <- get_chatlog(chatlog_id)
      
    }
    
    # create and open the new file
    file.create(filename)
    file.edit(filename)
    
    # Initialize an empty character vector to store input text
    input_text <- character(0)
    
    # Prompt the user for input, and add each line to the input vector
    cat("Explain in plain English what the program/function to be written should do an in what language it should be written in. Type 'GO!' to finish.\n")
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
    cli::cli_alert_info("Code writing in progress. Hold on tight!")
    
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