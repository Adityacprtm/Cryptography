polybius <- function() {
	cat("input msg: ")
	str <- readline()
	alpha <- c("A","B","C","D","E","F","G","H","I/J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
	M = matrix(alpha,nrow=5,ncol=5,byrow=TRUE)
	print(M)
	upper_str = toupper(gsub(" ","",str))
	num_str = nchar(upper_str)
	cat(sprintf("Plaintext> %s \nCipher> ",gsub(" ","",str)))
	cipher <- " "
	for (i in 1:num_str){
		pos = substr(upper_str,i,i)
		if (pos == "J" || pos == "I"){
			cipher <- paste(cipher,2,4)
		}
		for (j in 1:5){
			for (k in 1:5){
				if (pos == M[j,k]){
					cipher <- paste(cipher,j,k)
				} 
			}
		}
	}
	cat(sprintf("%s\n",gsub(" ","",cipher)))
}
polybius()