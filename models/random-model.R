run <- function(target_concept, options){
  p <- 0.1
  selectedWords <- options[rbinom(length(options), 1, p) == 1]
  return(selectedWords)
}
