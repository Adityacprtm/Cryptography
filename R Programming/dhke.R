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

    # Calculated with formula
    y <- (g^x) %% p

    return(y)
}

main <- function() {
    cat("Enter a prime number as p: ")
    p <- readline()
    cat("Enter a number as g: ")
    g <- readline()
    cat("\n")

    cat("Alice Scret Key: ")
    xa <- readline()
    cat("Bob Secret Key: ")
    xb <- readline()
    cat("\n")

    cat("Publicly Shared Variables:\n")
    ya <- setup(p,g,xa)
    cat(sprintf("   Alice Sends to Bob Over Public Chanel: %s\n",ya))
    yb <- setup(p,g,xb)
    cat(sprintf("   Bob Sends to Alice Over Public Chanel: %s\n",yb))

    cat("\n----------------------------------\n\n")

    cat("Privately Calculated Shared Secret:\n")
    aliceSharedKey <- setup(p,yb,xa)
    bobSharedKey <- setup(p,ya,xb)
    cat(sprintf("   Alice Shared Key: %s\n",aliceSharedKey))
    cat(sprintf("   Bob Shared Key: %s\n",bobSharedKey))
}

main()