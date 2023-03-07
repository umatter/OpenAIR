#' Add data to a chat log
#'
#' This function adds data to the in-memory chat log, which is in the global environment. The data
#' can be any R object, such as a vector, list, or data frame. 
#'
#' @param msgs a chatlog object
#' @param chatlog_id The id of the chatlog object
#'
#' @return The resulting environment with the added data.
#'
#'
add_to_chatlog <- function(msgs, chatlog_id) {
  
  # update the chatlog
  current <- get(chatlog_id, envir = .ChatEnv)
  current_msgs@messages <- dplyr::bind_rows(current@messages,
                                            msgs)
  assign(chatlog_id, current_msgs, envir = .ChatEnv)
  
}
