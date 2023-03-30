# Check if the OPENAI_API_KEY environment variable is set
if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
  test_that("r_to_python converts R code to Python code", {
    # Define the R code and the expected output
    test_r_code <- "x <- 5; y <- 10; z <- x + y; print(z)"
    expected_output <- 15
    
    # Convert the R code to Python code and run it
    python_code <- r_to_python(test_r_code)
    temp_file <- tempfile()
    writeLines(python_code, temp_file)
    temp_stdout <- tempfile()
    temp_stderr <- tempfile()
    
    # Attempt to run the code with "python"
    exit_code_python <- tryCatch({
      suppressWarnings(system2("python", temp_file, stdout = temp_stdout, stderr = temp_stderr))
    }, error = function(e) {
      NA
    })
    
    # Attempt to run the code with "python3"
    exit_code_python3 <- tryCatch({
      suppressWarnings(system2("python3", temp_file, stdout = temp_stdout, stderr = temp_stderr ))
    }, error = function(e) {
      NA
    })
    
    # Check if the Python output matches the expected output
    python_output <- NA
    if (!is.na(exit_code_python)) {
      python_output <- as.numeric(trimws(readLines(temp_stdout)))
    } else if (!is.na(exit_code_python3)) {
      python_output <- as.numeric(trimws(readLines(temp_stdout)))
    }
    expect_equal(python_output, expected_output)
  })
} else {
  skip("API key not set, skipping test.")
}
