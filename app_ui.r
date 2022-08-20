# Load Shiny
library(shiny)
library(shinythemes)

# load libraries
library(stringr)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotly)
library(shinythemes)




# UI page 1: INTRODUCTION
page_one <- tabPanel(
  titlePanel("Introduction"),
  mainPanel(
    h1("Domain of Interest"),
    p('Happiness is typically thought of as a subjective experience and is 
    separate from numerical data. However, happiness like other complex traits 
    has multiple causes. We believe that positive and protective environmental 
    experiences are foundational in maintaining an enriching and meaningful life. 
    The purpose of this project is to analyze those factors that are deemed to 
    contribute to happiness on an international scale and to identify any 
    correlations between variables that quantify happiness. On this basis the 
    range of personal, social, economic, and environmental factors that are calculated 
    in the world happiness index provide us an intersectional lens while also 
    using multidimensional data.'),
    br(),
    h1('Dataset Citation'),
    tags$a(href='https://www.kaggle.com/datasets/mathurinache/world-happiness-report', tags$i('World Happiness Report Data')),
    p('We download our data from Kaggle: It’s a set of data on World Happiness from 2015 to 2022, 
    so it contains a total of 8 csv files within the set. The joy scores and rankings utilize 
    information from the Gallup World Survey. The scores are based on answers to the most life 
    evaluation address inquired within the survey. This file contains the Happiness Score for 153 
    countries and the factors used to explain the score.'),
    br(), 
    h1('Summary Paragraph'), 
    p(' As shown by the world happiness map there is an overall greater ranking of 
      happiness in the global West as opposed to the global South. This is also 
      supported by our lollipop graph that shows the happiness ranking per region. 
      We find that in recent years South Asia and Sub Saharan Africa had the lowest 
      happiness ranking whereas North America and Western Europe had the highest happiness 
      rankings. Using this information we decided to compare the two most important 
      happiness indicators, life expectancy and GDP, to visualize contrasting 
      differences between each country and found that the majority of Western 
      countries lie in the upper rankings with Singapore having the best rating and Chad, 
      an African country, having the worst rating in life expectancy and GDP. 
      In the happiness correlations tab we have a boxplot showing the rankings 
      for the indicators for happiness in each region. We find that many Eastern 
      countries tend to exceed in health, family, and trust. However this is also 
      paired with a disproportionate low ranking for generosity and freedom. 
      Interestingly enough these rankings are reversed in comparison to North America 
      and Western Europe. '),
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
      br(),
      p('This visualization is intended to show how a color gradient of the world happiness 
       scale each year. This can be used to visually capture the major differences of 
       the global west vs the global east through a color palette. ')
    ) # close main panel
  ) # close sidebarLayout
)# close page 2


# UI page Three: Lollipop Plot of regions
page_three <- tabPanel(
  titlePanel("Happiness by Region"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(inputId = 'radio2', h4('Choose Year to View Happiness by Regions:'), 
                   choices = list('2015' = 1, '2016' = 2, '2017' = 3, 
                                  '2018' = 4, '2019' = 5, '2020' = 6,
                                  '2021' = 7)),
    ),
    mainPanel(
      h1("Happiness by Region"),
      plotOutput(outputId = 'lollipop'),
      br(),
      p('This lollipop map describes the average happiness by region of every year. 
      In this graph, you can compare each region by its happiness score and look at
      the general trend.'))
  )
) # close page 4


# UI page four: Correlations
page_four <- tabPanel(
  titlePanel("Happiness Correlations"),
  tabsetPanel(
    # subpage1: scatterplot of health&GDP correlations
    tabPanel('Health & GDP',
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
                 br(),
                 p('This linear regression was intended to show the relationship between GDP 
                  and health each year. A positive GDP and health life expectancy are often 
                   assumed as important evaluators of happiness. Select year to see if this
                   scatterplot shows the same trend with happiness map. ')
               ) # close main panel
             ) # close sidebarLayout
    ), 
    # subpage2: boxplot of other factors
    tabPanel('Other Factors',
             sidebarLayout(
               sidebarPanel(
                 radioButtons(inputId = 'radio3', h4('Choose which factor Happiness correlates with:'), 
                              choices = list('Economy' = 1, 'Family' = 2, 'Health' = 3, 
                                             'Freedom' = 4, 'Generosity' = 5, 'Trust' = 6))),
               mainPanel(
                 h1("Other Correlations"),
                 plotOutput(outputId = 'boxplot'),
                 br(),
                 p('In the introduction, we\'ve mentioned that the happiness score dataset
                 uses a lot of evaluators like GDP, life expectancy, freedom, as evaluators.
                The boxplots of all evaluators of happiness score shows the range of each 
                evaluator. Can you see any surprising trends in each evaluator? ')
               ) # close main panel
             ) # close sidebarLayout  
    )
  ) # close tabset panel
  
)# close page 3



# UI page 5: About Team
page_five <- tabPanel(
  titlePanel("Conclusion"),
  tabsetPanel(
    tabPanel('Takeaways',
             h4('Takeaway 1'),
             p('One main takeaway from this project shows that the contrast in 
               the minimum happiness ranking could be attributed to environmental 
               factors and given that Afghanistan has been through internal conflict 
               whereas Finland, having the highest happiness index, is a relatively 
               stable and consistent country. This introduces the idea of  balance/harmony 
               and how it appears to have universal relevance and appeal. As the higher 
               rankings tended to be dominated by Western countries, particularly the 
               Nordic ones, as do the overall happiness rankings and countries in the 
               global East and South have endured a disproportionate amount of conflict 
               and corruption.'),
             h4('Takeaway 2'),
             p('Equally important as that base of evidence about well-being and happiness it\'s 
               crucial to use this data to set in motion changes within systems of oppression. 
               This can be achieved by quantifying the human experience in a digestible fashion 
               to better argue for a narrative change. Happiness indicators such as Health and 
               GDP can help identify exceptional healthcare, socioeconomic, and political 
               models that other countries can use as models and inspire others to 
               look past their own biases.'),
             h4('Takeaway 3'),
             p('The last takeaway, and possibly the most important, creating and 
               promoting new indicators is one part of shifting societies’ values 
               and conceptions around measured happiness, leading to new expectations 
               for progress and good policy. However, along that path, it\'s vital to
               acknowledge the inherently biased nature of this data. The design of indicator 
               frameworks is driven by what measurements are available, as a result many of 
               the happiness indicators are based on western values as this index was created 
               by white affluent western professionals. Without embracing any 
               particular theory of change, and having seen that these shifts 
               are underway as a geographically broad trend around the world,
               one might ask who is designing new measures of progress and well-being?'),
             h1('Summary Table'),
             dataTableOutput('table1')),
    tabPanel('About Team', 
             mainPanel(
               h4("Stacy Che"),
               tags$strong("Major: Economics, Education; Minor: Business"),
               p('I developed a lot from this project as a data analyst and team player. 
                  The measurement of happiness score and the trends we observed in this 
                  project allowed me to see the usefulness of data visulization. While the 
                  interactive map & data-wrangling in shiny improved my technical skill with R. 
                  I am a good team player; I realized  I am responsible for constantly updating 
                  my working progress, providing suggestions, and facilitating communication 
                  with my teammates. '),
               br(),
               h4("Erin Morales"),
               tags$strong("Major: Biochemistry; Minor: Data Science, Diversity"),
               p('As a biochemistry and pre med student I place great importance on understanding 
               the internal factors on maintaining a person\'s health and wellbeing. However, 
               oftentimes we forget to understand the external factors that contribute to
               a person’s welfare. As a result I believe analyzing the world happiness index
               can help identify key contributing factors to happiness that can lead individuals
               and society to a better, more meaningful, experience in life.'),
               br(),
               h4("Jasmine Y."),
               tags$strong("Majors: N/A"),
               p('This project reminded me of the factors that lead to a balanced life and 
               strong communities: health, support systems, income, freedom, honesty in government,
               and generosity. We can learn to use these factors to build into our value systems 
               and as a foundation for policy making. It is prevalent that this report favors 
               monetary values, with GDP per capita and Generosity being measured on donations 
              to charity. Brazil has a high crime and poverty rate, but my family has strong 
              social connections, causing greater emotional happiness. Nordic countries do have 
              subsidized schooling and free healthcare but are not utopias. Though citizens of 
              these counties are less likely to feel disenfranchised, there is also far-right 
              nationalism on the rise and a trend of homogeneity. To share happiness, 
              we must continue to fight for equity and make these six factors accessible 
              to all.')
             )) # close tabPanel 1
  ) # close tabset panel for P5
  
) # close page 5



# UI PAGE: 
ui <- navbarPage(
  theme = shinytheme("flatly"),
  "World Happiness Report",
  page_one,
  page_two,
  page_three,
  page_four,
  page_five,
  # CSS Style
  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Aboreto&display=swap');
      @import url('https://fonts.googleapis.com/css2?family=IBM Plex Serif&display=swap');
      body{background-color:#e7eaf6;}
      h1 {font-family: 'Aboreto';font-weight: 400;color: #113f67;}
      p {font-family: 'IBM Plex Serif';}"
    ) # close HTML
    ) # close style
  ) # close head
)# close navbarpage