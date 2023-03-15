if (!nchar(Sys.getenv("OPENAI_API_KEY"))==0) {
  test_that("Entity extraction works", {

        extract_entities(trump)

  })
} else {
  skip("API key not set, skipping test.")
}
