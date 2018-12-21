# Seriously need this package
list.of.packages <- c("binhf","R.utils")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

require(binhf)
require(R.utils)

# Matrix for convert decimal, binary, hexa
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
            10, "1010", "A",
            11, "1011", "B",
            12, "1100", "C",
            13, "1101", "D",
            14, "1110", "E",
            15, "1111", "F"
), ncol=3, byrow=TRUE)

# Initial Permutation Table DES
PI = c(58, 50, 42, 34, 26, 18, 10, 2, 
    60, 52, 44, 36, 28, 20, 12, 4, 
    62, 54, 46, 38, 30, 22, 14, 6, 
    64, 56, 48, 40, 32, 24, 16, 8, 
    57, 49, 41, 33, 25, 17, 9, 1, 
    59, 51, 43, 35, 27, 19, 11, 3, 
    61, 53, 45, 37, 29, 21, 13, 5, 
    63, 55, 47, 39, 31, 23, 15, 7)

# D-BOX for Expansion
D_Box = c(32, 1, 2, 3, 4, 5,
        4, 5, 6, 7, 8, 9,
        8, 9, 10, 11, 12, 13,
        12, 13, 14, 15, 16, 17,
        16, 17, 18, 19, 20, 21,
        20, 21, 22, 23, 24, 25,
        24, 25, 26, 27, 28, 29,
        28, 29, 30, 31, 32, 1)

# Inisiasi PC for KEY SCHEDULING
PC1_C = c(57, 49, 41, 33, 25, 17, 9,
        1, 58, 50, 42, 34, 26, 18,
        10, 2, 59, 51, 43, 35, 27,
        19, 11, 3, 60, 52, 44, 36)
PC1_D = c(63, 55, 47, 39, 31, 23, 15,
        7, 62, 54, 46, 38, 30, 22,
        14, 6, 61, 53, 45, 37, 29,
        21, 13, 5, 28, 20, 12, 4)
PC2 = c(14, 17, 11, 24, 1, 5, 3, 28,
        15, 6, 21, 10, 23, 19, 12, 4,
        26, 8, 16, 7, 27, 20, 13, 2,
        41, 52, 31, 37, 47, 55, 30, 40,
        51, 45, 33, 48, 44, 49, 39, 56,
        34, 53, 46, 42, 50, 36, 29, 32)

# S_Box for substitution
S_Box = list(
            matrix(c(14, 4, 13, 1, 2, 15, 11, 8, 3, 10, 6, 12, 5, 9, 0, 7,
            0, 15, 7, 4, 14, 2, 13, 1, 10, 6, 12, 11, 9, 5, 3, 8,
            4, 1, 14, 8, 13, 6, 2, 11, 15, 12, 9, 7, 3, 10, 5, 0,
            15, 12, 8, 2, 4, 9, 1, 7, 5, 11, 3, 14, 10, 0, 6, 13), ncol=16, byrow=TRUE),
            
            matrix(c(15, 1, 8, 14, 6, 11, 3, 4, 9, 7, 2, 13, 12, 0, 5, 10,
            3, 13, 4, 7, 15, 2, 8, 14, 12, 0, 1, 10, 6, 9, 11, 5,
            0, 14, 7, 11, 10, 4, 13, 1, 5, 8, 12, 6, 9, 3, 2, 15,
            13, 8, 10, 1, 3, 15, 4, 2, 11, 6, 7, 12, 0, 5, 14, 9), ncol=16, byrow=TRUE),
            
            matrix(c(10, 0, 9, 14, 6, 3, 15, 5, 1, 13, 12, 7, 11, 4, 2, 8,
            13, 7, 0, 9, 3, 4, 6, 10, 2, 8, 5, 14, 12, 11, 15, 1,
            13, 6, 4, 9, 8, 15, 3, 0, 11, 1, 2, 12, 5, 10, 14, 7,
            1, 10, 13, 0, 6, 9, 8, 7, 4, 15, 14, 3, 11, 5, 2, 12), ncol=16, byrow=TRUE),

            matrix(c(7, 13, 14, 3, 0, 6, 9, 10, 1, 2, 8, 5, 11, 12, 4, 15,
            13, 8, 11, 5, 6, 15, 0, 3, 4, 7, 2, 12, 1, 10, 14, 9,
            10, 6, 9, 0, 12, 11, 7, 13, 15, 1, 3, 14, 5, 2, 8, 4,
            3, 15, 0, 6, 10, 1, 13, 8, 9, 4, 5, 11, 12, 7, 2, 14), ncol=16, byrow=TRUE),

            matrix(c(2, 12, 4, 1, 7, 10, 11, 6, 8, 5, 3, 15, 13, 0, 14, 9,
            14, 11, 2, 12, 4, 7, 13, 1, 5, 0, 15, 10, 3, 9, 8, 6,
            4, 2, 1, 11, 10, 13, 7, 8, 15, 9, 12, 5, 6, 3, 0, 14,
            11, 8, 12, 7, 1, 14, 2, 13, 6, 15, 0, 9, 10, 4, 5, 3), ncol=16, byrow=TRUE), 

            matrix(c(12, 1, 10, 15, 9, 2, 6, 8, 0, 13, 3, 4, 14, 7, 5, 11,
            10, 15, 4, 2, 7, 12, 9, 5, 6, 1, 13, 14, 0, 11, 3, 8,
            9, 14, 15, 5, 2, 8, 12, 3, 7, 0, 4, 10, 1, 13, 11, 6,
            4, 3, 2, 12, 9, 5, 15, 10, 11, 14, 1, 7, 6, 0, 8, 13), ncol=16, byrow=TRUE), 

            matrix(c(4, 11, 2, 14, 15, 0, 8, 13, 3, 12, 9, 7, 5, 10, 6, 1,
            13, 0, 11, 7, 4, 9, 1, 10, 14, 3, 5, 12, 2, 15, 8, 6,
            1, 4, 11, 13, 12, 3, 7, 14, 10, 15, 6, 8, 0, 5, 9, 2,
            6, 11, 13, 8, 1, 4, 10, 7, 9, 5, 0, 15, 14, 2, 3, 12), ncol=16, byrow=TRUE),
            
            matrix(c(13, 2, 8, 4, 6, 15, 11, 1, 10, 9, 3, 14, 5, 0, 12, 7,
            1, 15, 13, 8, 10, 3, 7, 4, 12, 5, 6, 11, 0, 14, 9, 2,
            7, 11, 4, 1, 9, 12, 14, 2, 0, 6, 10, 13, 15, 3, 5, 8,
            2, 1, 14, 7, 4, 10, 8, 13, 15, 12, 9, 0, 3, 5, 6, 11), ncol=16, byrow=TRUE)
            
            )
# give name row and column S-Box
dimnames(S_Box[[1]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))
dimnames(S_Box[[2]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))
dimnames(S_Box[[3]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))
dimnames(S_Box[[4]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))
dimnames(S_Box[[5]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))
dimnames(S_Box[[6]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))
dimnames(S_Box[[7]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))
dimnames(S_Box[[8]]) = list(c(0,1,2,3),c(0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15))

PI_1 = c(40, 8, 48, 16, 56, 24, 64, 32,
        39, 7, 47, 15, 55, 23, 63, 31,
        38, 6, 46, 14, 54, 22, 62, 30,
        37, 5, 45, 13, 53, 21, 61, 29,
        36, 4, 44, 12, 52, 20, 60, 28,
        35, 3, 43, 11, 51, 19, 59, 27,
        34, 2, 42, 10, 50, 18, 58, 26,
        33, 1, 41, 9, 49, 17, 57, 25)

permutation <- function(plaintext) {
    output = NULL
    for (i in 1:length(PI)) {
       output = paste(c(output,plaintext[PI[i]]))
    }
    return(output)
}

divide_block <- function(permutation) {
    L = NULL
    R = NULL
    for (i in 1:length(permutation)) {
        if (i > 32) {
            R = paste(c(R,permutation[i]))
        } else {
            L = paste(c(L,permutation[i]))
        }
    }
    my_list = list("L" = L,"R" = R)
    return(my_list)
}

expansion <- function(block32) {
    E = NULL

    for (i in 1:length(D_Box)) {
        E = as.numeric(paste(c(E,block32[D_Box[i]])))
    }

    # output 48
    return(E)
}

# Mapping into grup
chunk.2 <- function(x, n, force.number.of.groups = TRUE, len = length(x), groups = trunc(len/n), overflow = len%%n) { 
    if(force.number.of.groups) {
        f1 <- as.character(sort(rep(1:n, groups)))
        f <- as.character(c(f1, rep(n, overflow)))
    } else {
        f1 <- as.character(sort(rep(1:groups, n)))
        f <- as.character(c(f1, rep("overflow", overflow)))
    }
    g <- split(x, f)
    if(force.number.of.groups) {
        g.names <- names(g)
        g.names.ordered <- as.character(sort(as.numeric(g.names)))
    } else {
        g.names <- names(g[-length(g)])
        g.names.ordered <- as.character(sort(as.numeric(g.names)))
        g.names.ordered <- c(g.names.ordered, "overflow")
    }
    return(g[g.names.ordered])
}

# Convert binary to dec
BinToDec <- function(x) {
    sum(2^(which(rev(unlist(strsplit(as.character(x), "")) == 1))-1))
}

hexToBin <- function(x) {
    for (i in 1:16) {
        if (x == HEX_Bin[i,1]) {
            return(HEX_Bin[i,2])
        }
    }
}

binToHex <- function(x) {
    for (i in 1:16) {
        if (x == HEX_Bin[i,2]) {
            return(HEX_Bin[i,3])
        }
    }
}

substitution <- function(block48) {
    output_subs <- vector("list",8)
    temp = NULL
    bit6 = chunk.2(block48,8,force.number.of.groups=TRUE)
    for (i in 1:8) {
        row = BinToDec(as.numeric(paste(c(bit6[[i]][1],bit6[[i]][6]))))
        col = BinToDec(as.numeric(paste(c(bit6[[i]][2],bit6[[i]][3],bit6[[i]][4],bit6[[i]][5]))))

        for (j in 1:4) {
            for (k in 1:16) {
                if (row == as.numeric(rownames(S_Box[[i]])[j]) && col == as.numeric(colnames(S_Box[[i]])[k])) {
                    bin = hexToBin(as.numeric(S_Box[[i]][j,k]))
                    temp = paste(c(temp,bin))
                }
            }
        }
        output_subs[[i]] = temp
    }
    return(output_subs[[8]])
}

DES_Round <- function(permutation, key_scheduling) {
    L = NULL
    R = NULL
    E = NULL
    S_box = vector("list", 16)
    block = divide_block(permutation)
    tempL = block$L
    tempR = block$R
    for (i in 1:16) {
        #cat("  Round ",i,"\n")
        key = key_scheduling[[i]]
        L[[i]] = as.numeric(tempR)
        E = expansion(tempR)
        xor1 = bitwXor(E,key)
        S_box[[i]] = strsplit(paste(substitution(xor1), collapse= ""), split="")
        xor2 = bitwXor(as.numeric(unlist(S_box[[i]])),as.numeric(tempL))
        R[[i]] = xor2
        tempL = L[[i]]
        tempR = R[[i]]
        #print(tempL)
        #print(tempR)
    }
    output = paste(c(tempL,tempR))
    return(output)
}

final_permut <- function(des_round) {
    output = NULL
    for (i in 1:length(PI_1)) {
       output = paste(c(output,des_round[PI_1[i]]))
    }
    return(output)
}

# ==============KEY SCHEDULING=================#
shifting <- function(v, num){
    output = shift(v,num,dir="left")
    return(output)
}

key_scheduling <- function(input_key) {
    # Inisiasi
    C = NULL
    D = NULL
    output_key <- vector("list", 16)
    
    # Permutation table PC-1 for C and D
    for (i in 1:28) {
        C = paste(c(C,input_key[PC1_C[i]]))
        D = paste(c(D,input_key[PC1_D[i]]))
    }

    # Shifting
    Ctemp = C
    Dtemp = D
    for (i in 1:16) {
        if (i == 1 || i == 2 || i == 9 || i == 16) {
            Ci = shifting(Ctemp,1)
            Ctemp = Ci
            Di = shifting(Dtemp,1)
            Dtemp = Di
        } else {
            Ci = shifting(Ctemp,2)
            Ctemp = Ci
            Di = shifting(Dtemp,2)
            Dtemp = Di
        }
        merged = paste(c(Ci,Di))

        temp_key = NULL
        for (j in 1:length(PC2)) {
            temp_key = paste(c(temp_key,merged[PC2[j]]))
        }
        output_key[[i]] = as.numeric(temp_key)
    }

    #key_list = list("1"=output_key[[1]],"2"=output_key[[2]],"3"=output_key[[3]],"4"=output_key[[4]],"5"=output_key[[5]],"6"=output_key[[6]],"7"=output_key[[7]],"8"=output_key[[8]],"9"=output_key[[9]],"10"=output_key[[10]],"11"=output_key[[11]],"12"=output_key[[12]],"13"=output_key[[13]],"14"=output_key[[14]],"15"=output_key[[15]],"16"=output_key[[16]])
    key_list = list(output_key[[1]],output_key[[2]],output_key[[3]],output_key[[4]],output_key[[5]],output_key[[6]],output_key[[7]],output_key[[8]],output_key[[9]],output_key[[10]],output_key[[11]],output_key[[12]],output_key[[13]],output_key[[14]],output_key[[15]],output_key[[16]])
    return(key_list)
}
# =============================================#

decryption <- function(ciphertext, key) {
    permutation = permutation(ciphertext)

    temp_key = NULL
    new_key = NULL
    for (i in 1:16) {
        temp_key[[i]] = key[[i]]
    }
    new_key[[1]] = temp_key[[16]]
    new_key[[2]] = temp_key[[15]]
    new_key[[3]] = temp_key[[14]]
    new_key[[4]] = temp_key[[13]]
    new_key[[5]] = temp_key[[12]]
    new_key[[6]] = temp_key[[11]]
    new_key[[7]] = temp_key[[10]]
    new_key[[8]] = temp_key[[9]]
    new_key[[9]] = temp_key[[8]]
    new_key[[10]] = temp_key[[7]]
    new_key[[11]] = temp_key[[6]]
    new_key[[12]] = temp_key[[5]]
    new_key[[13]] = temp_key[[4]]
    new_key[[14]] = temp_key[[3]]
    new_key[[15]] = temp_key[[2]]
    new_key[[16]] = temp_key[[1]]

    DES_Round = DES_Round(permutation, new_key)

    final_permut = final_permut(DES_Round)

    cat("\nDecrypt\nPlaintext : \n",paste(final_permut,collapse=" "),"\n")
}

main <- function() {
    plaintext = c(sample(0:1,64,replace=T))
    input_key = c(sample(0:1,64,replace=T))
    cat("Plaintext : \n",plaintext, "\n")
    cat("Key 64 bit : \n",input_key, "\n")
    
    cat("Starting Initial Permutation ...\n")
    permutation = permutation(plaintext)

    cat("Getting Key 48 bit (Key Scheduling) ...\n")
    key_scheduling = key_scheduling(input_key)
    
    cat("Starting Feistel Network ...\n")
    DES_Round = DES_Round(permutation, key_scheduling)

    cat("Starting Final Permutation ...\n")
    ciphertext = final_permut(DES_Round)

    cat("This your ciphertext : \n")
    cat("Binary : \n", as.numeric(ciphertext),"\n")

    bit4 = chunk.2(ciphertext,16,force.number.of.groups=TRUE)
    hex=NULL
    for (i in 1:16) {
        hex[[i]] = binToHex(paste(bit4[[i]],collapse=""))
        if (i == 16) {
            cat("Hexadecimal : \n", hex , "\n")
        }
    }

    decryption(ciphertext, key_scheduling)
}

#github.com/adityacprtm
main()