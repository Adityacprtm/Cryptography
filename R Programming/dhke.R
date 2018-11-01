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

# setup contain initiation, validation and Calculated 
setup <- function(p,g,x) {
    p <- as.numeric(p)
    g <- as.numeric(g)
    x <- as.numeric(x)
    # is prime?
    if (!(isPrime(p))){
        stop("p must be prime")
    }
    # g must be smaller than p
    if (g > p) {
        stop("g must be smaller than p")
    }
    # x must be int and > 0
    if (x < 0) {
        stop("Secret key (X) must be integers greater than 0")
    }
    # Calculated with formula
    y <- (g^x) %% p
    return(y)
}

main <- function() {
    # enter number as P and G
    cat("Enter a prime number as p: ")
    p <- readline()
    cat("Enter a number as g: ")
    g <- readline()
    cat(sprintf("Alice and Bob agree to use modulus p = %s and g = %s\n\n",p,g))
    # enter secret key Alice and Bob
    cat("Alice Scret Key: ")
    xa <- readline()
    cat("Bob Secret Key: ")
    xb <- readline()
    cat("\n")
    # Publicly Shared
    cat("Publicly Shared Variables:\n")
    ya <- setup(p,g,xa)
    cat(sprintf("   Alice Sends to Bob Over Public Chanel: %s\n",ya))
    yb <- setup(p,g,xb)
    cat(sprintf("   Bob Sends to Alice Over Public Chanel: %s\n",yb))
    cat("\n----------------------------------\n\n")
    # Shared Key
    cat("Privately Calculated Shared Secret:\n")
    aliceSharedKey <- setup(p,yb,xa)
    bobSharedKey <- setup(p,ya,xb)
    cat(sprintf("   Alice Shared Key: %s\n",aliceSharedKey))
    cat(sprintf("   Bob Shared Key: %s\n",bobSharedKey))
}
main()