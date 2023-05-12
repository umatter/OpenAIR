#' Set OpenAI API Key as an Environment Variable
#'
#' This function sets the OpenAI API key as an environment variable in the
#' current R session. It takes the API key as an input and stores it as an
#' environment variable, allowing other functions to access the key when needed.
#'
#' @param api_key A character string containing the OpenAI API key.
#' @return Nothing is returned; the function is called for its side effects.
#' @author Ulrich Matter umatter@protonmail.com
#' @seealso \url{https://platform.openai.com/docs/} for more information
#' on the OpenAI API.
#' @examples
#' \dontrun{
#' # Set the OpenAI API key for the current R session
#' openai_api_key("your_api_key_here")
#' }
#' @export
openai_api_key <- function(api_key) {
  Sys.setenv(OPENAI_API_KEY = api_key)
}
