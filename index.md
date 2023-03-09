
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

To use the package, you'll need to have an OpenAI API key. You can sign up for an API key [here](https://beta.openai.com/signup/). Once you have your API key, you can start using *OpenAIR*:

``` r
# load the package
library("OpenAIR")

# register your api key
openai_api_key("YOUR-API-KEY"")

```

Then, you can start chatting with the model:

``` r

chat("Write a 100 words essay on why OpenAIR, 
an R package to integrate GPT models into your R workflows is fantastic. 
Write it as if the late Steve Jobs would have written it.")

```
