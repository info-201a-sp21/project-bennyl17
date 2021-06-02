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
      filter(date == "2021-05-01", continent != "") %>%
      select(location, total_cases, total_deaths, new_cases, new_deaths)
      
    world_covid_df <- map_df %>%
      rename(location = country) %>%
      left_join(recent_covid_df, by = "location") %>%
      drop_na() %>%
      mutate(total_cases = total_cases/1000000,
             total_deaths = total_deaths/30000, 
             new_cases = new_cases/12000, 
             new_deaths = new_deaths/100)
    
    map <- leaflet(data = world_covid_df, 
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
    
    return(map)
  })
  
  output$world_table <- renderTable({
    table <- covid_df %>%
      filter(date == "2021-05-01", continent != "") %>%
      select("location", input$data_types)

    
    table <- table[order(table[tolower(input$data_types)],
                         decreasing = TRUE), ]
    
    table <- head(table, 5)
    
    return(table)
      
  })
  
  output$bar <- renderPlot({
    
    updated_df <- vaccinations_df %>%
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
      ggtitle("Vaccinations by Day of Week in the USA") +
      theme(plot.title = element_text(hjust = 0.5)) +
      xlab("Day Name") +
      ylab("Occurences") +
      labs(fill = "Occurences")
  })
  
  output$covidratio <- renderPlot({
    updated_df <- covid_df %>%
      filter(continent != "") %>%
      select(continent, new_cases, new_deaths, date) %>%
      filter(new_deaths >= 0 & new_cases >= 0) %>%
      filter(date >= as.POSIXct("2021-3-1") &
             date < as.POSIXct("2021-4-1")) %>%
      group_by(continent, date) %>%
      summarise(new_cases = sum(new_cases, na.rm = T),
                new_deaths = sum(new_deaths, na.rm = T),
                percentage = round(new_deaths / new_cases * 100, 1),
                .groups = "drop") %>%
      mutate(day = as.numeric(format(as.Date(date), "%d")))
      
    
    # Plot the graph with trend lines
    plot <- ggplot(data = updated_df) +
      geom_point(mapping = aes(x = day, y = percentage, color = continent)) +
      geom_smooth(mapping = aes(x = day, y = percentage, color = continent),
                  method = "lm",
                  formula = y ~ splines::bs(x, 3),
                  se = FALSE) +
      xlab("Day in March") +
      ylab("Percentage %") +
      ggtitle("Percentage of Deaths from Covid by Continent in March 2021") +
      labs(color = "Continents") +
      scale_x_continuous(name = "Day in March", breaks = seq(1, 31, 3))
      return(plot)
  })
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
