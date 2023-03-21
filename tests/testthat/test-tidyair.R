# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  
  # Begin the test
  test_that("tidyair function works correctly", {
    # Test that function returns output for valid data.frame input
    test_that("tidyair returns output for valid data.frame input", {
      # Create a data.frame with air data
      air_data <- data.frame(
        Time = c("2021-01-01", "2021-01-02", "2021-01-03"),
        PM25 = c(10, 12, 15),
        PM10 = c(20, 25, 30),
        stringsAsFactors = FALSE
      )
      
      # Test function
      result <- tidyair(air_data)
      
      # Check result
      expect_true(is.data.frame(result))
    })
    
    # Test that function returns output for valid CSV file input
    test_that("tidyair returns output for valid CSV file input", {
      # Create a test file
      test_file <- tempfile(fileext = ".csv")
      write("Time,PM25,PM10\n2021-01-01,10,20\n2021-01-02,12,25\n2021-01-03,15,30", test_file)
      
      # Test function
      result <- tidyair(test_file)
      
      # Check result
      expect_true(file.exists(paste0(replace_file_extension(test_file, ""), "-tidy.csv")))
    })
    
    # Test that function throws an error for invalid input
    test_that("tidyair throws an error for invalid input", {
      # Test function with invalid input
      expect_error(tidyair(4))
    })
  })
  
} else {
  test_that("tidyair skips test if API key not set", {
    skip("API key not set, skipping test.")
  })
}
