# load in original dataframes
setwd('~/info201/final-project-staccjch/data')
wh_2016_df <- read.csv('2016.csv')
wh_2015_df <- read.csv('2015.csv')
wh_2017_df <- read.csv('2017.csv')
wh_2018_df <- read.csv('2018.csv')
wh_2019_df <- read.csv('2019.csv')
wh_2020_df <- read.csv('2020.csv')
wh_2021_df <- read.csv('2021.csv')

# load in packages useful for further analysis
library(dplyr)
library(ggplot2)
library(hrbrthemes)

# what's the average happiness score in 2015?
calc_mean <- function(df){
  average = mean(df$Happiness.Score)
}
average_2015 = calc_mean(wh_2015_df)
average_2016 = calc_mean(wh_2016_df)
average_2017 = calc_mean(wh_2017_df)
average_2018 = calc_mean(wh_2018_df)
average_2019 = calc_mean(wh_2019_df)
average_2020 = calc_mean(wh_2020_df)
average_2021 = calc_mean(wh_2021_df)

# merge "average world happiness per year into a dataframe"
year <- c(2015, 2016, 2017, 2018, 2019, 2020, 2021)
mean_happiness <- c(average_2015, average_2016, average_2017, average_2018,
                    average_2019, average_2020, average_2021)
average_happiness_by_year <- data.frame(year, mean_happiness)

# Plot a connected scatterplot of the trend of average world happiness
average_happiness_by_year %>%
  tail(5) %>%
  ggplot( aes(x=year, y=mean_happiness)) +
  geom_line( color="grey") +
  geom_point(shape=21, color="black", fill="#69b3a2", size=6) +
  ggtitle("Average Happiness By Year")


