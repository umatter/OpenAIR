
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("extract_blocks function works", {
    
    # Test 1: Extract 'text' blocks
    input_blocks1 <- list(
      list(type = "text", content = "Hello world!"),
      list(type = "code", content = "print('Hello world!')")
    )
    expected_output1 <- list(list(type = "text", content = "Hello world!"))
    
    test_that("Text blocks are extracted correctly", {
      expect_equal(extract_blocks(input_blocks1, "text"), expected_output1)
    })
    
    # Test 2: Extract 'code' blocks
    input_blocks2 <- list(
      list(type = "text", content = "Hello world!"),
      list(type = "code", content = "print('Hello world!')")
    )
    expected_output2 <- list(list(type = "code", content = "print('Hello world!')"))
    
    test_that("Code blocks are extracted correctly", {
      expect_equal(extract_blocks(input_blocks2, "code"), expected_output2)
    })
    
    # Test 3: Extract non-existent block type
    input_blocks3 <- list(
      list(type = "text", content = "Hello world!"),
      list(type = "code", content = "print('Hello world!')")
    )
    expected_output3 <- list()
    
    test_that("Non-existent block type returns an empty list", {
      expect_equal(extract_blocks(input_blocks3, "unknown"), expected_output3)
    })
    
    # Test 4: Empty input list
    input_blocks4 <- list()
    expected_output4 <- list()
    
    test_that("Empty input list returns an empty list", {
      expect_equal(extract_blocks(input_blocks4, "text"), expected_output4)
    })
    
  })
} else {
  skip("API key not set, skipping test.")
}
