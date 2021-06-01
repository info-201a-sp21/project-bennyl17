# Remove global elements for easier debugging.
rm(list = ls())

# Load all the necessary libraries
library(shiny)
library(dplyr)
library(lintr)
library(ggplot2)
library(plotly)
library(leaflet)
library(tidyr)

# Source the UI and Server files
source("app_ui.R")
source("app_server.R")

# Create the shiny application
shinyApp(ui = ui, server = server)