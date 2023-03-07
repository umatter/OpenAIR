#' chatlog class
#'
#' @slot messages The message data of the object
#' @slot chatlog_id The chatlog's ID 
#' @export
setClass("chatlog", slots = list(messages = "data.frame",
                                 chatlog_id = "character"))
