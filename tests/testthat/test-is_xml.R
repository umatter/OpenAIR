
# Begin the test
test_that("is_xml function works correctly", {
  # Test that function returns TRUE for valid input
  test_that("is_xml returns TRUE for valid input", {
    # Test function with valid input
    expect_true(is_xml('<?xml version="1.0"?><root><element>value</element></root>'))
  })
  
  # Test that function returns FALSE for invalid input
  test_that("is_xml returns FALSE for invalid input", {
    # Test function with invalid input
    expect_false(is_xml('<root><element>value</element></root'))
  })
  
  # Test that function returns FALSE for empty input
  test_that("is_xml returns FALSE for empty input", {
    # Test function with empty input
    expect_false(is_xml(''))
  })
  
  # Test that function throws a warning for non-character input
  test_that("is_xml throws a warning for non-character input", {
    # Test function with non-character input
    expect_warning(is_xml(123))
  })
})
