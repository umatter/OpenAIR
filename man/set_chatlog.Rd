% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/set_chatlog.R
\name{set_chatlog}
\alias{set_chatlog}
\title{Set up a new chatlog}
\usage{
set_chatlog(
  initial_role = "system",
  initial_content = "You are a helpful assistant.",
  chatlog_id = NULL
)
}
\arguments{
\item{initial_role}{A character string representing the role issueing the
initial content (per default: "system")}

\item{initial_content}{A character string representing the initial message
from the system}

\item{chatlog_id}{A character string representing the ID of this
conversation. Per default, this will be set automatically.}
}
\value{
A new chatlog object
}
\description{
This function sets up a new chatlog object for a conversation.
}
\examples{
chat <- set_chatlog("Welcome to our chat!")
is_chatlog(chat)
chat
}
