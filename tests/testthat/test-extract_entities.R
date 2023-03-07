if (!is.null(Sys.getenv("OPENAI_API_KEY"))) {
  test_that("Entity extraction works", {
    data("trump")
    extract_entities(trump)

  })
} else {
  skip("API key not set, skipping test.")
}
