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
  # Make sure input is character string
  if (!is.character(code) || nchar(code) == 0) {
    return(FALSE)
  } else {
    return(!inherits(try(eval(parse(text = code)), silent = TRUE), "try-error"))
  }
}
