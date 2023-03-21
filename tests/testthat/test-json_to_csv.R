
# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  
  # Begin the test
  test_that("json_to_csv_input function works correctly", {
    # Test that function returns output for valid input
    test_that("json_to_csv_input returns output for valid input", {
      # Create a test file
      test_file <- tempfile(fileext = ".json")
      write('{"employees":[{"firstName":"John","lastName":"Doe"},{"firstName":"Anna","lastName":"Smith"},{"firstName":"Peter","lastName":"Jones"}]}', test_file)
      
      # Test function
      result <- json_to_csv(test_file)
      
      # Check result
      expect_true(is.data.frame(result))
      expect_true(file.exists(replace_file_extension(test_file, ".csv")))
    })
    
    # Test that function prints output for valid input as character string
    test_that("json_to_csv prints output for valid input as character string", {
      # Create a test string
      test_string <- '{"employees":[{"firstName":"John","lastName":"Doe"},{"firstName":"Anna","lastName":"Smith"},{"firstName":"Peter","lastName":"Jones"}]}'
      
      # Capture console output
      capture_output(result <- json_to_csv(test_string))
      
      # Check result
      expect_type(result, "character")
    })
    
    # Test that function throws an error for invalid input
    test_that("json_to_csv throws an error for invalid input", {
      # Test function with invalid input
      expect_error(json_to_csv("nonexistent_file.json"))
    })
  })
  
} else {
  test_that("json_to_csv_input skips test if API key not set", {
    skip("API key not set, skipping test.")
  })
}
