

# Start of shiny server function
server <- function(input, output) {
  
  # Sources of scripts/data where we will call functions
  # example: source("./scripts/...R")
  WA_df <- read.csv("data/WA_COVID19_Cases.csv", stringsAsFactors = FALSE)
  covid_df <- read.csv("data/owid-covid-data.csv", stringsAsFactors = FALSE)
  vaccinations_df <- read.csv("data/us_state_vaccinations.csv",
                              stringsAsFactors = FALSE)
  map_df <- read.csv("data/world_data_leaflet.csv", stringsAsFactors = F)
  
  # Some data wrangling so that map_df is easier to use
  map_df <- map_df %>%
    select(-X)
  
  # Earth: I'm going to create a map
  output$world_map <- renderLeaflet({
    recent_covid_df <- covid_df %>%
      filter(date == "2021-05-01") %>%
      select(location, total_cases, total_deaths, new_cases, new_deaths)
      
    world_covid_df <- map_df %>%
      rename(location = country) %>%
      left_join(recent_covid_df, by = "location") %>%
      drop_na() %>%
      mutate(total_cases = total_cases/1000000,
             total_deaths = total_deaths/30000, 
             new_cases = new_cases/12000, 
             new_deaths = new_deaths/100)
    
    leaflet(data = world_covid_df, 
            options = leafletOptions(worldCopyJump = T)) %>%
      addProviderTiles("Stamen.TonerLite") %>%
      addCircleMarkers(
        lat = ~latitude,
        lng = ~longitude,
        color = "Red",
        fillOpacity = .7,
        radius = world_covid_df[[input$data_types]],
        stroke = FALSE,
        popup = ~paste("<b>Location:</b>", location, "<br/>",
                       "<b>People:</b>", world_covid_df[[input$data_types]])
      )
  })
  
  output$world_table <- renderTable({
    
  })
  
}
