# Aggregate Table Script
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

# Use a function to describe the happiness score average each year
avg <- function(df) {
  avg_of_year = mean(df$Happiness.Score)
}
average_2015 = avg(wh_2015_df)
average_2016 = avg(wh_2016_df)
average_2017 = avg(wh_2017_df)
average_2018 = avg(wh_2018_df)
average_2019 = avg(wh_2019_df)
average_2020 = avg(wh_2020_df)
average_2021 = avg(wh_2021_df)
# Group 'Happiness_by_Region_2021' into a table
Happiness_by_Region_2021 <- wh_2021_df %>%
  select(Country, Region, Happiness.Score) %>%
  group_by(Region) %>%
  summarize(avg_by_region = mean(Happiness.Score)) %>%
  arrange(desc(avg_by_region))



# Create a function to take the mean of all numeric columns
numeric_mean <- function(df) {
  numeric_mean_df <- df %>%
    summarise_at(c('Happiness.Score', 'Family', 
                   'Health..Life.Expectancy.' , 'Freedom', 
                 'Trust..Government.Corruption.', 'Generosity'),
               mean, na.rm = TRUE)
  return(numeric_mean_df)
}
# Create a table of all the means of numerical columns
all_means_2015 <- numeric_mean(wh_2015_df)
all_means_2016 <- numeric_mean(wh_2016_df)
all_means_2017 <- numeric_mean(wh_2017_df)
all_means_2018 <- numeric_mean(wh_2018_df)
all_means_2019 <- numeric_mean(wh_2019_df)
all_means_2020 <- numeric_mean(wh_2020_df)
all_means_2021 <- numeric_mean(wh_2021_df)

all_means_df <- rbind(all_means_2015, all_means_2016, all_means_2017,
                      all_means_2018, all_means_2019, all_means_2020, 
                      all_means_2021)
all_means_df$year <- c(2015, 2016, 2017, 2018, 2019, 2020, 2021)
all_means_df <- select(all_means_df, 7, 1, 2, 3, 4, 5, 6)



# Create a function to take the max of all numeric columns
numeric_mins <- function(df) {
  numeric_mins_df <- df %>%
    summarise_at(c('Happiness.Score', 'Family', 
                   'Health..Life.Expectancy.' , 'Freedom', 
                   'Trust..Government.Corruption.', 'Generosity'),
                 min, na.rm = TRUE)
  return(numeric_mins_df)
}

min_2015 <- numeric_mins(wh_2015_df)
min_2016 <- numeric_mins(wh_2016_df)
min_2017 <- numeric_mins(wh_2017_df)
min_2018 <- numeric_mins(wh_2018_df)
min_2019 <- numeric_mins(wh_2019_df)
min_2020 <- numeric_mins(wh_2020_df)
min_2021 <- numeric_mins(wh_2021_df)

all_mins_df <- rbind(min_2015, min_2016, min_2017, min_2018, 
                     min_2019, min_2020, min_2021)
all_mins_df$year <- c(2015, 2016, 2017, 2018, 2019, 2020, 2021)
all_mins_df <- select(all_mins_df, 7, 1, 2, 3, 4, 5, 6)


numeric_max <- function(df) {
  numeric_max_df <- df %>%
    summarise_at(c('Happiness.Score', 'Family', 
                   'Health..Life.Expectancy.' , 'Freedom', 
                   'Trust..Government.Corruption.', 'Generosity'),
                 max, na.rm = TRUE)
  return(numeric_max_df)
}

max_2015 <- numeric_max(wh_2015_df)
max_2016 <- numeric_max(wh_2016_df)
max_2017 <- numeric_max(wh_2017_df)
max_2018 <- numeric_max(wh_2018_df)
max_2019 <- numeric_max(wh_2019_df)
max_2020 <- numeric_max(wh_2020_df)
max_2021 <- numeric_max(wh_2021_df)

all_maxs_df <- rbind(max_2015, max_2016, max_2017, max_2018, 
                     max_2019, max_2020, max_2021)
all_maxs_df$year <- c(2015, 2016, 2017, 2018, 2019, 2020, 2021)
all_maxs_df <- select(all_maxs_df, 7, 1, 2, 3, 4, 5, 6)


# View all tables
View(Happiness_by_Region_2021)
View(all_means_df)
View(all_mins_df)
View(all_maxs_df)
