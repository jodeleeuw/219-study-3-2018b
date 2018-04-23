run <- function(target_concept, options){
  p <- 0.08
  selectedWords <- options[rbinom(length(options), 1, p) == 1]
  return(selectedWords)
}
