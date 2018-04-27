library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)

# remove buzzsaw, musical clock

targets <- data.result %>% 
  map(function(x){
    df <- data.frame(target=x$target, choice=x$options) %>% 
      mutate(model.selected=choice %in% x$result) %>%
      mutate(human.selected=choice %in% x$responses)
    return(df)
  }) %>%
  rbind_all()

summary.data <- targets %>% group_by(target, choice) %>% 
  summarize(model = sum(model.selected)/n(), human = sum(human.selected)/n())

summary.data <- summary.data %>% gather("source", "probability", 3:4)

error.data <- summary.data %>%
  spread("source", "probability") %>%
  mutate(error = (human-model)^2) %>%
  group_by(target) %>%
  summarize(model.error = mean(error))

ggplot(summary.data, aes(x=choice, y=probability, color=source))+
  geom_point()+
  facet_wrap(~target)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

ggplot(error.data, aes(x=reorder(target,-model.error), y=model.error))+
  geom_bar(stat='identity')+
  labs(x="Musical Excerpt", y="Model Error")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

model.error <- sum(error.data$model.error)

