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
  
  output$US_map <- renderPlotly({
    vacination_certain <- vaccinations_df %>%
      filter(date == as.POSIXct("2021-05-08")) %>%
      mutate(location = tolower(location))
    
    state_shape <- map_data("state") %>%
      rename(location = region) %>%
      left_join(vacination_certain, by = "location")
    
    vaccination_map <- ggplot(data = state_shape) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = group,
                      fill = total_vaccinations),
        color = "Black",
        size = .1,
        alpha = 0.8,
      ) +
      labs(title = "Map on vaccinations") +
      coord_map() +
      scale_fill_continuous(low = "White", high = "Red") +
      blank_theme
    
    vaccination_plotly <- ggplotly(vaccination_map)
    
    return(vaccination_plotly)
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
  
  # For rendering bar plot on the second interactive page
  output$bar <- renderPlot({
    # For updating the data frame in order for it work
    updated_df <- vaccinations_df %>%
      mutate(day_name = weekdays(as.Date(date))) %>%
      filter(date >= as.POSIXct("2021-05-01") & 
               date < as.POSIXct("2021-05-08")) %>%
      select(location, day_name, total_vaccinations) %>%
      filter(location == input$state)
    
    # For adding levels of factors
    updated_df$day_name <- factor(updated_df$day_name,
                                  levels = c("Monday", "Tuesday",
                                             "Wednesday", "Thursday",
                                             "Friday", "Saturday",
                                             "Sunday"))
    
    ggplot(data = updated_df) +
      geom_col(mapping = aes(x = day_name, y = total_vaccinations, 
                             fill = day_name)) +
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

  # For rendering interactive page of page 3
  output$covidratio <- renderPlot({
    #Make sure that covid_df is suitable for the graph
    updated_covid_df <- covid_df %>%
      filter(continent %in% input$checkbox) %>%
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
    plot <- ggplot(data = updated_covid_df) +
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
  
  blank_theme <- theme_bw() +
    theme(
      axis.line = element_blank(),        # remove axis lines
      axis.text = element_blank(),        # remove axis labels
      axis.ticks = element_blank(),       # remove axis ticks
      axis.title = element_blank(),       # remove axis titles
      plot.background = element_blank(),  # remove gray background
      panel.grid.major = element_blank(), # remove major grid lines
      panel.grid.minor = element_blank(), # remove minor grid lines
      panel.border = element_blank()      # remove border around plot
    )
  
}

