# Author -> github.com/Adityacprtm

isPrime <- function(num) {
    num <- as.numeric(num)
    if (num == 2) {
        return(TRUE)
    } else if (any(num %% 2:(num-1) == 0)) {
        return(FALSE)
    } else {
        return(TRUE)
    }
}

gcd <- function(a,b) {
    a <- as.numeric(a)
    b <- as.numeric(b)
    r <- a%%b;
    return(ifelse(r, gcd(b, r), b))
}

euclidean <- function(e,phi) {
    e <- as.numeric(e)
    phi <- as.numeric(phi)
    for (i in 1:100) {
        x <- (e * i) %% phi
        if (x == 1){
            break
        }
    }
    return(i)
}

setup <- function(p,q) {
    p <- as.numeric(p)
    q <- as.numeric(q)
    if (!(isPrime(p) && isPrime(q))){
        stop("nilai p dan q harus prima")
    }else if (p == q) {
        stop("nilai p dan q tidak boleh sama")
    }

    n <- p * q

    phi <- (p-1) * (q-1)

    e <- sample(2:phi,1,replace=FALSE)

    g <- gcd(e,phi)
    while (g != 1){
        e <- sample(2:phi,1,replace=FALSE)
        g <- gcd(e,phi)
    }
    
    d = euclidean(e, phi)

    my_list <- list("public"=c(e,n),"private"=c(d,n))
    return (my_list)
}

encrypt <- function(pk, plaintext) {
    e <- as.numeric(pk[1])
    n <- as.numeric(pk[2])
    ciphertext <- NULL
    #plaintext <- as.numeric(utf8ToInt(plaintext))
    for (i in 1:length(plaintext)) {
        C <- (as.numeric(plaintext[i])^e)%%n
        ciphertext <- paste(ciphertext,C)
    }
    return(ciphertext)
}

decrypt <- function(pk, ciphertext) {
    d <- as.numeric(pk[1])
    n <- as.numeric(pk[2])
    plaintext <- NULL
    for (i in 1:length(ciphertext)) {
        M <- (as.numeric(ciphertext[i])^d)%%n
        plaintext <- paste(plaintext,M)
    }
    return(plaintext)
}

main <- function() {
    print("RSA Encrypt / Decrypt")
    cat("Input Prime: ")
    p <- readline()
    cat("Another Prime: ")
    q <- readline()
    key <- setup(p,q)
    print("Generating your public/private keypairs now . . .")
    cat(sprintf("Your public key is (%s,%s) and your private key is (%s,%s)\n", key$public[1], key$public[2], key$private[1], key$private[2]))
    cat("Enter a message to encrypt: ")
    input <- readline()
    cipher <- encrypt(key$public,input)
    cat(sprintf("Your encrypted message is:%s\n",cipher))
    plain <- decrypt(key$private,cipher)
    cat(sprintf("Your decrypted message is:%s\n",plain))
}

main()