

# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  
  # Begin the test
  test_that("write_test function works correctly", {
    # Test that function returns character for valid input
    test_that("write_test returns character for valid input", {

      # Test function
      result <- write_test("test_function <- function(x) { x + 1 }")
      
      # Check result
      expect_type(result, "character")
    })
    
   
    # Test that function throws an error for invalid input
    test_that("write_test throws an error for invalid input", {
      # Test function with invalid input
      expect_error(write_test("nonexistent_file.R"))
    })
  })
  
} else {
  test_that("write_test skips test if API key not set", {
    skip("API key not set, skipping test.")
  })
}
