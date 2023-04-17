
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("parse_response function works", {
    
    # Test 1: Text only
    input1 <- "Hello world!"
    expected_output1 <- list(list(type = "text", content = "Hello world!"))
    
    test_that("Text only is parsed correctly", {
      expect_equal(parse_response(input1), expected_output1)
    })
    
    # Test 2: Code block only
    input2 <- "```python\nprint('Hello world!')\n```"
    expected_output2 <- list(list(type = "code", content = "print('Hello world!')\n", language = "python"))
    
    test_that("Code block only is parsed correctly", {
      expect_equal(parse_response(input2), expected_output2)
    })
    
    # Test 3: Text and code block
    input3 <- "Hello world!\n\n```python\nprint('Hello world!')\n```"
    expected_output3 <- list(
      list(type = "text", content = "Hello world!\n\n"),
      list(type = "code", content = "print('Hello world!')\n", language = "python")
    )
    
    test_that("Text and code block are parsed correctly", {
      expect_equal(parse_response(input3), expected_output3)
    })
    
    # Test 4: Empty input
    input4 <- ""
    expected_output4 <- list(list(type = "text", content = ""))
    
    test_that("Empty input is parsed correctly", {
      expect_equal(parse_response(input4), expected_output4)
    })
    
  })
} else {
  skip("API key not set, skipping test.")
}
