#' Check if the provided string is in valid JSON format.
#'
#' @param input_string A character string to be checked for JSON format.
#'
#' @return A logical value. If the input string is in valid JSON format, returns
#' TRUE, otherwise returns FALSE.
#'
#' @author Ulrich Matter umatter@protonmail.com
#'
#' @examples
#' is_json('{"name": "John", "age": 30}')
#' # TRUE
#'
#' is_json('{"name": "John", age: 30}')
#' # FALSE
#'
#' is_json('')
#' # FALSE
#' @export
is_json <- function(input_string) {

  if (!is.character(input_string)) {
    warning("Input is not a character string.")
    return(FALSE)
  }

  if (nchar(input_string) == 0) {
    message("Empty string provided.")
    return(FALSE)
  }

  tryCatch({
    jsonlite::fromJSON(input_string, simplifyVector = FALSE)
    return(TRUE)
  }, error = function(e) {
    return(FALSE)
  })
}