source("load-data.R")

test.model <- function(model.file){
  source(model.file)
  model.run.data <- trials
  for(i in 1:length(model.run.data)){
    result <- run(model.run.data[[i]]$target, model.run.data[[i]]$options)
    model.run.data[[i]]$result <- result
  }
  return(model.run.data)
}

data.result <- test.model("models/random-model.R")
