
test_that("extract_r_code works correctly", {
  
  # Test with a valid input string
  input_string <- "This is a text string with R code and comments.\n# A comment\nx <- 5\ny = 10\nz <- x + y\nAnother line of text."
  expected_output <- c("# A comment", "x <- 5", "y = 10", "z <- x + y")
  test_output <- extract_r_code(input_string)
  expect_equal(test_output, expected_output)
  
  # Test with an empty input string
  test_output_empty <- extract_r_code("")
  expect_equal(test_output_empty, character(0))
  
  # Test with an input string that has no R code or comments
  input_no_code <- "This is a text string without R code and comments."
  test_output_no_code <- extract_r_code(input_no_code)
  expect_equal(test_output_no_code, character(0))
})
