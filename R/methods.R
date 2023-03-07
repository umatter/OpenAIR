#'@import methods

# function definition
print.chatlog <- function(x) {
  cat("Chatlog ID: ", x@chatlog_id, "\n")
  print(x@messages)
}

# Register the method
setMethod(f = "print", 
          signature = "chatlog", 
          definition = print.chatlog)

