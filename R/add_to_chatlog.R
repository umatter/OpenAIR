#' Add data to a chat log
#'
#' This function adds data to the in-memory chat log, which is in the global environment. The data
#' can be any R object, such as a vector, list, or data frame. 
#'
#' @param msgs a chatlog object or a data.frame
#' @param chatlog_id The id of the chatlog object
#'
#' @return The current chatlog
#'
#'
add_to_chatlog <- function(msgs, chatlog_id=NULL) {
  
  if (is.data.frame(msgs) & !is.null(chatlog_id)){
    
    # make sure latest state of log is used
    current <- get_chatlog(chatlog_id)
    # update the chatlog
    current@messages <- dplyr::bind_rows(current@messages,
                                              msgs)
    assign(chatlog_id, current, envir = .GlobalEnv)
    
    return(current)
    
  }
  
  if (is_chatlog(msgs)){
    
    # make sure latest state of log is used
    current <- get_chatlog(msgs@chatlog_id)
    # update the chatlog
    current@messages <- dplyr::bind_rows(current@messages,
                                              msgs@messages)
    assign(chatlog_id, current, envir = .GlobalEnv)
    
    return(current)
    
  }
  

  
}
