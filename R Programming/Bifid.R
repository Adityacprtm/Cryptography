# Author -> github.com/adityacprtm
get_cipher <- function(input, M){
	cipher <- NULL
	pos <- strsplit(input,"")
	for (i in 1:nchar(input)){
		# lookin for i odd
		if (i%%2==1){
			row <- as.numeric(pos[[1]][i])
			col <- as.numeric(pos[[1]][i+1])
			if (M[row,col] == "Y/Z"){
				x <- paste("[",M[row,col],"]")
				cipher <- paste(cipher,x)
			} else {
				cipher <- paste(cipher,M[row,col])
			}
		}
	}
	return(gsub(" ","",cipher))
}

encrypt <- function(input,M){
	temp_cipher <- NULL
	row <- NULL
	col <- NULL
	pos <- strsplit(input,"")
	for (i in 1:(nchar(input))){
		if (pos[[1]][i] == "Y" || pos[[1]][i] == "Z"){
			row <- paste(row,5)
			col <- paste(col,5)
		}
		for (j in 1:5){
			for (k in 1:5){
				if (pos[[1]][i] == M[j,k]){
					row <- paste(row,j)
					col <- paste(col,k)
				} 
			}
		}
	}
	temp_cipher <- gsub(" ","",paste(row,col))
	cat(sprintf("Row> %s\nCol> %s\nRow-Col> %s\n",row,col,temp_cipher))

	#get index from bifid table
	cipher <- get_cipher(temp_cipher,M)
	return(cipher)
}

bifid <- function() {
	# Inisialisasi table matrix polybius
	M <- matrix(c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y/Z"),nrow=5,ncol=5,byrow=TRUE)
	
	# Input Plaintext
	cat("INPUT: ")
	input <- readline()
	input <- toupper(gsub(" ","",input))
	
	# print table
	cat(sprintf("Bifid Table\n"))
	print(M)
	
	# Print Plaintext
	cat(sprintf("Plaintext> %s\n",input))
	
	# Encrypt & Print Ciphertext
	cat(sprintf("Encrypt now ...\n"))
	cipher <- encrypt(input,M)
	cat(sprintf("Ciphertext> %s\n",cipher))
}

bifid()