library(jsonlite)
library(httr)

# to register a node
req <- POST("http://127.0.0.1:8000/nodes/register", 
            body = '{"nodes": "http://127.0.0.1:8000"}')
cat(jsonlite::fromJSON(content(req, "text", encoding = "utf-8")),"\n")

# create a new transaction
req <- POST("http://127.0.0.1:8000/transactions/new", 
            body = '{"sender": "d4ee26eee15148ee92c6cd394edd964", 
            "recipient": "23448ee92cd4ee26eee6cd394edd964", "amount": 1}')
object <- jsonlite::fromJSON(content(req, "text", encoding = "utf-8"));
cat(object$message,"\n")

# create a new transaction
req <- POST("http://127.0.0.1:8000/transactions/new", 
            body = '{"sender": "6eee15148ee92c6cd394edd974d4ee2", 
            "recipient": "15148ee92cd4ee26eee6cd394edd964", "amount": 2}')
object <- jsonlite::fromJSON(content(req, "text", encoding = "utf-8"));
cat(object$message,"\n")

# start mining
req <- GET("http://127.0.0.1:8000/mine")
object <- jsonlite::fromJSON(content(req, "text", encoding = "utf-8"));
cat(object$message,"\n")

# create a new transaction
req <- POST("http://127.0.0.1:8000/transactions/new", 
            body = '{"sender": "334e15148ee92c6cd394edd974d4ee2", 
            "recipient": "8ee98ee92cd4ee26eee6cd3334e1514", "amount": 11}')
object <- jsonlite::fromJSON(content(req, "text", encoding = "utf-8"));
cat(object$message,"\n")

# mine again
req <- GET("http://127.0.0.1:8000/mine")
object <- jsonlite::fromJSON(content(req, "text", encoding = "utf-8"));
cat(object$message,"\n")