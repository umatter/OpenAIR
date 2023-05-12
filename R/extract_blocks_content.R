#' Extract the content parts of blocks
#'
#' This function takes a list of blocks and returns a list of their content
#' parts.
#'
#' @param block_list A list of blocks to extract the content from
#' @return A list of content parts
#' @export
extract_blocks_content <- function(block_list) {
  # Extract the content parts
  contents <- lapply(block_list, function(x) {
    x$content
  })
  # Remove the NULL elements
  contents <- contents[!sapply(contents, is.null)]
  # Return the blocks
  return(contents)
}