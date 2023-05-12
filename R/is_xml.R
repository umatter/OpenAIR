#' Check if the provided string is in valid XML format.
#'
#' @param input_string A character string to be checked for XML format.
#'
#' @return A logical value. If the input string is in valid XML format, returns
#' TRUE, otherwise returns FALSE.
#'
#' @author Ulrich Matter umatter@protonmail.com
#'
#' @examples
#' is_xml('<?xml version="1.0"?><root><element>value</element></root>')
#' # TRUE
#'
#' is_xml('<root><element>value</element></root>')
#' # FALSE
#'
#' is_xml('')
#' # FALSE
#' @export
is_xml <- function(input_string) {

  if (!is.character(input_string)) {
    warning("Input is not a character string.")
    return(FALSE)
  }

  if (nchar(input_string) == 0) {
    message("Empty string provided.")
    return(FALSE)
  }

  tryCatch({
    xml2::read_xml(input_string)
    return(TRUE)
  }, error = function(e) {
    return(FALSE)
  })
}
