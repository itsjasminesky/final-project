library(plotly)
# load in original dataframes
setwd('~/info201/final-project-staccjch/data')
mapping <- read.csv('2021.csv')
df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
df <- select(df, COUNTRY, CODE)
colnames(df)[1] <- 'Country'
happiness_map_2021 <- merge(x = wh_2021_df, y = df, by = 'Country', all = TRUE)
happiness_map_2021 <- select(happiness_map_2021, Country, CODE, Happiness.Score)
happiness_map_2021 <- na.omit(happiness_map_2021)
  

# light grey boundaries
l <- list(color = toRGB("grey"), width = 0.5)

# specify map projection/options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)
 
fig <- plot_geo(happiness_map_2021)
fig <- fig %>% add_trace(
  z = ~Happiness.Score, color = ~Happiness.Score, colors = 'Greens',
  text = ~Country, locations = ~CODE, marker = list(line = l)
)
fig <- fig %>% colorbar(title = 'Happiness Score', tickprefix = ':) ')
fig <- fig %>% layout(
  title = 'World Happiness 2021',
  geo = g
)

fig
