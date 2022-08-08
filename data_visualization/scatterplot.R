library(ggplot2)
library(hrbrthemes)
library(tidyverse)
library(openintro)

happiness_df <- read.csv("2021.csv")

View(happiness_df)

happiness_country <- happiness_df %>%
  select(Country)

View(happiness_country)

# Keep 30 first rows in the mtcars natively available data set
data=head(happiness_df, 149)

main = "Health vs GDP" 

model <- lm(Health..Life.Expectancy. ~ Economy..logged.GDP.per.Capita., data = happiness_df)
summary(model)

# 1/ add text with geom_text, use nudge to nudge the text
ggplot(happiness_df, aes(x=Economy..logged.GDP.per.Capita., y=Health..Life.Expectancy.)) +
  geom_point() + # Show dots
  labs(title= "GDP vs Health Expectancy", x= "Economy (GDP/Capita)", y= "Life Expectancy") +
  geom_text(
    label= data$Country,
    nudge_x = 0.25, nudge_y = 0.25, 
    check_overlap = T) + stat_smooth(method = "lm", se = FALSE)

hist(model$residuals)


world_happiness_21 <- read.csv('2021.csv')

ggplot(world_happiness_21, aes(x = Region, y = Economy..logged.GDP.per.Capita., fill = Region)) +
  geom_boxplot()+
  labs(title=" GDP per capita by world region, 2021", x= "Country", y = "Economy (GDP/Capita)") +
  theme(legend.position = "top")+
  coord_flip()

