# Definitely needs to fix this
vaccinations_df <- read.csv("data/us_state_vaccinations.csv",
                            stringsAsFactors = FALSE)

introduction_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction of Covid-19"),
  p("This is an introductory page into our shiny application...")
)

interactive_page_one <- tabPanel(
  "Covid-19 Map",
  h1("Covid-19 Maps"),
  h3("The world map of covid-19"),
  sidebarPanel(
    selectInput(
      inputId = "data_types",
      label = h5("Types of Informations"),
      choices = c("total_cases", "total_deaths", "new_cases", "new_deaths")
    )
  ),
  mainPanel(
    leafletOutput("world_map"),
    tableOutput("world_table")
  )
)

interactive_page_two <- tabPanel(
  "Covid Vaccines",
  h1("Covid Vaccines"),
  sidebarPanel(
    radioButtons(inputId = "state", 
                 label = "Choices",
                 choices = unique(vaccinations_df$location)) # Need to fix this
  ),
  mainPanel(
    plotOutput("bar")
  )
)

interactive_page_three <- tabPanel(
  "title"
)

summary_page <- tabPanel(
  "title"
)

ui <- fluidPage(
  includeCSS("style.css"),
  navbarPage(
    "Covid Project",
    introduction_page,
    interactive_page_one,
    interactive_page_two,
    interactive_page_three,
    summary_page
  )
)
