# Start of shiny server function
server <- function(input, output) {

  # Sources of scripts and data used in this project
  wa_df <- read.csv("data/WA_COVID19_Cases.csv", stringsAsFactors = FALSE)
  covid_df <- read.csv("data/owid-covid-data.csv", stringsAsFactors = FALSE)
  vaccinations_df <- read.csv("data/us_state_vaccinations.csv",
                              stringsAsFactors = FALSE)
  map_df <- read.csv("data/world_data_leaflet.csv", stringsAsFactors = F)
  source("scripts/chart Script 3.R")

  # Some data wrangling so that map_df is easier to use
  map_df <- map_df %>%
    select(-X)

  # Interactive map for the world for page one
  output$world_map <- renderLeaflet({
    # Data wrangling for our covid data frame in order to return the correct
    # values.
    recent_covid_df <- covid_df %>%
      filter(date == "2021-05-01", continent != "") %>%
      select(location, total_cases, total_deaths, new_cases, new_deaths)

    # Left join the world data so that it is able to be plot on leaflet
    world_covid_df <- map_df %>%
      rename(location = country) %>%
      left_join(recent_covid_df, by = "location") %>%
      drop_na() %>%
      mutate(total_cases_r = total_cases / 1000000,
             total_deaths_r = total_deaths / 30000,
             new_cases_r = new_cases / 12000,
             new_deaths_r = new_deaths / 100)

    # Map of the world
    map <- leaflet(data = world_covid_df,
            options = leafletOptions(worldCopyJump = T)) %>%
      addProviderTiles("Stamen.TonerLite") %>%
      addCircleMarkers(
        lat = ~latitude,
        lng = ~longitude,
        color = "Red",
        fillOpacity = .7,
        radius = world_covid_df[[paste0(input$data_types, "_r")]],
        stroke = FALSE,
        popup = ~paste("<b>Location:</b>", location, "<br/>",
                       "<b>People:</b>", world_covid_df[[input$data_types]])
      )

    return(map)
  })

  # map of the USA about the vaccinations
  output$us_map <- renderPlotly({
    # Data wrangling process in order for us to return the correct values
    vaccination_certain <- vaccinations_df %>%
      filter(date == as.POSIXct("2021-05-08")) %>%
      mutate(location = tolower(location))

    # Left join the state shape to the vaccination
    state_shape <- map_data("state") %>%
      rename(location = region) %>%
      left_join(vaccination_certain, by = "location")

    # Plot using ggplot then will add plotly to turn it into interactive
    vaccination_map <- ggplot(data = state_shape) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = location,
                      fill = total_vaccinations),
        color = "Black",
        size = .1,
        alpha = 0.8,
      ) +
      labs(title = "Map on vaccinations") +
      coord_map() +
      scale_fill_continuous(low = "White", high = "Red") +
      blank_theme

    # Add ggplotly function to make it interactive
    vaccination_plotly <- ggplotly(vaccination_map)
    return(vaccination_plotly)
  })

  # Output an interactive map of washington and its county
  output$washington_map <- renderPlotly({
    # Data wrangling to select a certain date
    county_df <- wa_df %>%
      filter(WeekStartDate == as.POSIXct("29/11/2020")) %>%
      select(County, TotalCases)

    # left join County information to the data frame
    county_map <- map_data("county") %>%
      filter(region == "washington") %>%
      mutate(County = paste(str_to_title(subregion), "County", sep = " ")) %>%
      left_join(county_df, by = "County")

    # Plot the map with ggplot
    county_plot <- ggplot(data = county_map) +
      geom_polygon(
        mapping = aes(x = long, y = lat, group = County,
                      fill =  TotalCases),
        color = "Black",
        size = .1,
        alpha = 0.8,
      ) +
      labs(title = paste0("Map of Washington state covid cases")) +
      coord_map() +
      scale_fill_continuous(low = "White", high = "Red") +
      blank_theme

    # Apply ggplotly function to make it interactive
    map <- ggplotly(county_plot)
    return(map)
  })

  # output the table concerning about the world map
  output$world_table <- renderTable({
    world_table_func()
  })

  # Output the table for the world map information in the key takeaway
  output$world_table_sum <- renderTable({
    world_table_func()
  })

  # Function in which used to create the tables
  world_table_func <- function() {
    table <- covid_df %>%
      filter(date == "2021-05-01", continent != "") %>%
      select("location", input$data_types)
    table <- table[order(table[tolower(input$data_types)],
                         decreasing = TRUE), ]
    table <- head(table, 5)
    return(table)
  }

  # Output the table concerning about the vaccination map
  output$vaccination_table <- renderTable({
    vaccination_table_func()
  })

  # Output the table concerning about the vaccination map on the key take away
  # Page
  output$vaccination_table_sum <- renderTable({
    vaccination_table_func()
  })

  # Function used to create the table of vaccinations
  vaccination_table_func <- function() {
    table <- vaccinations_df %>%
      filter(date == as.POSIXct("2021-05-08"),
             location != "United States") %>%
      select(location, total_vaccinations) %>%
      top_n(n = 5, wt = total_vaccinations) %>%
      arrange(desc(total_vaccinations))
    return(table)
  }

  # Output the table concerning about the vaccination map
  output$washington_table <- renderTable({
    washington_table_func()
  })

  # Output the table concerning about the vaccination map on key takeaway page
  output$washington_table_sum <- renderTable({
    washington_table_func()
  })

  # Function used to create the table of Washington data
  washington_table_func <- function() {
    table <- wa_df %>%
      filter(WeekStartDate == as.POSIXct("29/11/2020")) %>%
      select(County, TotalCases) %>%
      top_n(n = 5, wt = TotalCases) %>%
      arrange(desc(TotalCases))
    return(table)
  }

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

    # Plot using the ggplot function
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

  # For rendering bar plot of page 3
  output$covid_percentage_barplot <- renderPlot({
    #Make sure that covid_df is suitable for the graph
    updated_covid_df <- covid_df %>%
      filter(continent != "") %>%
      select(continent, new_cases, new_deaths, date) %>%
      filter(new_deaths >= 0 & new_cases >= 0) %>%
      filter(date >= as.POSIXct("2021-3-1") &
               date < as.POSIXct("2021-4-1")) %>%
      group_by(continent) %>%
      summarise(new_cases = sum(new_cases, na.rm = T),
                new_deaths = sum(new_deaths, na.rm = T),
                percentage = round(new_deaths / new_cases * 100, 1),
                .groups = "drop") %>%
      arrange(desc(percentage))
    positions <- updated_covid_df$continent

    # Plot the graph with trend lines
    plot <- ggplot(data = updated_covid_df) +
      geom_col(mapping = aes(x = continent, y = percentage, fill = continent)) +
      theme(legend.position = "none") +
      ylab("Percentage %") +
      xlab("Continent") +
      scale_x_discrete(limits = positions) +
      coord_flip()

    return(plot)
  })

  # For rendering table in key take away
  output$covid_table_sum <- renderTable({
    #Make sure that covid_df is suitable for the table
    updated_covid_df <- covid_df %>%
      filter(continent != "") %>%
      select(continent, new_cases, new_deaths, date) %>%
      filter(new_deaths >= 0 & new_cases >= 0) %>%
      filter(date >= as.POSIXct("2021-3-1") &
               date < as.POSIXct("2021-4-1")) %>%
      group_by(continent) %>%
      summarise(new_cases = sum(new_cases, na.rm = T),
                new_deaths = sum(new_deaths, na.rm = T),
                percentage = round(new_deaths / new_cases * 100, 1),
                .groups = "drop")

    table <- updated_covid_df %>%
      select(continent, percentage) %>%
      arrange(desc(percentage))

    return(table)
  })

  # For output of pie chart through the use of functions from scripts
  # Felt useless if we haven't used this pie chart too
  output$washington_covid_cases <- renderPlot({
    pie_chart_df(wa_df)
  })

  # For output of the pie chart on the takeaway page
  output$washington_covid_sum <- renderPlot({
    pie_chart_df(wa_df)
  })

  # To create a better looking maps using theme from ggplot
  # these line of code is derived from Chapter 16 in the book by Michael Freeman
  # and Joel Ross, called Programming Skills for Data Science
  blank_theme <- theme_bw() +
    theme(
      axis.line = element_blank(),
      axis.text = element_blank(),
      axis.ticks = element_blank(),
      axis.title = element_blank(),
      plot.background = element_blank(),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      panel.border = element_blank()
    )

}
