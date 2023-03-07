test_that("Basic chat completion works", {
msgs_df <- data.frame(role=c("system", 
                             "user",
                             "assistant",
                             "user"),
                      content=c("You are a helpful assistant", 
                                "Who won the world series in 2020?",
                                "The Los Angeles Dodgers won the World Series in 2020.",
                                "Where was it played?"))
chat_completion(msgs_df)

})
