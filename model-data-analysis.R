library(dplyr)
library(purrr)
library(ggplot2)

targets <- data.result %>% 
  map(function(x){
    df <- data.frame(target=x$target, choice=x$options)
    df <- df %>% mutate(selected=choice %in% x$result)
    return(df)
  }) %>%
  rbind_all()

summary.data <- targets %>% group_by(target, choice) %>% summarize(p.select = sum(selected)/n())

ggplot(summary.data, aes(x=choice, y=p.select))+
  geom_bar(stat='identity')+
  facet_wrap(~target)+
  theme_minimal()
