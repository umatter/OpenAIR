
 object <- function(response) {
   # Check if the response is a list
   if (!is.list(response)) {
     stop("Invalid response format. Expected list object.")
   }
   
   # Extract the object from the response
   object <-  response$object
   
   # Check if the object is a character string
   if (!is.character(object)) {
     stop("Invalid response format. object must be a character string.")
   }
   
   # Return the object
   return(object)
 }