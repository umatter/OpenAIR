#' Parse a Response From the API
#'
#' This function takes an input string containing both text and code blocks,
#' and returns a list of blocks with their respective type, content, and
#' language (if applicable).
#' Each block is either of type 'text' or 'code'.
#'
#' @param input_string The response from the API
#' @return A list of blocks with type, content, and language (for code blocks)
#' @author Jonathan Chassot
#'
#' @examples
#' \dontrun{
#' parse_response("Hello world!")
#' # [[1]]
#' # [[1]]$type
#' # [1] "text"
#' #
#' # [[1]]$content
#' # [1] "Hello world!"
#' #
#' parse_response("```python\nprint('Hello world!')\n```")
#' # [[1]]
#' # [[1]]$type
#' # [1] "code"
#' #
#' # [[1]]$content
#' # [1] "print('Hello world!')"
#' #
#' # [[1]]$language
#' # [1] "python"
#' #
#' parse_response("Hello world!\n\n```python\nprint('Hello world!')\n```")
#' # [[1]]
#' # [[1]]$type
#' # [1] "text"
#' #
#' # [[1]]$content
#' # [1] "Hello world!"
#' #
#' # [[2]]
#' # [[2]]$type
#' # [1] "code"
#' #
#' # [[2]]$content
#' # [1] "print('Hello world!')"
#' #
#' # [[2]]$language
#' # [1] "python"
#' #
#' }
#' @export
parse_response <- function(input_string) {

  # Extract content between "```" using regex
  regex_pattern <- "`{3}([\\s\\S]*?)`{3}"
  res <- gregexpr(regex_pattern, input_string, perl = TRUE)[[1]]

  # If no matches, return the input string
  if (res[1] == -1) {
    return(list(list(type = "text", content = input_string)))
  }

  # start_text is the start for text blocks, start_code is the start for code
  # end_text is the end for text blocks, end_code is the end for code
  start_code <- as.numeric(res)
  end_code <- start_code + attr(res, "match.length") - 1
  start_text <- end_code + 1
  end_text <- start_code - 1
  # Correct for first and last blocks
  if (start_code[1] != 1) {
    start_text <- c(1, start_text)
  } else {
    end_text <- end_text[-1]
  }
  if (end_code[length(end_code)] != nchar(input_string)) {
    end_text <- c(end_text, nchar(input_string))
  } else {
    start_text <- start_text[-length(start_text)]
  }

  if (0 < length(start_text) && 0 < length(end_text)) {
    text_blocks <- substring(input_string, start_text, end_text)
    text_list <- mapply(function(block, start) {
      list(type = "text", content = block, start = start)
    }, text_blocks, start_text, SIMPLIFY = FALSE)

  } else {
    # no text in response
    text_list <- NULL
  }

  if (0 < length(start_code) && 0 < length(end_code)) {
    code_blocks <- substring(input_string, start_code, end_code)
    code_list <- mapply(function(block, start) {
      # Remove the ticks
      block <- gsub("^```|```$", "", block)
      # Extract the language
      res <- regexpr("\\n", block, perl = TRUE)[[1]][1]
      if (res == -1) {
        lang <- ""
      } else {
        lang <- tolower(trimws(substr(block, 1, res)))
        block <- substr(block, res + 1, nchar(block))
      }
      lang <- ifelse(lang == "", "plaintext", lang)
      list(type = "code", content = block, start = start, language = lang)
    }, code_blocks, start_code, SIMPLIFY = FALSE)
  } else {
    code_list <- NULL
  }

  # Create output list
  full_list <- c(text_list, code_list)
  names(full_list) <- NULL

  full_list <- lapply(
    full_list[order(sapply(full_list, function(x) x$start))],
    function(x) {
      x$start <- NULL
      x
    }
  )

  # Return code blocks
  return(full_list)
}
