if (all(nchar(Sys.which(c("python", "python3")))) == 0) {
  skip("Python not installed, skipping test.")
} else {
  # Test that the is_python function recognizes valid Python code
  test_that("is_python recognizes valid Python code", {
    expect_true(is_python("print('Hello, World!')"))
    expect_true(is_python("x = 5"))
    code <-
"
x = 5
if x > 0:
    print('x is positive')
"
    expect_true(is_python(code))
  })

  # Test that the is_python function recognizes invalid Python code
  test_that("is_python recognizes invalid Python code", {
    expect_false(is_python("prit('Hello, World!')"))
    expect_false(is_python("x == 5"))
    expect_false(is_python("if x > 0\n    print('x is positive')"))
  })
}