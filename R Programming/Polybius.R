encrypt <- function(input,M){
	cipher <- NULL
	# split per char
	pos <- strsplit(input,"")
	for (i in 1:nchar(input)){
		if (pos[[1]][i] == "J" || pos[[1]][i] == "I"){
			cipher <- paste(cipher,2,4)
		}
		for (j in 1:5){
			for (k in 1:5){
				if (pos[[1]][i] == M[j,k]){
					cipher <- paste(cipher,j,k)
				}
			}
		}
	}
	# retutn cipher without space
	return(gsub(" ","",cipher))
}

decrypt <- function(cipher,M){
	plain <- NULL
	# split per char
	pos <- strsplit(cipher,"")
	for (i in 1:nchar(cipher)){
		# lookin for i odd
		if (i%%2==1){
			row <- as.numeric(pos[[1]][i])
			col <- as.numeric(pos[[1]][i+1])
			if (M[row,col] == "I/J"){
				x <- paste("[",M[row,col],"]")
				plain <- paste(plain,x)
			}else {
				plain <- paste(plain,M[row,col])
			}
		}
	}
	# retutn plain without space
	return(gsub(" ","",plain))
}

polybius <- function() {
	# Inisialisasi table matrix polybius
	M <- matrix(c("A","B","C","D","E","F","G","H","I/J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"),nrow=5,ncol=5,byrow=TRUE)
	
	# Input Plaintext
	cat("INPUT: ")
	input <- readline()
	input <- toupper(gsub(" ","",input))
	
	# print table
	cat(sprintf("Polybius Table\n"))
	print(M)
	
	# Print Plaintext
	cat(sprintf("Plaintext> %s\n",input))
	
	# Enkrip & Print Ciphertext
	cat(sprintf("Encrypt now ...\n"))
	cipher <- encrypt(input,M)
	cat(sprintf("Ciphertext> %s\n",cipher))
	
	# Dekrip & Print Plaintext
	cat(sprintf("Decrypt now ...\n"))
	plain <- decrypt(cipher,M)
	cat(sprintf("Plaintext> %s\n",plain))
}

polybius()