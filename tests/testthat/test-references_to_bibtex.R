
# Check if the API key is available
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  
  # Begin the test
  test_that("references_to_bibtex function works correctly", {
    # Test with a character string containing a plain text reference
    references <- "Doe, J., & Smith, J. (2020). The title of the paper. Journal of Scientific Computing, 12, 45-67."
    
    # Call the references_to_bibtex function (assuming the function has been modified to use an API key)
    bibtex_output <- references_to_bibtex(references)
    
    # Test the output format (modify the regular expression to match the desired output format)
    expect_match(bibtex_output, "^[@|\n@].+\\{.+,.+\\}", all = TRUE)
  })
  
} else {
  skip("API key not set, skipping test.")
}
