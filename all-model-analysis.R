source('model-data-analysis.R')

summary.data.all <- NA
error.data.all <- NA

for(f in dir('models/results/')){
  print(f)
  info <- strsplit(substr(f, 1, nchar(f)-6), split="_")[[1]]
  music.type <- info[1]
  group <- info[2]
  load(paste0('models/results/',f))
  summary.data <- calculate.summary.results(data.result)
  error.data <- calculate.error.results(summary.data)
  summary.data$model.group <- group
  summary.data$model.type <- music.type
  error.data$model.group <- group
  error.data$model.type <- music.type
  if(is.na(summary.data.all)){
    summary.data.all <- summary.data
    error.data.all <- error.data
  } else {
    summary.data.all <- rbind(summary.data.all, summary.data)
    error.data.all <- rbind(error.data.all, error.data)
  }
}

rm(list=setdiff(ls(), c('summary.data.all', 'error.data.all')))

save.image('models/results/all.RData')

