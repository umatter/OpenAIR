
test_that("is_r checks for valid R code", {
  # Test with valid R code
  valid_code <- "x <- 5; y <- 10; z <- x + y"
  expect_true(is_r(valid_code))
  
  # Test with invalid R code
  invalid_code <- "x <- 5 + 'a'"
  expect_false(is_r(invalid_code))
  
  # Test with an empty string
  empty_code <- ""
  expect_false(is_r(empty_code))
  
  # Test with a non-character input
  non_char_input <- 123
  expect_false(is_r(non_char_input))
})
