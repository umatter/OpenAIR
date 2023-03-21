

# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  
  # Begin the test
  test_that("add_roxygen function works correctly", {
    # Test that function returns NULL for valid input
    test_that("add_roxygen returns NULL for valid input", {
      # Create a test file
      test_file <- tempfile(fileext = ".R")
      write("test_function <- function(x) { x + 1 }", test_file)
      
      # Test function
      result <- add_roxygen(test_file)
      
      # Check result
      expect_is(result, "NULL")
    })
    
    # Test that function adds Roxygen2 documentation to a file
    test_that("add_roxygen adds Roxygen2 documentation to a file", {
      # Create a test file
      test_file <- tempfile(fileext = ".R")
      write("test_function <- function(x) { x + 1 }", test_file)
      
      # Test function
      add_roxygen(test_file)
      
      # Check that file now contains Roxygen2 documentation
      expect_true(readLines(test_file)[1] == "#' test_function\n#' \n#' @param x\n#' @return\n#' @export\ntest_function <- function(x) { x + 1 }")
    })
    
    # Test that function throws an error for invalid input
    test_that("add_roxygen throws an error for invalid input", {
      # Test function with invalid input
      expect_error(add_roxygen("nonexistent_file.R"))
    })
  })
  
} else {
  test_that("add_roxygen skips test if API key not set", {
    skip("API key not set, skipping test.")
  })
}
