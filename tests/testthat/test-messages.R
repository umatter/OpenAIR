if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("Messages function works", {
    
    # Using a response object
    messages_from_response <- "tell me a joke" %c% "response_object" %>%  messages()

    # Check that the returned value is a character string
    expect_type(messages_from_response$content, "character")
    
    # Start a chat and save the chatlog ID
    chatlog_id <- "testid"
    chat("tell me a joke", chatlog_id = chatlog_id)
    
    # Using a chatlog object
    chatlog <- get_chatlog(chatlog_id)
    messages_from_chatlog <- messages(chatlog)
    
    # Check that the returned value is a data.frame
    expect_s3_class(messages_from_chatlog, "data.frame")
    
    # Check that the returned messages are not empty
    expect_true(nrow(messages_from_chatlog) > 0)
    
  })
} else {
  skip("API key not set, skipping test.")
}
