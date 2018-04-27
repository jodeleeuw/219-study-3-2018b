library(dplyr)
library(tidyr)
library(purrr)
library(ggplot2)

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
  summarize(model.error = sqrt(mean(error)))

error.data$music.type <- c("icon1", "icon2", "icon2", "icon2", "index", "icon1", "icon2", "index", "index", "index", "icon1", "index", "icon1", "index", "icon1", "icon2", "icon2", "icon1", "index", "icon1", "index", "icon2", "icon2", "icon1", "icon2", "index", "index", "icon2")

ggplot(summary.data, aes(x=choice, y=probability, color=source))+
  geom_point()+
  facet_wrap(~target)+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.5))

ggplot(error.data, aes(x=reorder(target,-model.error), y=model.error, fill=music.type))+
  geom_bar(stat='identity')+
  scale_fill_brewer(type="qual", palette = "Set1")+
  labs(x="Musical Excerpt", y="Model Error")+
  theme_minimal()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.25))

model.error <- sum(error.data$model.error)

error.data %>% group_by(music.type) %>% summarize(error = sum(model.error))

