
# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  
  test_that("refactor function works correctly", {
    
    # Test that function returns a character string for a valid input
    test_that("refactor returns a character string for a valid input", {
      # Create a test file
      test_file <- tempfile(fileext = ".R")
      write("my_sum <- function(a, b) { return(a + b) }\n", test_file)
      
      # Test function
      result <- refactor(test_file)
      
      # Check result
      expect_type(result, "character")
      
      # Clean up temporary files
      file.remove(test_file)
    })
    
    # Test that function stops execution and returns an error message for an invalid input
    test_that("refactor stops execution for an invalid input", {
      # Create an invalid test file
      invalid_test_file <- tempfile(fileext = ".R")
      write("This is not a valid R function file.\n", invalid_test_file)
      
      # Test function with invalid input
      expect_error(refactor(invalid_test_file), "The input does not contain a valid R code.")
      
      # Clean up temporary files
      file.remove(invalid_test_file)
    })
    
  })
  
} else {
  test_that("refactor skips test if API key not set", {
    skip("API key not set, skipping test.")
  })
}


