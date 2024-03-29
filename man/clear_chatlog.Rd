% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clear_chatlog.R
\name{clear_chatlog}
\alias{clear_chatlog}
\title{Clear a chat log}
\usage{
clear_chatlog(chatlog_id = ".__CURRENTCHAT__")
}
\arguments{
\item{chatlog_id}{character string indicating the name of the chat log to
clear.
                  Default is ".__CURRENTCHAT__".}
}
\value{
This function does not return anything.
}
\description{
This function clears a chat log, leaving only the initial (system) message.
}
\examples{
\dontrun{
# Clear the current chat log
clear_chatlog()
}
}
\author{
Ulrich Matter umatter@protonmail.com
}
