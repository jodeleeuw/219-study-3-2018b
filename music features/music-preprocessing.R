library(readr)
library(tidyr)
library(dplyr)
nsubjects <- 13
nquestions <- 9
raw.data <- read_csv('music features/musical_features.csv')[2:14,]
long.data <- raw.data %>% gather("measure", "value", 2:253)
clips <- c("arrival", "basement", "bird", "blossom", "blue", "celebration", "circle", "cradle", "departure", "devotion", "fight", "hero", "jungle", "mischief", "mockery", "narrowness", "needle", "ocean", "peaceful", "quarrel", "red", "river", "rushed", "sigh", "staircase", "strength", "toxin", "wideness")

long.data$music <- rep(clips, each=nsubjects*nquestions)
measures <- c("fast", "slow", "high", "low", "loud", "soft", "consonant", "dissonant", "instruments")
long.data$measure <- rep(measures, each=nsubjects)

long.data$subject <- 1:nsubjects
long.data <- long.data %>% select(subject, music, measure, value)
write_csv(long.data, 'music features/music-features-processed.csv')
