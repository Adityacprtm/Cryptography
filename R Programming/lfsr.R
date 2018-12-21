setupInisial <- function(){
    cat("Input a number as grade : ")
    grade <- readline()
    inisial <- array(c(rep(1,grade)))
    return(inisial)
}

setupXor <- function(){
    xor <- array()
    cat("Input a lot of xor : ")
    banyakXOR <- readline()
    for(i in 1 : banyakXOR){
        cat("Enter position xor ",i," : ")
        xor[i] <- as.numeric(readline())
    }
    return(xor)
}

lfsr <- function(inisial, xor){
    hasil <- inisial
    tmp <- inisial
    blok <- length(inisial)
    clock <- (2^blok)-1

    for (i in 1:clock){

        for (j in 1:blok){
            if(j==1){
                tmp[j] <- hasil[blok]
            }
            else{
                tmp[j] <- hasil[j-1]
            }
        }
        
        for(j in 1:blok){
            if(j %in% xor){
                tmp[j+1] <- bitwXor(hasil[j], tmp[j])
            } 
        }
        
        hasil <- tmp
        print(hasil)

        if(all(hasil == inisial)){
            break
        }
    }
}

main <- function(){
    inisial <- setupInisial()
    xor <- setupXor()
    lfsr(inisial, xor)
}

main()
