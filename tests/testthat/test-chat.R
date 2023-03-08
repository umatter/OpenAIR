if (!nchar(Sys.getenv("OPENAI_API_KEY"))==0) {
  test_that("High-level chat conversation works", {
    
    # chat conversation starts
    chat("Please write a 200 words essay explaining what ChatGPT is. However, instead of writing it in a common sense style, write it in the style of a speech by Donald Trump.")
    # follow-up message/task
    chat("Now rewrate the essay, but this time write it in the style of the late Steve Jobs.")
  })
} else {
  skip("API key not set, skipping test.")
}



