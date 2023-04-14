
# OpenAIR

  <!-- badges: start -->
  [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
  [![R-CMD-check](https://github.com/umatter/OpenAIR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/umatter/OpenAIR/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->

Integrate OpenAI's GPT models into your R workflows.





## Installation

You can install the development version of OpenAIR from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("umatter/OpenAIR")
```

## Usage

To use the package, you'll need to have an OpenAI API key. You can sign up for an API key [here](https://platform.openai.com/signup/). Once you have your API key, you can start using *OpenAIR*:

``` r
# load the package
library("OpenAIR")

# register your api key
openai_api_key("YOUR-API-KEY")

```

Then, you can start chatting with the model. The simplest way of interacting with ChatGPT is the `chat()`-function. Using it is essentially the same as interacting with with ChatGPT via the web GUI (https://chat.openai.com/chat).

```r
# use chat() to interact with ChatGPT through the R console
chat("Write a 100 words essay on why OpenAIR, 
an R package to integrate GPT models into your R workflows is fantastic. 
Write it in the style of product launches moderated by Steve Jobs.")
```

```
Ladies and gentlemen, let me introduce you to OpenAIR, the latest and greatest addition to the R community. Thanks to OpenAIR, you can now integrate the cutting-edge GPT models right into your R workflows, unlocking a world of possibilities for predictive modeling and natural language processing. Whether you're an experienced data scientist or a newcomer to the field, OpenAIR makes it easier than ever to create powerful models that generate high-quality text. From business applications to academic research, OpenAIR has the power to transform the way we work with language data. So what are you waiting for? Join the excitement and embrace the future of data science with OpenAIR!
```

```r
chat("Now shorten the essay to 30 words.")
```

```
OpenAIR - unleash the full power of GPT models in R workflows.
```
 
`chat()` is primarily useful for interactive mode. For writing short scripts and developing functions based on OpenAIR, the infix function `%c%` provides an alternative syntax to send messages to the model and indicate what output format is required.

```r
# output to console
"Remove all numeric characters from '5XC-2a09ujnap9o2q0MP'" %c% 
"message_to_console"
```

```
The string without numeric characters would be 'XC-aujnapqMP'.
```

```r
# return the message as a string
resp <- 
"Remove all numeric characters from '5XC-2a09ujnap9o2q0MP'
In your response, only provide what remains from the string" %c%
"message" 

resp
```

```
[1] "XC-aujnapoqMP"
```

## Code of Conduct

For information about our code of conduct, please see the [Code of Conduct](CODE_OF_CONDUCT.md) page.