#' Check if a Character String Contains Valid Python Code
#'
#' This function takes a character string as input and checks if it contains
#' valid Python code. It returns TRUE if the string contains valid Python code,
#' and FALSE otherwise.
#'
#' @param code A character string containing code to be checked for Python code
#' validity.
#'
#' @return A logical value: TRUE if the input character string contains valid
#' Python code, and FALSE otherwise.
#' @details This function presuposes that python is installed on the system.
#' @examples
#' \dontrun{
#' # Check if the string contains valid Python code
#' is_python("print('Hello, World!')")
#'
#' # Check if the string contains invalid Python code
#' is_python("prit('Hello, World!')")
#'}
#' @export
#'
is_python <- function(code) {
  # Write the input code to a temporary file
  temp_file <- tempfile(fileext = ".py")
  writeLines(code, temp_file)

  # Redirect the output to a temporary file
  temp_stdout <- tempfile()
  temp_stderr <- tempfile()

  # Attempt to run the code with "python"
  exit_code_python <- tryCatch({
    suppressWarnings(system2("python", temp_file, stdout = temp_stdout,
      stderr = temp_stderr))
  }, error = function(e) {
    NA
  })

  # Attempt to run the code with "python3"
  exit_code_python3 <- tryCatch({
    suppressWarnings(system2("python3", temp_file, stdout = temp_stdout,
      stderr = temp_stderr))
  }, error = function(e) {
    NA
  })

  # Remove the temporary files
  file.remove(temp_file, temp_stdout, temp_stderr)

  # If either of the exit codes is 0, the Python code is valid; else, it is not
  return(any(exit_code_python == 0, exit_code_python3 == 0))
}
