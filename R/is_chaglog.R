
#' Determine if an object is a chatlog
#'
#' This function checks if an object is of class "chatlog".
#'
#' @param object An R object to check
#' @return TRUE if the object is of class "chatlog", FALSE otherwise
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#' @examples
#' is_chatlog("Hello, World!")
#' # [1] FALSE
#' 
#' chat <- new("chatlog")
#' is_chatlog(chat)
#' # [1] TRUE
is_chatlog <- function(object) {
  return(class(object)[1] == "chatlog")
}
