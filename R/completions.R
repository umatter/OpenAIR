#' Generate text using the OpenAI API
#'
#' This function generates natural language text given a prompt using the OpenAI API. It wraps the \code{completions} endpoint of the OpenAI API.
#'
#' @param prompt A character string containing the prompt to generate text from.
#' @param model A character string specifying the ID of the model to use. Default is "text-davinci-003". See list_models() for an overview of available models.
#' @param temperature An optional numeric scalar specifying the sampling temperature to use. The default value is 0.5.
#' @param max_tokens An optional integer scalar specifying the maximum number of tokens to generate in the text. The default value is 2048.
#' @param n An optional integer scalar specifying the number of text completions to generate. The default value is 1.
#' @param stop An optional character string or character vector specifying one or more stop sequences to use when generating the text. 
#' @param echo An optional logical scalar specifying whether to include the prompt in the generated text. The default value is \code{FALSE}.
#' @param suffix An optional character string specifying a suffix to add to the generated text.
#' @param top_p An optional numeric scalar specifying the cumulative probability of the top tokens to use in the generated text. The default value is NULL.
#' @param stream An optional logical scalar specifying whether to generate text continuously. The default value is \code{FALSE}.
#' @param logprobs An optional integer scalar specifying the number of log probabilities to return for each token in the generated text. The default value is NULL.
#' @param presence_penalty An optional numeric scalar specifying the presence penalty to use when generating the text. The default value is NULL.
#' @param frequency_penalty An optional numeric scalar specifying the frequency penalty to use when generating the text. The default value is NULL.
#' @param best_of An optional integer scalar specifying the number of completions to generate and return the best one. The default value is NULL.
#' @param logit_bias An optional named numeric vector specifying the logit bias to use for each token in the generated text.
#' @param user A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse. 
#'
#' @return A character vector containing the generated text(s).
#' @author Ulrich Matter umatter@protonmail.com
#' 
#' @examples
#' \dontrun{
#' openai_api_key("your_api_key_here")
#' completions("Once upon a time,", n = 3)
#' }
#' 
#' @export
completions <- function(prompt, model = "text-davinci-003", temperature = 0.5, max_tokens = 2048, n = 1, stop = "\n", echo = FALSE,
                          suffix = NULL, top_p = NULL, stream = FALSE, logprobs = NULL, presence_penalty = NULL,
                          frequency_penalty = NULL, best_of = NULL, logit_bias = NULL, user = NULL) {
  # the relevant API endpoint
  API_ENDPOINT <- "https://api.openai.com/v1/completions"
  
  # Fetch api_key from environment variable
  api_key <- Sys.getenv("OPENAI_API_KEY")

  # Check that API key is provided
  if (is.null(api_key)) {
    stop("API key is missing. Provide it as the 'api_key' argument or set it as the environment variable 'OPENAI_API_KEY'.")
  }
  
  # Construct API request payload
  payload <- list(
    prompt = prompt,
    max_tokens = max_tokens,
    n = n,
    stream = stream,
    stop = stop,
    echo = echo
  )

  if (!is.null(model)) {
    payload$model <- model
  }
  if (!is.null(temperature)) {
    payload$temperature <- temperature
  }
  if (!is.null(suffix)) {
    payload$suffix <- suffix
  }
  if (!is.null(top_p)) {
    payload$top_p <- top_p
  }
  if (!is.null(logprobs)) {
    payload$logprobs <- logprobs
  }
  if (!is.null(presence_penalty)) {
    payload$presence_penalty <- presence_penalty
  }
  if (!is.null(frequency_penalty)) {
    payload$frequency_penalty <- frequency_penalty
  }
  if (!is.null(best_of)) {
    payload$best_of <- best_of
  }
  
  # Make API request
  response <- tryCatch({
    httr::POST(
      url = API_ENDPOINT,
      httr::add_headers(`Authorization` = paste0("Bearer ", api_key)),
      httr::content_type_json(),
      body = jsonlite::toJSON(payload, auto_unbox = TRUE)
    )
  }, error = function(e) {
    message("Error: ", e$message)
    NULL
  })
  
  # Check for successful response,
  # Parse, and return content to user
  if (!is.null(response)) {
    if (httr::http_status(response)$category == "Success") {
      result <- jsonlite::fromJSON(httr::content(response, "text"), simplifyVector = TRUE)
      return(result)
    } else {
      message("HTTP error ", httr::http_status(response)$status_code, ": ", httr::http_status(response)$reason)
    }
  }

}

