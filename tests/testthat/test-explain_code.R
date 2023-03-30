if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Feedback works", {
        explain_code("for(i in 1:10) { print(i) }")
    })
} else {
    skip("API key not set, skipping test.")
}
