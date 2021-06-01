# Sources of scripts where we will call functions
# example: source("./scripts/...R")

# Start of shiny server function
server <- function(input, output) {
  
  # Earth: I'm going to create a map
  output$map <- renderLeaflet({ 
  })
  
}
