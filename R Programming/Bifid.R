bifid <- function() {
	cat("input msg: ")
	str <- readline()
	alpha <- c("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y/Z")
	M <- matrix(alpha,nrow=5,ncol=5,byrow=TRUE)
	print(M)
	upper_str <- toupper(gsub(" ","",str))
	num_str <- nchar(upper_str)
	cat(sprintf("Plaintext> %s \n",gsub(" ","",str)))
	row <- " "
	col <- " "
	for (i in 1:num_str){
		pos <- substr(upper_str,i,i)
		if (pos == "Y" || pos == "Z"){
			row <- paste(row,5)
			col <- paste(col,5)
		}
		for (j in 1:5){
			for (k in 1:5){
				if (pos == M[j,k]){
					row <- paste(row,j)
					col <- paste(col,k)
				} 
			}
		}
	}
	row <- gsub(" ","",row)
	col <- gsub(" ","",col)
	cat(sprintf("Row> %s\nCol> %s\n",row,col))
	x <- gsub(" ","",paste(row,col))
	num_row_col <- nchar(x)
	pos <- strsplit(x,"")
	m <- matrix(unlist(pos),nrow=1)
	print(m)
	cipher <- ""
	for (i in 1:num_row_col){
		cipher <- paste(M[as.numeric(m[1,i]),as.numeric(m[1,i])])
		print(cipher)
	}
	cat(sprintf("Cipher> %s\n",x))
}
bifid()