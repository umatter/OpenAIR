# Check if the OPENAI_API_KEY environment variable is set
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("python_to_r converts Python code to R code", {
    # Test with a Python code string
    python_code_string <- "x = 5\ny = 10\nprint(x + y)"
    expected_output <- 15
    
    # Convert the Python code to R code and evaluate it
    r_code_string <- python_to_r(python_code_string)
    r_output <- eval(parse(text = r_code_string))
    
    # Check if the Python and R outputs match
    expect_equal(r_output, expected_output)
    
    # Test with a Python code file
    python_file_path <- "test_python_code.py"
    python_code_string <- "x = 5\ny = 10\nprint(x + y)"
    expected_output <- 15
    
    # Write the Python code to a file and convert it to R code
    write(python_code_string, file = python_file_path)
    r_file_path <- python_to_r(python_file_path)
    r_code_string <- readLines(r_file_path) %>% paste(collapse = "\n")
    r_output <- eval(parse(text = r_code_string))
    
    # Check if the Python and R outputs match
    expect_equal(r_output, expected_output)

    # Test with a Python code string that contains syntax that doesn't have a direct equivalent in R
    test_python_code <- "try:\n  x = 5\nexcept Exception as e:\n  print(e)"
    expect_message(python_to_r(test_python_code), "The Python code contains syntax that doesn't have a direct equivalent in R.")

    # Test with an empty string
    expect_equal(python_to_r(""), "")

    # Test with a non-Python code string
    test_non_python_code <- "This is not Python code."
    expect_message(python_to_r(test_non_python_code), "The input string does not appear to be valid Python code.")
    
     })
} else {
  skip("API key not set, skipping test.")
}

# Clean up temporary files created during the test
file.remove("test_python_code.py", "test_python_code.R")
