

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
  
  # int map 1
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
    
    leaflet(data = world_covid_df) %>%
      addProviderTiles("Stamen.TonerLite") %>%
      addCircleMarkers(
        lat = ~latitude,
        lng = ~longitude,
        color = "Red",
        fillOpacity = .7,
        radius = world_covid_df[[input$data_types]],
        stroke = FALSE
      )
  })
  #int map 2
  output$bar <- renderPlot({
    
    updated_df <- data %>%
      mutate(day_name = weekdays(as.Date(date))) %>%
      filter(date >= as.POSIXct("2021-05-01") & date < as.POSIXct("2021-05-08")) %>%
      select(location, day_name, total_vaccinations) %>%
      filter(location == input$state)
    
    
    updated_df$day_name <- factor(updated_df$day_name,
                                  levels = c("Monday", "Tuesday",
                                             "Wednesday", "Thursday",
                                             "Friday", "Saturday",
                                             "Sunday"))
    
    ggplot(data = updated_df) +
      geom_col(mapping = aes(x = day_name, y = total_vaccinations, fill = day_name)) +
      scale_fill_manual(values = c("Monday" = "#FFFFB5",
                                   "Tuesday" = "#FF9161",
                                   "Wednesday" = "#FF6961",
                                   "Thursday" = "#ABDEE6",
                                   "Friday" = "#CCE2CB",
                                   "Saturday" = "#8FCACA",
                                   "Sunday" = "#FFB3BA"),
                        labels = c("Monday",
                                   "Tuesday",
                                   "Wednesday",
                                   "Thursday",
                                   "Friday",
                                   "Saturday",
                                   "Sunday")) +
      ggtitle("Vaccinations by Day of Week by Top Covid States") +
      theme(plot.title = element_text(hjust = 0.5)) +
      xlab("Day Name") +
      ylab("Occurences") +
      labs(fill = "Occurences")
  })
}

