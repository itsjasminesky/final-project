library(ggplot2)
library(hrbrthemes)
library(tidyverse)
library(openintro)

happiness_df <- read.csv("2021.csv")

View(happiness_df)

happiness_country <- happiness_df %>%
  select(Country.name)

View(happiness_country)

# Keep 30 first rows in the mtcars natively available data set
data=head(happiness_df, 149)

main = "Health vs GDP" 

model <- lm(Healthy.life.expectancy ~ Logged.GDP.per.capita, data = happiness_df)
summary(model)

# 1/ add text with geom_text, use nudge to nudge the text
ggplot(happiness_df, aes(x=Logged.GDP.per.capita, y=Healthy.life.expectancy)) +
  geom_point() + # Show dots
  geom_text(
    label= data$Country.name,
    nudge_x = 0.25, nudge_y = 0.25, 
    check_overlap = T) + stat_smooth(method = "lm", se = FALSE)

hist(model$residuals)

