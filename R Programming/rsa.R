# is it prime function
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

# gcd function to find value e
gcd <- function(a,b) {
    a <- as.numeric(a)
    b <- as.numeric(b)
    r <- a%%b;
    gcd <- ifelse(r, gcd(b, r), b)
    return(gcd)
}

# function to find value d
euclidean <- function(e,phi) {
    e <- as.numeric(e)
    phi <- as.numeric(phi)
    x <- NULL
    d <- NULL
    for (i in 1:phi) {
        x <- (e * i) %% phi
        if (x == 1){
            d <- paste(c(d,i))
        }
    }
    return(d)
}

# setup all need
setup <- function(p,q) {
    p <- as.numeric(p)
    q <- as.numeric(q)
    #is prime?
    if (!(isPrime(p) && isPrime(q))){
        stop("p and q must be prime")
    }else if (p == q) {
        stop("p and q cannot be equal")
    }
    # value n
    n <- p * q
    # totient
    phi <- (p-1) * (q-1)
    # temporary list of e
    temp_e <- 2:phi
    
    #print(temp_e)
    
    # find value e if result from gcd = 1
    g <- NULL
    e <- NULL
    for (i in 2:length(temp_e)) {
        g <- gcd(i,phi)
        if (g == 1) {
            e <- paste(c(e,i))
        }
    }

    #cat(sprintf("Available e numbers: %s\n",paste(e,collapse=" ")))
    e <- sample(e,1)
    #cat(sprintf("Your e number: %s\n",e))

    d <- euclidean(e, phi)
    #cat(sprintf("Available d numbers: %s\n",paste(d,collapse=" ")))
    d <- sample(d,1)
    #cat(sprintf("Your d number: %s\n",d))

    my_list <- list("public"=c(e,n),"private"=c(d,n))
    return(my_list)
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
    cat("RSA Encrypt / Decrypt\n")
    cat("Enter a prime number: ")
    p <- readline()
    cat("Enter another prime number: ")
    q <- readline()
    key <- setup(p,q)
    cat("Generating your public/private keypairs now . . .\n")
    cat(sprintf("Your public key is (%s,%s) and your private key is (%s,%s)\n", key$public[1], key$public[2], key$private[1], key$private[2]))
    cat("Enter a number to encrypt: ")
    input <- c(readline())
    cipher <- encrypt(key$public,input)
    cat(sprintf("Your encrypted message is: %s\n",cipher))
    plain <- decrypt(key$private,cipher)
    cat(sprintf("Your decrypted message is: %s\n",plain))
}

#github.com/Adityacprtm
main()