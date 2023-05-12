#' Add data to a chat log
#'
#' This function adds data to the in-memory chat log, which is in the global
#' environment. The data can be any R object, such as a vector, list, or data
#' frame. The function supports adding data to the chat log by providing either
#' a data.frame or a chatlog object.
#'
#' @param msgs A chatlog object or a data.frame containing the messages to be
#' added to the chat log.
#' @param chatlog_id The id of the chatlog object. Required when the provided
#' msgs is a data.frame.
#'
#' @return The updated chatlog object with the newly added messages.
#' @author Ulrich Matter umatter@protonmail.com
#' @examples
#' \dontrun{
#' # Add a data frame of messages to an existing chat log
#' chatlog_df <- data.frame(
#' user = c("user1", "user2"),
#' message = c("Hello!", "Hi!")
#' )
#' updated_chatlog <- add_to_chatlog(chatlog_df, "existing_chatlog_id")
#'
#' # Add messages from one chat log to another
#' chatlog1 <- create_chatlog("chatlog1")
#' chatlog2 <- create_chatlog("chatlog2")
#' chatlog1 <- add_message(chatlog1, "user1", "Hello!")
#' chatlog2 <- add_message(chatlog2, "user2", "Hi!")
#' merged_chatlog <- add_to_chatlog(chatlog1, chatlog2@chatlog_id)
#' }
#' @export
add_to_chatlog <- function(msgs, chatlog_id = NULL) {

  if (is.data.frame(msgs) & !is.null(chatlog_id)) {

    # make sure latest state of log is used
    current <- get_chatlog(chatlog_id)
    # update the chatlog
    current@messages <- dplyr::bind_rows(current@messages,
                                              msgs)
    assign(chatlog_id, current, envir = OpenAIR_env)

    return(current)
  }

  if (is_chatlog(msgs)){

    # make sure latest state of log is used
    current <- get_chatlog(msgs@chatlog_id)
    # update the chatlog
    current@messages <- dplyr::bind_rows(current@messages,
                                              msgs@messages)
    assign(chatlog_id, current, envir = OpenAIR_env)

    return(current)

  }
}
