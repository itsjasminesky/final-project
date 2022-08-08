library(ggplot2)
library(dplyr)
setwd("~/Documents/final-project-staccjch/data")
world_happiness_21 <- read.csv("2021.csv")
ggplot(world_happiness_21, aes(x = Region, y = Economy..logged.GDP.per.Capita., fill = Region)) +
  geom_boxplot()+
  labs(title=" GDP per capita by world region, 2021", x= "Country", y = "Economy (GDP/Capita)") +
  theme(legend.position = "top")+
  coord_flip()
  

  



                                                                             