#' Set OpenAI API key as an environment variable
#'
#' This function sets the OpenAI API key as an environment variable in the current R session.
#' 
#' @param api_key character string containing the OpenAI API key.
#'
#' @return Nothing is returned; the function is called for its side effects.
#'
#' @examples
#' openai_api_key("your_api_key_here")
#'
#' @export
openai_api_key <- function(api_key) {
  Sys.setenv(OPENAI_API_KEY = api_key)
}
