# Load Shiny
library(shiny)
library(shinythemes)

# load libraries
library(stringr)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(plotly)
source("app_server.r")
source("app_ui.r")

# Run the application
shinyApp(ui = ui, server = server)