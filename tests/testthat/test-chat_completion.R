if (!is.null(Sys.getenv("OPENAI_API_KEY"))) {
  test_that("Basic chat completion works", {
    msgs_df <- data.frame(role=c("system", 
                                 "user",
                                 "assistant",
                                 "user"),
                          content=c("You are a helpful assistant", 
                                    "Who won the world series in 2020?",
                                    "The Los Angeles Dodgers won the World Series in 2020.",
                                    "Where was it played?"))
    resp <- chat_completion(msgs_df)
    # test util functions
    # extract ID
    resp %>% id()
    
    # extract response messages
    resp %>% messages()
    
    # extract model
    resp %>% model()
    
    # extract usage stats
    resp %>% usage()
    
    # extract timestamp in user-friendly format
    resp %>% created()
    
    # extract object info from response
    resp %>% object()
    # Add any other tests as needed
  })
} else {
  skip("API key not set, skipping test.")
}
