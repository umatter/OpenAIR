if (!nchar(Sys.getenv("OPENAI_API_KEY"))==0) {
  test_that("High-level inflix chat function works", {
    
    # example, start conversation
    resp <-
      "Write a CV of a person worthy of joining the OpenAIR team as a developer" %c% 
      "response_object"
    resp
  })
} else {
  skip("API key not set, skipping test.")
}



