
#' Clear a chat log
#'
#' This function clears a chat log, leaving only the initial (system) message.
#'
#' @param chatlog_id character string indicating the name of the chat log to clear.
#'                   Default is ".__CURRENTCHAT__".
#' @return This function does not return anything.
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#' @examples
#' \dontrun{
#' # Clear the current chat log
#' clear_chatlog()
#' }
clear_chatlog <- function(chatlog_id = ".__CURRENTCHAT__") {
  # get the current chatlog
  current <- get_chatlog(chatlog_id)
  # remove all but the initial (system) message
  current@messages <- current@messages[1,]
  assign(chatlog_id, current, envir = .GlobalEnv)
}
