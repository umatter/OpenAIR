#' Extract blocks of a specified type from a list of blocks
#'
#' @param block_list A list of blocks
#' @param block_type The type of blocks to be extracted
#'
#' @return A list of blocks of the specified type
#'
#' @author Jonathan Chassot
#'
#' @examples
#' extract_blocks(list(
#'      list(type = "text", content = "Hello world!"),
#'      list(type = "code", content = "print('Hello world!')")), "code")
#' # [[1]]
#' # $type
#' # [1] "code"
#' #
#' # $content
#' # [1] "print('Hello world!')"
#' #
#' @export
extract_blocks <- function(block_list, block_type) {
    # Extract the blocks of the specified type
    blocks <- lapply(block_list, function(x) {
        if (x$type == block_type) {
        x
        } else {
        NULL
        }
    })
    # Remove the NULL elements
    blocks <- blocks[!sapply(blocks, is.null)]
    # Return the blocks
    return(blocks)
}
