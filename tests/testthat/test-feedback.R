r_code <-
"
for(i in 1:100) { 
    if(i %% 3 == 0 && i %% 5 == 0) { 
        print('FizzBuzz') 
    } else if(i %% 3 == 0) { 
        print('Fizz') 
    } else if(i %% 5 == 0) { 
        print('Buzz') 
    } else { 
        print(i) 
    } 
}"

if (!nchar(Sys.getenv("OPENAI_API_KEY")) == 0) {
    test_that("Feedback works", {
        feedback(r_code, "Solve the FizzBuzz problem")
    })
} else {
    skip("API key not set, skipping test.")
}
