# Remove global elements for easier debugging. 
rm(list = ls())

# Load all the necessary libraries
library(shiny)
library(dplyr)

# Source the UI and Server files
source("app_ui.R")
source("app_server.R")

# Create the shiny application
shinyApp(ui = ui, server = server)