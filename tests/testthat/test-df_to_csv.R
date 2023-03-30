# Begin the test
test_that("df_to_csv function works correctly", {
  # Test that function returns output for valid data.frame input
  test_that("df_to_csv returns output for valid data.frame input", {
    # Create a data.frame
    example_data <- data.frame(
      Name = c("Alice", "Bob", "Carol"),
      Age = c(30, 25, 28),
      Height = c(168, 175, 162),
      stringsAsFactors = FALSE
    )
    
    # Test function
    result <- df_to_csv(example_data)
    
    # Check result
    expect_type(result, "character")
    # Check if the content matches the expected CSV structure
    expected_csv_string <- "Name,Age,Height\nAlice,30,168\nBob,25,175\nCarol,28,162"
    expect_equal(readr::read_csv(result), readr::read_csv(expected_csv_string))
  })
  
  # Test that function throws an error for invalid input
  test_that("df_to_csv throws an error for invalid input", {
    # Test function with invalid input
    expect_error(df_to_csv("nonexistent_file.csv"))
  })
})
