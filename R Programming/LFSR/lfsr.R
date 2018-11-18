LFSR <- function() {
  init_state <- 5
  print(bitwShiftR(init_state,1))
}

binary <- function(p_number) {
  bsum <- 0
  bexp <- 1
  while (p_number > 0) {
    digit <- p_number %% 2
    p_number <- floor(p_number / 2)
    bsum <- bsum + digit * bexp
    bexp <- bexp * 10
  }
  return(bsum)
}

main <- function(clock) {
  clock <- as.numeric(clock)
  for (i in 0:clock) {
    LFSR()
  }
}

main(5)