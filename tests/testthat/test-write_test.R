

# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  
  # Begin the test
  test_that("write_test function works correctly", {
    # Test that function returns NULL for valid input
    test_that("write_test returns NULL for valid input", {
      # Create a test file
      test_file <- tempfile(fileext = ".R")
      write("test_function <- function(x) { x + 1 }", test_file)
      
      # Test function
      result <- write_test(test_file)
      
      # Check result
      expect_is(result, "NULL")
    })
    
    # Test that function writes Roxygen2 documentation to a file
    test_that("write_test writes Roxygen2 documentation to a file", {
      # Create a test file
      test_file <- tempfile(fileext = ".R")
      write("test_function <- function(x) { x + 1 }", test_file)
      
      # Test function
      write_test(test_file)
      
      # Check that test file now exists 
      expect_true(file.exists(file_path_sans_ext(test_file) %s+% "-test.R"))
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
