#Summary Information : World Happiness Report (2015-2021)
summary_info <- list()
library(dplyr)
setwd("~/Documents/final-project-staccjch/data")
world_happiness_21 <- read.csv("2021.csv")
summary_info$num_observations <- nrow(world_happiness_21) #149
summary_info$max_happiness_score <- max(world_happiness_21["Happiness.Score"])
world_happiness_21[world_happiness_21$Happiness.Score == summary_info$max_happiness_score,] #Finland 
summary_info$min_happiness_score <- min(world_happiness_21["Happiness.Score"]) #2.52
world_happiness_21[world_happiness_21$Happiness.Score == summary_info$min_happiness_score,]  #Afghanistan
summary_info$mean_happiness_score <- mean(world_happiness_21[["Happiness.Score"]], na.rm = TRUE) #5.53
summary_info18$median21 <- median(world_happiness_21$Happiness.Score) #5.38
summary_info$var== var(world_happiness_21["Happiness.Score"], na.rm = TRUE)
world_happiness_211<- max(world_happiness_21$Economy..logged.GDP.per.Capita.) 
world_happiness_21[world_happiness_21$Economy..logged.GDP.per.Capita. == world_happiness_211,] #Luxembourg
summary_info$minTrust21 <- min(world_happiness_21["Trust..Government.Corruption."])
world_happiness_21[world_happiness_21$Trust..Government.Corruption.== summary_info$minTrust21,] #Singapore 0.082
summary_info$maxTrust21<- max(world_happiness_21["Trust..Government.Corruption."]) #).939
world_happiness_21[world_happiness_21$Trust..Government.Corruption.== summary_info$maxTrust21,] #Croatia
summary_info$mean_health21 <- mean(world_happiness_21$Health..Life.Expectancy., na.rm = TRUE) #65

#summary info 2020
summary_info20$mean20 <- mean(world_happiness_20[["Happiness.Score"]], na.rm = TRUE) #5.47
world_happiness_20<-read.csv("2020.csv")
summary_info20 <- list()
summary_info20$num_observations <-nrow(world_happiness_20) #153
summary_info20$median20 <- median(world_happiness_20$Happiness.Score) #5.51
summary_info20$Generosity_max<- max(world_happiness_20$Generosity)
subset(world_happiness_20[c("Country","Generosity")], Generosity == summary_info20$Generosity_max) #Myanmar:0.560664
summary_info20$Generosity_min<- min(world_happiness_20$Generosity) #-.301)
subset(world_happiness_20[c("Country","Generosity")], Generosity == summary_info20$Generosity_min) #Greece -0.3009
summary_info20$max_gdp<- max(world_happiness_21$Economy..logged.GDP.per.Capita.) 
world_happiness_20[world_happiness_21$Economy..logged.GDP.per.Capita. == summary_info20$max_gdp,] #New Zealand  
summary_info20$mean_health <- mean(world_happiness_20$Health..Life.Expectancy., na.rm = TRUE) #64.4
summary_info20$max_health20 <- max(world_happiness_20$Health..Life.Expectancy., na.rm = TRUE) #76.8
subset(world_happiness_20[c("Country","Health..Life.Expectancy.")], Health..Life.Expectancy. == summary_info20$max_health20) #Singapore

#Summary Info 2019
summary_info$num_observations <- nrow(world_happiness_21) #149
world_happiness_19 <- read.csv("2019.csv")
summary_info19 <- list ()
summary_info19$meangdp19 <- mean(world_happiness_19[["Economy..GDP.per.Capita."]])
summary_info19$mean19 <- mean(world_happiness_19[["Happiness.Score"]], na.rm = TRUE) #5.41
summary_info19$median19 <- median(world_happiness_19$Happiness.Score) #5.38
summary_info19$meangdp19 <- mean(world_happiness_19[["Economy..GDP.per.Capita."]]) #0.905
summary_info19$mean_health <- mean(world_happiness_19$Health..Life.Expectancy.) #72.5
summary_info19$max_health <- max(world_happiness_19$Health..Life.Expectancy.)
subset(world_happiness_19[c("Country", "Health..Life.Expectancy.")], Health..Life.Expectancy. == summary_info19$max_health) #1.14, Singapoore
summary_info19$min_health <- min(world_happiness_19$Health..Life.Expectancy., na.rm = FALSE)
subset(world_happiness_19[c("Country","Health..Life.Expectancy.")], Health..Life.Expectancy. == summary_info19$min_health) #0 Swaziland
summary_info19$maxfreedom<- max(world_happiness_19$Freedom) #0.631
subset(world_happiness_19[c("Country","Freedom")], Freedom == summary_info19$maxfreedom) #Uzbekistan

# Summary Info 2018
summary_info18$num_observations <- nrow(world_happiness_18) #156
world_happiness_18 <- read.csv("2018.csv")
summary_info18 <- list()
summary_info18$meangdp18 <- mean(world_happiness_18[["Economy..GDP.per.Capita."]]) #0.891
summary_info18$mean18 <- mean(world_happiness_18[["Happiness.Score"]], na.rm = TRUE) #5.38
summary_info18$median18 <- median(world_happiness_18$Happiness.Score) #5.38
summary_info17$meangdp18 <- mean(world_happiness_17[["Economy..GDP.per.Capita."]]) #0.985
summary_info18$max_happiness_score18 <- max(world_happiness_18["Happiness.Score"])
world_happiness_18[world_happiness_18$Happiness.Score == summary_info18$max_happiness_score18,] #Finland
summary_info18$mean_health18 <- mean(world_happiness_18$Health..Life.Expectancy., na.rm = TRUE) #0.597
summary_info18$max_fam <- max(world_happiness_18["Family"])
world_happiness_18[world_happiness_18$Family== summary_info18$max_fam,] #Iceland 1.644
summary_info18$max_trust1 <- max(world_happiness_18["Trust..Government.Corruption."])


#Summary Info 2017
world_happiness_17 <- read.csv("2017.csv")
summary_info17 <- list()
summary_info17$num_observations <- nrow(world_happiness_17) #155
summary_info17$median17 <- median(world_happiness_17$Happiness.Score) #5.35
summary_info17$mean17 <- mean(world_happiness_17[["Happiness.Score"]], na.rm = TRUE) #5.35
summary_info17$meangdp17 <- mean(world_happiness_17[["Economy..GDP.per.Capita."]]) #0.985
summary_info17$leastfreedom <- world_happiness_17 %>% 
  slice_min(Freedom, n = 10) %>% 
  select(Country, Freedom) %>% 
  arrange(desc(Freedom))
summary_info17$mostfreedom <- world_happiness_17 %>% 
  slice_max(Freedom, n = 10) %>% 
  select(Country, Freedom) 
summary_info17$mostfreedom

#Summary Info 2016

world_happiness_16 <- read.csv("2016.csv")
summary_info16 <- list()
summary_info16$num_observations <- nrow(world_happiness_16) #157
summary_info16$median16 <- median(world_happiness_16$Happiness.Score) #5.31
summary_info16$mean16 <- mean(world_happiness_16[["Happiness.Score"]], na.rm = TRUE) #5.38
summary_info16$meangdp16 <- mean(world_happiness_16[["Economy..GDP.per.Capita."]]) #0.954
summary_info16$maxgdp16 <- max(world_happiness_16[["Economy..GDP.per.Capita."]]) #1.82
subset(world_happiness_16[c("Country","Economy..GDP.per.Capita.")], Economy..GDP.per.Capita. == summary_info16$maxgdp16) #Qatar 1.82
summary_info16$maxfreedom16 <- max(world_happiness_16[["Freedom"]]) #0.608
subset(world_happiness_16[c("Country","Freedom")], Freedom == summary_info16$maxfreedom16) #Qbekistan

#Summary Info 2015

world_happiness_15 <- read.csv("2015.csv")
summary_info15 <- list()
summary_info15$mean_health15 <- mean(world_happiness_15$Health..Life.Expectancy., na.rm = TRUE)  #0.63
summary_info15$num_observations <- nrow(world_happiness_15) #158
summary_info15$median15 <- median(world_happiness_15$Happiness.Score) #5.23
summary_info15$mean15 <- mean(world_happiness_15[["Happiness.Score"]], na.rm = TRUE) #5.38
summary_info15$meangdp15 <- mean(world_happiness_15[["Economy..GDP.per.Capita."]]) #0.846
world_happiness_15 %>% 
  slice_max(Health..Life.Expectancy., n = 10) %>% 
  select(Country, Region, Health..Life.Expectancy.)





