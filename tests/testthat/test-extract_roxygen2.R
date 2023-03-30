# Test the extract_roxygen2 function

test_that("extract_roxygen2 returns the correct roxygen2 documentation lines", {
  # Define a function with roxygen2 documentation
  func_def <- c(
    "#' This function adds two numbers together.",
    "#'",
    "#' @param x A number to be added.",
    "#' @param y A number to be added.",
    "#'",
    "#' @return The sum of x and y.",
    "#'",
    "#' @examples",
    "#' add(2, 3)",
    "#'",
    "#' @export",
    "add <- function(x, y) {",
    "  return(x + y)",
    "}"
  ) %>% paste0(collapse = "\n")
  
  # Extract the roxygen2 documentation
  roxygen2_lines <- extract_roxygen2(func_def)
  
  # Check that the roxygen2 documentation is correct
  expect_equal(roxygen2_lines, 
               "#' This function adds two numbers together.\n#'\n#' @param x A number to be added.\n#' @param y A number to be added.\n#'\n#' @return The sum of x and y.\n#'\n#' @examples\n#' add(2, 3)\n#'\n#' @export")
})

test_that("extract_roxygen2 returns an empty string if no roxygen2 documentation is found", {
  # Define a function with no roxygen2 documentation
  func_def <- c(
    "add <- function(x, y) {",
    "  return(x + y)",
    "}"
  )
  
  # Extract the roxygen2 documentation
  roxygen2_lines <- extract_roxygen2(func_def)
  
  # Check that the roxygen2 documentation is an empty string
  expect_equal(roxygen2_lines, "")
})
