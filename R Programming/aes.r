# Seriously need this package
list.of.packages <- c("binhf","R.utils")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

require(binhf)
require(R.utils)

HEX_Bin = matrix(c(
            0, "0000", "0",
            1, "0001", "1",
            2, "0010", "2",
            3, "0011", "3",
            4, "0100", "4",
            5, "0101", "5",
            6, "0110", "6",
            7, "0111", "7",
            8, "1000", "8",
            9, "1001", "9",
            10, "1010", "a",
            11, "1011", "b",
            12, "1100", "c",
            13, "1101", "d",
            14, "1110", "e",
            15, "1111", "f"
), ncol=3, byrow=TRUE)

table_mixColumns = matrix(c(
    "0010",  "0011",  '0001',  '0001',
    '0001',  '0010',  '0011',  '0001',
    '0001',  '0001',  '0010',  '0011',
    '0011',  '0001',  '0001',  '0010'
),nrow=4, ncol=4, byrow=TRUE)

ForwardS_Box = matrix(c(
    "63", 	'7c', 	'77', 	'7b', 	'f2', 	'6b', 	'6f', 	'c5', 	'30', 	'01', 	'67', 	'2b', 	'fe', 	'd7', 	'ab', 	'76',
    "ca", 	'82', 	'c9', 	'7d', 	'fa', 	'59', 	'47', 	'f0', 	'ad', 	'd4', 	'a2', 	'af', 	'9c', 	'a4', 	'72', 	'c0',
    "b7", 	'fd', 	'93', 	'26', 	'36', 	'3f', 	'f7', 	'cc', 	'34', 	'a5', 	'e5', 	'f1', 	'71', 	'd8', 	'31', 	'15',
    "04", 	'c7', 	'23', 	'c3', 	'18', 	'96', 	'05', 	'9a', 	'07', 	'12', 	'80', 	'e2', 	'eb', 	'27', 	'b2', 	'75',
    "09", 	'83', 	'2c', 	'1a', 	'1b', 	'6e', 	'5a', 	'a0', 	'52', 	'3b', 	'd6', 	'b3', 	'29', 	'e3', 	'2f', 	'84',
    "53", 	'd1', 	'00', 	'ed', 	'20', 	'fc', 	'b1', 	'5b', 	'6a', 	'cb', 	'be', 	'39', 	'4a', 	'4c', 	'58', 	'cf',
    "d0", 	'ef', 	'aa', 	'fb', 	'43', 	'4d', 	'33', 	'85', 	'45', 	'f9', 	'02', 	'7f', 	'50', 	'3c', 	'9f', 	'a8',
    "51", 	'a3', 	'40', 	'8f', 	'92', 	'9d', 	'38', 	'f5', 	'bc', 	'b6', 	'da', 	'21', 	'10', 	'ff', 	'f3', 	'd2',
    'cd', 	'0c', 	'13', 	'ec', 	'5f', 	'97', 	'44', 	'17', 	'c4', 	'a7', 	'7e', 	'3d', 	'64', 	'5d', 	'19', 	'73',
    '60', 	'81', 	'4f', 	'dc', 	'22', 	'2a', 	'90', 	'88', 	'46', 	'ee', 	'b8', 	'14', 	'de', 	'5e', 	'0b', 	'db',
    'e0', 	'32', 	'3a', 	'0a', 	'49', 	'06', 	'24', 	'5c', 	'c2', 	'd3', 	'ac', 	'62', 	'91', 	'95', 	'e4', 	'79',
    'e7', 	'c8', 	'37', 	'6d', 	'8d', 	'd5', 	'4e', 	'a9', 	'6c', 	'56', 	'f4', 	'ea', 	'65', 	'7a', 	'ae', 	'08',
    'ba', 	'78', 	'25', 	'2e', 	'1c', 	'a6', 	'b4', 	'c6', 	'e8', 	'dd', 	'74', 	'1f', 	'4b', 	'bd', 	'8b', 	'8a',
    '70', 	'3e', 	'b5', 	'66', 	'48', 	'03', 	'f6', 	'0e', 	'61', 	'35', 	'57', 	'b9', 	'86', 	'c1', 	'1d', 	'9e',
    'e1', 	'f8', 	'98', 	'11', 	'69', 	'd9', 	'8e', 	'94', 	'9b', 	'1e', 	'87', 	'e9', 	'ce', 	'55', 	'28', 	'df',
    '8c', 	'a1', 	'89', 	'0d', 	'bf', 	'e6', 	'42', 	'68', 	'41', 	'99', 	'2d', 	'0f', 	'b0', 	'54', 	'bb', 	'16'
),nrow=16,ncol=16)

rownames(ForwardS_Box) <- c('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f')
colnames(ForwardS_Box) <- c('0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f')

binToHex <- function(x) {
    for (i in 1:16) {
        if (x == HEX_Bin[i,2]) {
            return(HEX_Bin[i,3])
        }
    }
}

hexToBin <- function(x) {
    for (i in 1:16) {
        if (x == HEX_Bin[i,3]) {
            return(HEX_Bin[i,2])
        }
    }
}

keyExpansion <- function(){

}

addRoundKey <- function(plaintext, key){
    addRoundKey <- bitwXor(plaintext, key)
    #cat("Add Round Key : \n",addRoundKey, "\n")
    matriksAddRoundKey <- NULL
    output_matriksAddRoundKey <- NULL
    tmp <- NULL
    for(i in 1:length(addRoundKey)){
        tmp <- paste(c(tmp,addRoundKey[i]))
        if(length(tmp)==4){
            tmp <- paste(tmp, collapse="")
            tmp <- binToHex(tmp)
            matriksAddRoundKey <- paste(c(matriksAddRoundKey, tmp))
            tmp <- NULL
        }
    }

    return(matriksAddRoundKey)
}

finalAddroundKey <- function(plaintext, key){
    bin_addRoundKey <- bitwXor(plaintext, key)
    return(bin_addRoundKey)
}


subBytes <- function(matriksAddRoundKey){
    x <- NULL
    y <- NULL 
    count <- 0 
    tmp <- NULL
    output_subBytes <- NULL
    for(i in 1:length(matriksAddRoundKey)){
        if((i%%2)==1){
            x <- matriksAddRoundKey[i]
        }else{
            y <- matriksAddRoundKey[i]
        }
        count = count + 1
        if(count==2){
            tmp <- ForwardS_Box[x, y]
            output_subBytes <- paste(c(output_subBytes, tmp))
            count <- 0
        }
    }
    #cat("Rounds Matriks Sub Bytes : \n",output_subBytes, "\n")
    matriks_subBytes <- matrix(output_subBytes, nrow=4, byrow=FALSE)

    return(matriks_subBytes)
}

shiftRows <- function(matriks_subBytes){
    matriks_subBytes[2,] =  shift(matriks_subBytes[2,], 1,"left")
    matriks_subBytes[3,] =  shift(matriks_subBytes[3,], 2,"left")
    matriks_subBytes[4,] =  shift(matriks_subBytes[4,], 3,"left")
    return(matriks_subBytes)
}

binShiftRows <- function(matriks_shiftRows){
    vector_matriks_shiftRows <- as.vector(matriks_shiftRows)
    bin_vector_matriks_shiftRows <- NULL
    tmp <- NULL
    x <- NULL
    for(i in 1:length(vector_matriks_shiftRows)){
        x <- strsplit(vector_matriks_shiftRows[i],"")
        for(j in 1:2){
            tmp <- paste(tmp, hexToBin(x[[1]][j]))
        }
        tmp <- gsub(" ","",tmp)
        bin_vector_matriks_shiftRows <- paste(c(bin_vector_matriks_shiftRows, tmp))
        tmp<- NULL
    }
    matriks_bin_vector_matriks_shiftRows <- matrix(bin_vector_matriks_shiftRows, nrow=4, byrow=FALSE)
    #print(matriks_bin_vector_matriks_shiftRows)
    return(matriks_bin_vector_matriks_shiftRows) 
}

mixColumns <- function(matriks_bin_vector_matriks_shiftRows, table_mixColumns){
    #print(table_mixColumns)
    x <- as.numeric(unlist(strsplit(matriks_bin_vector_matriks_shiftRows[1,2],"")))
    y <- as.numeric(unlist(strsplit(table_mixColumns[1,3],"")))
    z <- NULL
    xor <- NULL
    output <- NULL
    for(i in 1:4){
        
        for(j in 1:4){
            x <- as.numeric(unlist(strsplit(matriks_bin_vector_matriks_shiftRows[j,i],""))) 
            y <- as.numeric(unlist(strsplit(table_mixColumns[i,j],"")))
            z <- x*y
            if(j==1){
                xor <- z
            }
            else{
                xor <- bitwXor(xor, z)
            }
            output <- append(output, xor)
        }
    }
    
    return(output)

}

main <- function(){
    plaintext = c(sample(0:1,128,replace=T))
    input_key = c(sample(0:1,128,replace=T))
    cat("Plaintext : \n",plaintext, "\n")
    cat("Getting Key 128 bit ...\n")
    cat("Key 128 bit : \n",input_key, "\n")
    cat("Starting Initial Round ...\n")
    addRoundKey <- addRoundKey(plaintext,input_key)
    #cat("Intial Round Matriks Add Round Key : \n",addRoundKey, "\n")
    
    subBytes <- NULL
    shiftRows <- NULL
    matrikShiftRow <- NULL
    mixColumns <- NULL

    cat("Starting Rounds (9 Rounds) ...\n")
    for(i in 1:9){
        subBytes <- subBytes(addRoundKey)
        #print(initialSubBytes)
        shiftRows <- shiftRows(subBytes)
        #cat("Rounds Matriks Shift Rows : \n")
        #print(initialShiftRows)
        matrikShiftRow <- binShiftRows(shiftRows)
        mixColumns <- mixColumns(matrikShiftRow,table_mixColumns)
        addRoundKey <- addRoundKey(mixColumns, input_key)
        #cat("round ",i," : \n",addRoundKey, "\n")        
    }

    cat("Starting Final Round ...\n")
    subBytes <- subBytes(addRoundKey)
    shiftRows <- shiftRows(subBytes)
    bin_ciphertext <- finalAddroundKey(mixColumns, input_key)
    hex_ciphertext <- addRoundKey(mixColumns, input_key)
    cat("Binary Ciphertext : \n",bin_ciphertext, "\n")
    cat("Hexadecimal Ciphertext : \n",hex_ciphertext, "\n")

    
}

main()