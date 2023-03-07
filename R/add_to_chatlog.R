#' Add data to a chat log
#'
#' This function adds data to the in-memory chat log, which is in the global environment. The data
#' can be any R object, such as a vector, list, or data frame. 
#'
#' @param msgs The messages entry (1x2 data.frame with columns role and content)
#' @param chatlog_id The idof the log.
#'
#' @return The resulting environment with the added data.
#'
#'
add_to_chatlog <- function(msgs, chatlog_id) {
  
  # add id explicitly
  msgs$chatlog_id <- chatlog_id
  
  # update the chatlog
  updated_msgs <- dplyr::bind_rows(get(chatlog_id, envir = .ChatEnv),
                                      msgs)
  assign(chatlog_id, updated_msgs, envir = .ChatEnv)
  
}
