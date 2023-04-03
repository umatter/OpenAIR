
test_that("read_text handles character strings correctly", {
  text <- "Hello, how are you?\nI'm doing well, thanks!"
  
  result <- read_text(text)
  
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2)
  expect_equal(ncol(result), 4)
  expect_equal(unique(result$file), "character string")
  expect_equal(result$line, c(1, 2))
  expect_equal(unique(result$batch_index), 1)
})

test_that("read_text handles text files correctly", {
  text <- "Hello, how are you?\nI'm doing well, thanks!"
  temp_file <- tempfile(fileext = ".txt")
  writeLines(text, con = temp_file)
  
  result <- read_text(temp_file)
  
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2)
  expect_equal(ncol(result), 4)
  expect_equal(unique(result$file), temp_file)
  expect_equal(result$line, c(1, 2))
  expect_equal(unique(result$batch_index), 1)
})

test_that("read_text handles non-existent files correctly", {
  non_existent_file <- "non_existent_file.txt"
  
  # expect_warning(read_text(non_existent_file))
  # It seems reasonable to allow strings containing non-existent files in 
  # the context of OpenAIR
})