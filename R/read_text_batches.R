#' Load data from text files in batches
#'
#' This function reads in data from text files in batches using
#' the read_lines_chunked function from the readr package.
#'
#' @param text character string, either containing a path to a text file to read
#' in or containing the text.
#' @param batch_size integer indicating the number of lines to read in per batch
#' (default is 3500)
#' @return a numeric value indicating the total number of tokens in the text
#' file
#' @author Ulrich Matter umatter@protonmail.com
#' @examples
#' \dontrun{
#' data_path <- system.file("text", "lorem.txt", package = "OpenAIR")
#' text_data <- read_text_batches(data_path)
#' }
#' @export
read_text_batches <- function(text, batch_size = 3500) {

  # dependencies
  requireNamespace("readr", quietly = TRUE)

  # Define callback function to compute number of tokens per batch
  text_batch <- function(lines, index) {
    if(file.exists(text)) {
      fn <- text
    } else {
      fn <- "character string"
    }
    # convert to tidy-text format
    text <-
      data.frame(text = lines,
             file = fn,
             line = seq_along(lines),
             batch_index = index)
    return(text)
  }

  # Read in the text file in batches and compute the number of tokens per batch
  all_batches <- readr::read_lines_chunked(text,
  callback = readr::ListCallback$new(text_batch), chunk_size = batch_size)

  # Return the total number of tokens
  return(all_batches)
}
