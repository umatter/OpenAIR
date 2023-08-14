#' Convert Text to Tidy-Text Format
#'
#' This function takes a character string or a path to a text file as input and
#' converts it to tidy-text format. The resulting tibble contains one row for
#' each line of the input text, along with the file name, and line number.
#'
#' @param text A character string containing the text to be converted, or a
#' path to a text file.
#'
#' @return A tibble containing the converted text in tidy-text format,
#' with columns for the text,
#' file name, line number, and batch index (if applicable).
#'
#' @examples
#' read_text("Hello, how are you?")
#' read_text("path/to/text/file.txt")
#'
#' @importFrom R.utils isUrl
#'@export

read_text <- function(text) {

  # read text (either from file or string)
    if(text == "" || (!file.exists(text) & !R.utils::isUrl(text))) {
      fn <- "character string"
      # read the data, split into lines
      lines <- readr::read_lines(I(text))
    } else {
      fn <- text
      # read the data, split into lines
      lines <- readr::read_lines(text)
    }


  # convert to tidy-text format
  text_df <-
    tibble::tibble(text = lines,
                   file = fn,
                   line = seq_along(lines),
                   batch_index = 1)
  return(text_df)
}
