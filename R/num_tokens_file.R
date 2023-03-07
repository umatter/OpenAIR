#' Compute total number of tokens in a text file
#'
#' The function batch-wise computes the total number of tokens in a text file. 
#' The function returns a numeric value indicating the total
#' number of tokens in the file. The function can be used on very large text files.
#'
#' @param filename character string indicating the name of the text file to read in
#' @param batch_size integer indicating the number of lines to read in per batch (default is 1000)
#' @param encoding character string indicating the encoding to use (default is "cl100k_base")
#' @return a numeric value indicating the total number of tokens in the text file
#' @examples
#' data_path <- system.file("text", "lorem.txt", package = "OpenAIR")
#' text_data <- num_tokens_file(data_path)
#'
#' @export
num_tokens_file <- function(filename, batch_size = 1000, encoding = "cl100k_base") {

  # dependencies
  requireNamespace("readr", quietly = TRUE)
  
  # Define callback function to compute number of tokens per batch
  tokens_batch <- function(lines, index) {
    # Concatenate the lines into a single text string
    text <- paste0(lines, collapse = " ")
    # Compute the number of tokens in the text string
    nt <- num_tokens(text, encoding = encoding)
    return(nt)
  }
  
  # Read in the text file in batches and compute the number of tokens per batch
  all_token_counts <- readr::read_lines_chunked(filename, 
                                          callback = readr::ListCallback$new(tokens_batch),
                                          chunk_size = batch_size)
  
  # Compute the total number of tokens in the text file
  total_tokens <- sum(unlist(all_token_counts))
  
  # Return the total number of tokens
  return(total_tokens)
}
