if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("Messages function works", {
    
    # Using a response object
    response <- list(choices = list(message = "This is a message."))
    messages_from_response <- messages(response)
    
    # Check that the returned value is a character string
    expect_type(messages_from_response, "character")
    
    # Check that the returned message is correct
    expect_equal(messages_from_response, "This is a message.")
    
    # Start a chat and save the chatlog ID
    chatlog_id <- chat("Hello, how are you?")
    
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
