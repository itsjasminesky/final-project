# Load Shiny
library(shiny)
library(shinythemes)

# load libraries
library(stringr)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotly)
setwd("~/info201/final-project-staccjch/data")
# load in original dataframes
wh_2016_df <- read.csv('2016.csv')
wh_2015_df <- read.csv('2015.csv')
wh_2017_df <- read.csv('2017.csv')
wh_2018_df <- read.csv('2018.csv')
wh_2019_df <- read.csv('2019.csv')
wh_2020_df <- read.csv('2020.csv')
wh_2021_df <- read.csv('2021.csv')
colnames <- read.csv('variable_index.csv')

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
# Viz: Scatterplot
# not working bc no Economy format: 21, 20
names(wh_2021_df)[4] <- 'Economy..GDP.per.Capita.'
names(wh_2020_df)[4] <- 'Economy..GDP.per.Capita.'
# not working bc no Region: 19, 18, 17
just_region <- wh_2021_df %>%
  select('Country', 'Region')
add_region <- function(df) {
  with_region <- merge(x = just_region, y = wh_2017_df, by = 'Country', all.y = TRUE) %>%
    drop_na()
}
w_region_2017 <- add_region(wh_2017_df)
w_region_2018 <- add_region(wh_2018_df)
w_region_2019 <- add_region(wh_2019_df)
###############################################################################

# UI page 1: INTRODUCTION
page_one <- tabPanel(
  titlePanel("Introduction"),
  mainPanel(
    h1("Domain of Interest"),
    p('We believe happiness and health go hand in hand. The range of personal, social, 
                economic, and environmental factors that influence health status are known as determinants 
                of health but can also account for a population\'happiness.
                We believe an intersectional lens is vital in identifying key factors that play 
                into an individual\' happiness. In turn, using multidimensional data could be 
                crucial in implementing evidence-based policies to serve the public through an 
                intersectional lens better.'),
    br(), 
    h1('Summary Paragraph'), 
    p('In 2021, Afghanistan had the minimum happiness while Finland had the happiness score. 
               Singapore has the highest life expectancy in 2019 and 2020 but also the largest distrust 
               in the government in 2021. Also, in 2021, Croatians had the highest trust in government. 
               The average rate of happiness peaked in 2021 being 5.51, while the highest median was in 2020, 
               which could indicate more outliers. 
               The lowest average happiness was in 2017, being 5.38. 
               The max GDPs tend to be in western Europe, small, high GDP distribution of GDPS, 
               or the Middle East, which has a significant variation in GDP per capita. 
               Mean health and life expectancy steadily increased yearly, with the healthiest 
               regions primarily being East Asia and Western Europe. 
               The countries with the least freedom were majorly in Central and Eastern Europe, 
               the Middle East, and Sub-Saharan Africa. In contrast, the countries with the most 
               freedom were Western Europe and Central Asia. The number of countries per year varied, 
               peaking in 2015 at 158 countries and the least in 2019 and 2021 with 149 countries. '),
    br(),
    h1('Happiness Evaluators Descriptions'),
    dataTableOutput('table'))# close main panel
)

# UI page 2 world map:
page_two <- tabPanel(
  titlePanel("Happiness Map"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = 'radio', h4('Choose Year to View Happiness Score Map:'), 
                   choices = list('2015' = 1, '2016' = 2, '2017' = 3, 
                                  '2018' = 4, '2019' = 5, '2020' = 6,
                                  '2021' = 7)),
    ),
    mainPanel(
      plotlyOutput(outputId = 'map'),
      h1('World Happiness Score by Year'),
      p('This visualization is intended to show how a color gradient of the world happiness 
       scale in the year 2021. This can be used to visually capture the major differences of 
       the global west vs the global east through a color palette. ')
    ) # close main panel
  ) # close sidebarLayout
)# close page 2


# UI page Three: Lollipop Plot of regions
page_three <- tabPanel(
  titlePanel("Happiness by Region"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = 'radio2', h4('Choose Year to View Happiness Score Map:'), 
                   choices = list('2015' = 1, '2016' = 2, '2017' = 3, 
                                  '2018' = 4, '2019' = 5, '2020' = 6,
                                  '2021' = 7)),
    ),
    mainPanel(
      h1("Happiness by Region"),
      plotOutput(outputId = 'lollipop'),
      p('This lollipop map describes the average happiness by region of every year. 
      In this graph, you can compare each region by its happiness score and look at
      the general trend.'))
  )
) # close page 4


# UI page four: Correlations
page_four <- tabPanel(
  titlePanel("Happiness Correlations"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = 'radio1', h4('Choose Year to View Health vs GDP:'), 
                   choices = list('2015' = 1, '2016' = 2, '2017' = 3, 
                                  '2018' = 4, '2019' = 5, '2020' = 6,
                                  '2021' = 7))
    ),
    mainPanel(
      h1("GDP vs. Life Expantancy Impacts"),
      plotlyOutput(outputId = 'scatterplot'),
      p('This linear regression was intended to show the relationship between GDP 
    and health and a line that emphisizes the positive correlation of linear graph.
    The Histogram of the Residual can be used to check whether the variance is normally 
    distributed. A symmetric bell-shaped histogram which is evenly distributed around 
    zero indicates that the normality assumption is likely to be true. 
    But since the histogram has a slight negative skew there is likely to be other factors 
    contributing to the varience in the data.')
    ) # close main panel
  ) # close sidebarLayout
)# close page 3



# UI page 5: About Team
page_five <- tabPanel(
  titlePanel("About Team"),
  mainPanel(
    h4("Stacy Che"),
    h4("Junior"),
    h4("Major: Economics, Education"),
    p('xxxxxxx'),
    br(),
    h4("Erin Morales"),
    h4("Senior"),
    h4("Major: Biochemistry"),
    p('xxxxxx'),
    br(),
    h4("Jasmine Y."),
    h4("Sophomore"),
    h4("Majors: N/A"),
    p('xxxxxxxx')
  )
)



# UI PAGE: 
ui <- navbarPage(
  theme = shinytheme("flatly"),
  "World Happiness Report",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five
)


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
          colors = 'Greens',
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
  
  
  
} # close server





# Run the application
shinyApp(ui = ui, server = server)