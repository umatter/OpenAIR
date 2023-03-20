#' Generate Text Using the OpenAI API's Chat Endpoint
#'
#' This function generates natural language text in a conversational style using the OpenAI API's chat endpoint.
#' It takes a series of chat messages as input, either as a data.frame or a chatlog object, and generates a text
#' completion based on the conversation history and the specified model parameters.
#'
#' @param msgs A data.frame containing the chat history to generate text from or a chatlog object.
#' @param model A character string specifying the ID of the model to use.
#' The default value is "gpt-3.5-turbo".
#' @param temperature An optional numeric scalar specifying the sampling temperature to use.
#' @param max_tokens An optional integer scalar specifying the maximum number of tokens to generate in the text.
#' @param n An optional integer scalar specifying the number of text completions to generate.
#' @param stop An optional character string or character vector specifying one or more stop sequences to use when generating the text.
#' @param presence_penalty An optional numeric scalar specifying the presence penalty to use when generating the text. The default value is NULL.
#' @param frequency_penalty An optional numeric scalar specifying the frequency penalty to use when generating the text. The default value is NULL.
#' @param best_of An optional integer scalar specifying the number of completions to generate and return the best one. The default value is NULL.
#' @param logit_bias An optional named numeric vector specifying the logit bias to use for each token in the generated text.
#' @param stream An optional logical scalar specifying whether to use the streaming API. The default value is \code{FALSE}.
#' @param top_p An optional numeric scalar specifying the top p sampling ratio. The default value is NULL.
#' @param user A unique identifier representing your end-user, which can help OpenAI to monitor and detect abuse.
#'
#' @return A character vector containing the generated text(s).
#' @author Ulrich Matter umatter@protonmail.com
#' @seealso \url{https://beta.openai.com/docs/} for more information on the OpenAI API.
#' @examples
#' \dontrun{
#' openai_api_key("your_api_key_here")
#' msgs_df <- data.frame(role=c("system",
#' "user",
#' "assistant",
#' "user"),
#' content=c("You are a helpful assistant",
#' "Who won the world series in 2020?",
#' "The Los Angeles Dodgers won the World Series in 2020.",
#' "Where was it played?"))
#' chat_completion(msgs_df)
#' }
#' @export
chat_completion <- function(msgs, model = "gpt-3.5-turbo", temperature = NULL, max_tokens = NULL, n = NULL, stop = NULL,
                          presence_penalty = NULL, frequency_penalty = NULL, best_of = NULL, logit_bias = NULL,
                          stream = FALSE, top_p = NULL, user = NULL) {
  # the relevant API endpoint
  API_ENDPOINT <- "https://api.openai.com/v1/chat/completions"
  
  # Fetch api_key from environment variable
  api_key <- Sys.getenv("OPENAI_API_KEY")
  
  # Check that API key is provided
  if (is.null(api_key)) {
    stop("API key is missing. Provide it as the 'api_key' argument or set it as the environment variable 'OPENAI_API_KEY'.")
  }
  
  # Check if part of a chat session
  if (is_chatlog(msgs)){
    chatlog_id <- msgs@chatlog_id
    msgs <- msgs@messages
  } else {
    chatlog_id <- "No chat session id"
  }
  
  # Construct API request payload
  payload <- list(
    model = model,
    messages = msgs
  )
  
  if (!is.null(max_tokens)) {
    payload$max_tokens <- max_tokens
  }
  if (!is.null(n)) {
    payload$n <- n
  }
  if (!is.null(stop)) {
    payload$stop <- stop
  }
  if (!is.null(temperature)) {
    payload$temperature <- temperature
  }
  if (!is.null(top_p)) {
    payload$top_p <- top_p
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
  if (!is.null(user)) {
    payload$user <- user
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
      
      # parse response
      result <- jsonlite::fromJSON(httr::content(response,
                                                 "text",
                                                 encoding = "UTF-8"),
                                   simplifyVector = TRUE)
      
      return(result)
      
    } else {
      message("HTTP error ", httr::http_status(response)$status_code, ": ", httr::http_status(response)$reason)
    }
  }
  
}


    
    