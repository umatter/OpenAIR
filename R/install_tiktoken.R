#' Install the tiktoken Python package
#'
#' This function installs the tiktoken Python package using the specified
#' installation method and Conda environment (if any).
#'
#' @param method The installation method to use. Can be one of "auto" (default),
#' "conda", "virtualenv", "pip", or "windows".
#' @param conda The name or path of the Conda environment to use for the
#' installation, or "auto" (default) to let reticulate automatically manage the
#' environment.
#'
#' @importFrom reticulate py_install
install_tiktoken <- function(method = "auto", conda = "auto") {
  reticulate::py_install("tiktoken", method = method, conda = conda)
}
