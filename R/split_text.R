#' Split Text into Chunks
#'
#' This function splits a text string into a vector of strings with a
#'  specified number of tokens each.
#'
#' @param text A character vector containing the text to be split.
#' @param N An integer specifying the number of tokens per chunk.
#'
#' @return A character vector containing the chunks of text with N tokens each.
#' @export
#' @import stringr
#'
#' @examples
#' large_text <- "This is an example of a large text string
#' that will be split into chunks of N tokens each by our custom R function."
#' num_tokens_per_chunk <- 5
#' split_text(large_text, num_tokens_per_chunk)
split_text <- function(text, N) {
  # Check if the input N is a positive integer
  if (!is.numeric(N) || N <= 0 || round(N) != N) {
    stop("Error: N must be a positive integer.")
  }

  # Tokenize the input text using stringr package
  tokens <- stringr::str_split(text, "\\s+")[[1]]

  # Count the number of tokens
  num_tokens <- length(tokens)

  # Calculate the number of chunks
  num_chunks <- ceiling(num_tokens / N)

  # Initialize an empty vector to store the chunks
  chunks <- vector("list", num_chunks)

  # Iterate through the tokens and split them into chunks
  for (i in seq_along(chunks)) {
    start_index <- (i - 1) * N + 1
    end_index <- min(i * N, num_tokens)
    chunk_tokens <- tokens[start_index:end_index]
    chunks[[i]] <- stringr::str_c(chunk_tokens, collapse = " ")
  }

  # Return the vector of chunks
  return(chunks)
}
