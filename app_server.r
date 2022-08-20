# Load Shiny
library(shiny)
library(shinythemes)

# load libraries
library(stringr)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotly)
# load in original dataframes
wh_2016_df <- read.csv('data/2016.csv')
wh_2015_df <- read.csv('data/2015.csv')
wh_2017_df <- read.csv('data/2017.csv')
wh_2018_df <- read.csv('data/2018.csv')
wh_2019_df <- read.csv('data/2019.csv')
wh_2020_df <- read.csv('data/2020.csv')
wh_2021_df <- read.csv('data/2021.csv')
colnames <- read.csv('data/variable_index.csv')

# VIZ1: WORLD MAP data wrangling ###############################################
# import world map data
world_data <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
world_data <- select(world_data, COUNTRY, CODE)
colnames(world_data)[1] <- 'Country'
# Merge Happiness data & world data together
merge_maps <- function(df) {
  mapping <- df %>%
    select(Country, Happiness.Score)
  mapping <- merge(x = mapping, y = world_data, by = 'Country', all = TRUE) %>%
    na.omit()
}
map_2021 <- merge_maps(wh_2021_df)
map_2020 <- merge_maps(wh_2020_df)
map_2019 <- merge_maps(wh_2019_df)
map_2018 <- merge_maps(wh_2018_df)
map_2017 <- merge_maps(wh_2017_df)
map_2016 <- merge_maps(wh_2016_df)
map_2015 <- merge_maps(wh_2015_df)
###############################################################################

# VIZ2: REGIONAL LOLLIPOP CHART data wrangling#################################
# Create a function that returns the regional avg happiness each year
happiness_by_region <- function(df) {
  new_df <- df %>%
    select(Country, Region, Happiness.Score) %>%
    group_by(Region) %>%
    summarize(avg_by_region = mean(Happiness.Score)) %>%
    arrange(desc(avg_by_region))
  return(new_df)
}
# Defining new df with avg regional happiness each year: 15, 16, 20, 21
region_wh2021 <- happiness_by_region(wh_2021_df)
region_wh2020 <- happiness_by_region(wh_2020_df)
region_wh2016 <- happiness_by_region(wh_2016_df)
region_wh2015 <- happiness_by_region(wh_2015_df)

# Create a function that cleans the data & returns the regional avg happiness each year
happiness_by_region_with_na <- function(na_df) {
  region_no_na_df <- merge(x = wh_2021_df, y = na_df, by = 'Country', all = TRUE) %>%
    drop_na() %>%
    select(Country, Region, Happiness.Score.y) %>%
    group_by(Region) %>%
    summarize(avg_by_region = mean(Happiness.Score.y)) %>%
    arrange(desc(avg_by_region))
}
# Defining new df with avg regional happiness each year: 19, 18, 17
region_wh2019 <- happiness_by_region_with_na(wh_2019_df)
region_wh2018 <- happiness_by_region_with_na(wh_2018_df)
region_wh2017 <- happiness_by_region_with_na(wh_2017_df)
###############################################################################
# Viz3: Scatterplot
# not working bc no Economy format: 21, 20
names(wh_2021_df)[4] <- 'Economy..GDP.per.Capita.'
names(wh_2020_df)[4] <- 'Economy..GDP.per.Capita.'
# not working bc no Region: 19, 18, 17
just_region <- wh_2021_df %>%
  select('Country', 'Region')
add_region <- function(df) {
  with_region <- merge(x = just_region, y = df, by = 'Country', all.y = TRUE) %>%
    drop_na()
}
w_region_2017 <- add_region(wh_2017_df)
w_region_2018 <- add_region(wh_2018_df)
w_region_2019 <- add_region(wh_2019_df)
###############################################################################
# Viz4: Trend by year
# find min and max each year & return country name
# find max number, select the row, return country name
country_max <- function(df){
  max_num = max(df$Happiness.Score)
  max_country = df[df$Happiness.Score == max_num, 'Country']
}
max_21 = country_max(wh_2021_df)
max_20 = country_max(wh_2020_df)
max_19 = country_max(wh_2019_df)
max_18 = country_max(wh_2018_df)
max_17 = country_max(wh_2017_df)
max_16 = country_max(wh_2016_df)
max_15 = country_max(wh_2015_df)

country_min <- function(df){
  min_num = min(df$Happiness.Score)
  min_country = df[df$Happiness.Score == min_num, 'Country']
}
min_21 = country_min(wh_2021_df)
min_20 = country_min(wh_2020_df)
min_19 = country_min(wh_2019_df)
min_18 = country_min(wh_2018_df)
min_17 = country_min(wh_2017_df)
min_16 = country_min(wh_2016_df)
min_15 = country_min(wh_2015_df)

year <- c(2015, 2016, 2017, 2018, 2019, 2020, 2021)
max_happiness <- c(max_15, max_16, max_17, max_18, max_19, max_20, max_21)
min_happiness <- c(min_15, min_16, min_17, min_18, min_19, min_20, min_21)

happiness_table = data.frame(year, max_happiness, min_happiness)
###############################################################################


# server page
server <- function(input, output) {
  
  # Viz 0: show description table
  output$table<- renderDataTable(colnames)
  
  # Viz 1: World Happiness Map
  output$map <- renderPlotly({
    # make map function code: 
    make_map <- function(df) {
      # light grey boundaries
      l <- list(color = toRGB("grey"), width = 0.5)
      # specify map projection/options
      g <- list(
        showframe = FALSE,
        showcoastlines = FALSE,
        projection = list(type = 'Mercator')
      )
      
      world_map <- plot_geo(df) %>%
        add_trace(
          locations = ~CODE,
          z = ~Happiness.Score,
          color = ~ Happiness.Score,
          colors = 'Blues',
          text = ~Country,
          marker = list(line = l)
        ) %>%
        layout(
          geo = g,
          title = 'World Happiness Score'
        ) %>%
        colorbar(title = 'Happiness Score')
    } 
    # choose year
    if(input$radio == 1) {
      return(make_map(map_2015))
    }else if(input$radio == 2) {
      return(make_map(map_2016))
    }else if(input$radio == 3) {
      return(make_map(map_2017))
    }else if(input$radio == 4){
      return(make_map(map_2018))
    }else if(input$radio == 5){
      return(make_map(map_2019))
    }else if(input$radio == 6){
      return(make_map(map_2020))
    }else if(input$radio == 7){
      return(make_map(map_2021))
    }
  }) # close world happiness map
  
  # Viz 2
  output$scatterplot <- renderPlotly({
    # make scatterplot function code: 
    make_scatterplot <- function(df) {
      scatter <- plot_ly(df, x = ~Economy..GDP.per.Capita., y = ~Health..Life.Expectancy.,
                         # Hover text:
                         type = 'scatter',
                         text = ~Country,
                         color = ~Region,
                         #colors = c("red", "blue"),
                         size = ~Happiness.Score,
                         mode = "markers")
      print(scatter)
    } # close make_scatterplot
    
    # plot each year
    # # choose year
    if(input$radio1 == 1) {
      return(make_scatterplot(wh_2015_df))
    }else if(input$radio1 == 2) {
      return(make_scatterplot(wh_2016_df))
    }else if(input$radio1 == 3) {
      return(make_scatterplot(w_region_2017))
    }else if(input$radio1 == 4){
      return(make_scatterplot(w_region_2018))
    }else if(input$radio1 == 5){
      return(make_scatterplot(w_region_2019))
    }else if(input$radio1 == 6){
      return(make_scatterplot(wh_2020_df))
    }else if(input$radio1 == 7){
      return(make_scatterplot(wh_2021_df))
    }
  })
  
  # Viz 3
  output$lollipop <- renderPlot({
    make_lollipop <- function(region_df){
      lollipop_plot <- ggplot(region_df, aes(x=Region, y=avg_by_region)) +
        geom_segment( aes(x=Region, xend=Region, y=0, yend=avg_by_region), color="skyblue") +
        geom_point( color='#69b3a2', size=4, alpha=0.6) +
        theme_light() +
        coord_flip() +
        ggtitle("Average Happiness By Region")
      theme(
        panel.grid.major.y = element_blank(),
        panel.border = element_blank(),
        axis.ticks.y = element_blank()
      )
      print(lollipop_plot)
    }
    # choose year
    if(input$radio2 == 1) {
      return(make_lollipop(region_wh2015))
    }else if(input$radio2 == 2) {
      return(make_lollipop(region_wh2016))
    }else if(input$radio2 == 3) {
      return(make_lollipop(region_wh2017))
    }else if(input$radio2 == 4){
      return(make_lollipop(region_wh2018))
    }else if(input$radio2 == 5){
      return(make_lollipop(region_wh2019))
    }else if(input$radio2 == 6){
      return(make_lollipop(region_wh2020))
    }else if(input$radio2 == 7){
      return(make_lollipop(region_wh2021))
    }
  }) # close lollipop
  
  # Viz 4
  output$boxplot <- renderPlot({
    make_boxplot <- function(colnm, name){
      ggplot(wh_2021_df, aes(x = Region, y = colnm, fill = Region)) +
        geom_boxplot()+
        labs(title= paste(name, "by world region"), x= "Country", y = name) +
        scale_fill_brewer(palette="PuBu")+
        theme(legend.position = "top")+
        coord_flip()
    }
    colnames(wh_2021_df)
    # choose column name & name the title
    if(input$radio3 == 1) {
      return(make_boxplot(wh_2021_df$Economy..GDP.per.Capita., "Economy"))
    }else if(input$radio3 == 2) {
      return(make_boxplot(wh_2021_df$Family, "Family"))
    }else if(input$radio3 == 3) {
      return(make_boxplot(wh_2021_df$Health..Life.Expectancy., "Health&Life Expectancy"))
    }else if(input$radio3 == 4){
      return(make_boxplot(wh_2021_df$Freedom, "Freedom"))
    }else if(input$radio3 == 5){
      return(make_boxplot(wh_2021_df$Generosity, "Generosity"))
    }else if(input$radio3 == 6){
      return(make_boxplot(wh_2021_df$Trust..Government.Corruption., "Trust"))
    }
  })
  
  # Viz 5
  output$table1 <- renderDataTable(happiness_table)
} # close server