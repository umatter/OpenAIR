if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("Regenerate function works", {
    
    # clean up
    #clear_chatlog()
    
    # Start a chat and save the chatlog ID
    chat("Tell me a joke.")
    
    # Regenerate the last response in the chat and return it as a message
    message1 <- regenerate(output = "message")
    
    # Regenerate the last response in the chat and return it as a response object
    response_object <- regenerate(output = "response_object")
    
    # Check that the response object has the correct class
    expect_type(response_object, "list")
    
    # Check that the response object has the correct elements
    expect_true("id" %in% names(response_object))
    expect_true("object" %in% names(response_object))
    expect_true("created" %in% names(response_object))
    expect_true("model" %in% names(response_object))
    expect_true("usage" %in% names(response_object))
    expect_true("choices" %in% names(response_object))
    
  })
} else {
  skip("API key not set, skipping test.")
}
