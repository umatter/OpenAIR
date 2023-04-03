
# Test the function
test_that("count_tokens() correctly counts the number of tokens in a text string", {
  
  # Test with a simple string
  expect_equal(count_tokens("This is a test."), 5)
  
  # Test with a string containing special characters
  expect_equal(count_tokens("Hello, world! This is a test."), 9)
  
  # Test with an empty string
  expect_equal(count_tokens(""), 0)
  
  # Test with a string containing only whitespace
  expect_equal(count_tokens("    "), 0)
  
  # Test with a file path
  test_file_path <- tempfile()
  writeLines("This is a test.", test_file_path)
  expect_equal(count_tokens(test_file_path), 5)
  file.remove(test_file_path)
  
  # Test with a long string
  long_string <- paste(rep("This is a test.", 1000), collapse = " ")
  expect_equal(count_tokens(long_string), 5000)
  
  # Test with a string containing non-ASCII characters
  expect_equal(count_tokens("Voilà! C'est un test."), 8)
  
})
