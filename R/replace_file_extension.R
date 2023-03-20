#' Replace File Extension
#'
#' This function replaces the file extension of a given filename with a specified new extension.
#' It validates the input to ensure the filename and the new extension are single character strings.
#' Then, it replaces the old extension with the new one and returns the modified filename.
#'
#' @param filename The input filename as a character string.
#' @param new_extension The new file extension to replace the old one (including the dot, e.g., ".bib").
#' @return A character string representing the filename with the replaced file extension.
#' @author Ulrich Matter umatter@protonmail.com
#' @export
#' @examples
#' \dontrun{
#' # Replace the file extension of a text file with a BibTeX extension
#' new_filename <- replace_file_extension("example_document.txt", ".bib")
#' print(new_filename) # "example_document.bib"
#' }
replace_file_extension <- function(filename, new_extension) {
  # Validate input
  if (!is.character(filename) || length(filename) != 1) {
    stop("filename must be a single character string.")
  }
  
  if (!is.character(new_extension) || length(new_extension) != 1) {
    stop("new_extension must be a single character string.")
  }
  
  # Replace the file extension with the new_extension
  new_filename <- sub("\\.[^.]+$", new_extension, filename)
  
  return(new_filename)
}
