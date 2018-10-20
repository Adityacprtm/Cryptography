caesar <- function(text, direction = "left", distance = 3, reverse = FALSE) {
  if (!is.character(text)) {
    stop("text must be a string!")
  }

  if (!is.numeric(distance)) {
    stop("distance must be a number!")
  }

  if (!distance %in% -46:46) {
    stop("distance must be between -46 and 46")
  }

  direction <- tolower(direction)
  if (!direction %in% c("left", "right")) {
    stop("direction must be 'left' or 'right'")
  }

  alphabet <- data.frame(original = letters, stringsAsFactors = FALSE)
  
  # JUST ALPHABET
  alphabet <- rbind(alphabet)

  # WITH CHAR AND NUMBER
  #special <- data.frame(original = c(0:9, " ", "!", ",", "@", "&", "%", "-", "_", ":", ";", "?", "'"))
  #alphabet <- rbind(alphabet, special)

  alphabet$cipher <- binhf::shift(alphabet$original, places = distance, dir = direction)
  alphabet <- rbind(alphabet, data.frame(original = c("#", "\n"), cipher = c("#", "\n")))

  if (!reverse) {
    text <- tolower(text)
    text <- gsub("[^[:alnum:][:space:]',!@&%-_:;]", "", text)
    text <- gsub("\\.", "", text)
    text <- gsub(" +", " ", text)

    for (i in 1:nchar(text)) {
      index_num <- which(substr(text, i, i) == alphabet$original)
      substr(text, i, i) <- alphabet$cipher[index_num]
    }
  } else {
    text <- gsub(" +", " ", text)
    for (i in 1:nchar(text)) {
      index_num <- which(substr(text, i, i) == alphabet$cipher)
      substr(text, i, i) <- alphabet$original[index_num]
    }
  }

  text <- gsub("\\\n", "\n#", text)
  text <- gsub("#+", "#", text)
  print(text)
}

cat("Input Message: ")
text <- readline()
cat("Input Key: ")
key <- readline()
caesar(text, direction = "left", distance = as.numeric(key), reverse = FALSE)