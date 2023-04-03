
test_that("split_text returns the correct number of chunks and tokens", {
  text <- "This is an example of a large text string that will be split into chunks of N tokens each by our custom R function."
  N <- 5
  
  result <- split_text(text, N)
  
  expected_num_chunks <- ceiling(length(str_split(text, "\\s+")[[1]]) / N)
  expect_equal(length(result), expected_num_chunks)
  
  for (chunk in result[-length(result)]) {
    expect_equal(length(str_split(chunk, "\\s+")[[1]]), N)
  }
})

test_that("split_text works with non-integer N values", {
  text <- "This is an example of a large text string that will be split into chunks of N tokens each by our custom R function."
  N <- 5.2
  
  expect_error(split_text(text, N), "Error: N must be a positive integer.")
})

test_that("split_text works with negative N values", {
  text <- "This is an example of a large text string that will be split into chunks of N tokens each by our custom R function."
  N <- -5
  
  expect_error(split_text(text, N), "Error: N must be a positive integer.")
})
