#' Check if a character string contains valid R code
#'
#' This function takes a character string as input and attempts to parse it as R code using the
#' `parse` function. If the parsing is successful, the function returns TRUE, indicating that
#' the input string contains valid R code. If parsing fails, the function returns FALSE.
#'
#' @param code A character string containing the R code to be checked.
#'
#' @return A logical value indicating whether the input code string contains valid R code or not.
#'
#' @examples
#' # Valid R code
#' valid_code <- "x <- 5; y <- 10; z <- x + y"
#' is_r(valid_code)
#'
#' # Invalid R code
#' invalid_code <- "x <- 5 + 'a'"
#' is_r(invalid_code)
#'
#' @export
is_r <- function(code) {
  # Attempt to parse the code
  sink(file = "/dev/null")
  parsed_code <- try(eval(parse(text = code)), silent = TRUE)
  sink()
  
  # Check if parsing was successful
  if (inherits(parsed_code, "try-error") | nchar(code)==0 | !is.character(code)) {
    return(FALSE)
  } else {
    return(TRUE)
  }
}
