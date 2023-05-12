#' Convert a data.frame to a CSV-formatted character string
#'
#' The `df_to_csv` function takes a data.frame as input and returns a character
#' string representing the content of the original data.frame formatted as a CSV
#' file.
#' The resulting CSV-formatted string can be written to a file or further
#' processed
#' as needed.
#'
#' @param df A data.frame to be converted to a CSV-formatted character string.
#' @return A character string representing the data values in the input
#' data.frame
#'   formatted as a CSV file.
#' @export
#' @examples
#' # Create a data.frame
#' example_data <- data.frame(
#'   Name = c("Alice", "Bob", "Carol"),
#'   Age = c(30, 25, 28),
#'   Height = c(168, 175, 162),
#'   stringsAsFactors = FALSE
#' )
#'
#' # Convert the data.frame to a CSV-formatted character string
#' csv_string <- df_to_csv(example_data)
#' cat(csv_string)
df_to_csv <- function(df) {

  requireNamespace("utils", quietly = TRUE)

  if (!is.data.frame(df)){
    stop("df must be an object of class data.frame")
  }
  # Convert the data.frame to a CSV-formatted character string using write.csv
  output <- tempfile(fileext = ".csv")
  utils::write.csv(df, file = output, row.names = FALSE)

  # Read the CSV file content and store it in a character string
  csv_string <- paste(readLines(output), collapse = "\n")

  # Remove the temporary file
  file.remove(output)

  return(csv_string)
}
