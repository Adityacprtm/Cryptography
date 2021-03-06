library(jsonlite)
library(httr)
# retrieve the chain
req <- GET("http://127.0.0.1:8000/chain")
chain <- jsonlite::fromJSON(content(req, "text", encoding = "utf-8"))
# check the amount of the first transaction in the first block of the chain
cat(chain$chain$block.1$transactions$transaction$amount)