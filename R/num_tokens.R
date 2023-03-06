#' Get number of tokens in a string using OpenAI's tiktoken library
#'
#' This function uses the num_tokens_from_string function provided in OpenAI's
#' tiktoken python library to get the number of tokens in a string.
#'
#' @param text a character string to count the number of tokens from
#' @param encoding a character string that specifies how text is converted into tokens. The default is "cl100k_base" (for ChatGPT models; see https://github.com/openai/openai-cookbook/blob/main/examples/How_to_count_tokens_with_tiktoken.ipynb for details)
#' @return an integer indicating the number of tokens in the input string
#' @references https://github.com/openai/openai-cookbook/blob/main/examples/How_to_count_tokens_with_tiktoken.ipynb
#'
#' @import reticulate
#' @export
num_tokens <- function(text, encoding = "cl100k_base") {
  # Load necessary dependencies
  if (!requireNamespace("reticulate", quietly = TRUE)) {
    stop("reticulate package not installed.")
  }
  
  # Load python dependency
  # Note: this will install the dependency (and Miniconda, if no suitable python installation could be found)
  # Using this function for the first time thus takes a while to process.
  tiktoken <- import("tiktoken")
  
  # Fetch encoding
  encoding <- tiktoken$get_encoding(encoding)
  
  # Count no. of encoded tokens
  num_tokens <- length(encoding$encode(text))
  
  # Return the number of tokens
  return(num_tokens)
}
