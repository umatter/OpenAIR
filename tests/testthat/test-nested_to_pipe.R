# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("nested_to_pipe function works correctly", {
    
    # Test that function returns a character string for valid input
    test_that("nested_to_pipe returns a character string for valid input", {
      input <- "result <- mean(sqrt(abs(rnorm(10, 0, 1))), na.rm = TRUE)"
      output <- nested_to_pipe(input)
      expect_type(output, "character")
    })
    
    # Test that function writes to a file and returns the output file path for valid input
    test_that("nested_to_pipe writes to a file and returns the output file path for valid input", {
      input_file <- tempfile(fileext = ".R")
      write("result <- mean(sqrt(abs(rnorm(10, 0, 1))), na.rm = TRUE)", input_file)
      
      output_file <- nested_to_pipe(input_file)
      expect_true(file.exists(output_file))
      expect_match(output_file, "-pipe.R$")
      
    })
    
    # Test that function throws an error for invalid input
    test_that("nested_to_pipe throws an error for invalid input", {
      input <- "invalid_input <- x + y"
      expect_error(nested_to_pipe(input), "The input does not contain valid R code.")
    })
    
    # Test that function throws an error if the input exceeds the token limit
    test_that("nested_to_pipe throws an error if the input exceeds the token limit", {
      long_input <- paste(rep("result <- mean(sqrt(abs(rnorm(10, 0, 1))), na.rm = TRUE)", 200), collapse = "\n")
      expect_error(nested_to_pipe(long_input, n_tokens_limit = 3000), "Text input contains too many tokens!")
    })
    
  })
  
} else {
  test_that("add_roxygen skips test if API key not set", {
    skip("API key not set, skipping test.")
  })
}
