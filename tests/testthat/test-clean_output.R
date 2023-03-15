test_that("clean_output function works correctly", {
  # Test with the example provided in the function documentation
  code_text <- "```
example_code <- function(x) {
  return(x * 2)
}
```"
  expected_output <- "\nexample_code <- function(x) {\n  return(x * 2)\n}\n"
  expect_equal(clean_output(code_text), expected_output)
  
  # Test with a string without newline characters
  code_text <- "```example_code <- function(x) {return(x * 2)}```"
  expected_output <- "example_code <- function(x) {return(x * 2)}"
  expect_equal(clean_output(code_text), expected_output)
  
  # Test with a string without '```' markers
  code_text <- "example_code <- function(x) {return(x * 2)}"
  expected_output <- "example_code <- function(x) {return(x * 2)}"
  expect_equal(clean_output(code_text), expected_output)
  
  # Test with an empty string
  code_text <- ""
  expected_output <- ""
  expect_equal(clean_output(code_text), expected_output)
})
