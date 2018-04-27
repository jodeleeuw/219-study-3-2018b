library(readr)
library(dplyr)
library(stringr)
library(jsonlite)

trial.data <- read_csv2('data/raw_data_semicolon.csv')

data <- trial.data %>% 
  filter(trial_type == "survey-multi-select") %>%
  filter(!stimulus %in% c("Musical Clock", "Buzzsaw")) %>%
  select(stimulus, options, responses)

trials <- vector("list", nrow(data))

for(i in 1:nrow(data)){
  trials[[i]]$target <- data$stimulus[i] %>% tolower
  
  x <- data$options[i]
  y <- fromJSON(x)
  z <- str_replace(y, " ", "") %>% tolower
  trials[[i]]$options <- z[1:15]
  
  xx <- data$responses[i]
  yy <- fromJSON(xx)$Q0
  zz <- str_replace(yy, " ", "") %>% tolower
  zz <- zz[zz != "none of the above"]
  trials[[i]]$responses <- zz
}


