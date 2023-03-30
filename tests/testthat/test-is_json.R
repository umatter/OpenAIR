
# Begin the test
test_that("is_json function works correctly", {
  # Test that function returns TRUE for valid input
  test_that("is_json returns TRUE for valid input", {
    # Test function with valid input
    expect_true(is_json('{"name": "John", "age": 30}'))
  })
  
  # Test that function returns FALSE for invalid input
  test_that("is_json returns FALSE for invalid input", {
    # Test function with invalid input
    expect_false(is_json('{"name": "John", age: 30}'))
  })
  
  # Test that function returns FALSE for empty input
  test_that("is_json returns FALSE for empty input", {
    # Test function with empty input
    expect_false(is_json(''))
  })
  
  # Test that function throws a warning for non-character input
  test_that("is_json throws a warning for non-character input", {
    # Test function with non-character input
    expect_warning(is_json(123))
  })
})
