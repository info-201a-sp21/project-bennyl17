introduction_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction of Covid-19"),
  p("This is an introductory page into our shiny application...")
)

interactive_page_one <- tabPanel(
  "Covid-19 Map",
  h1(""),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "data_types",
        label = "types",
        choices = c("total_cases", "total_deaths", "new_cases", "new_deaths")
      )
    ),
    mainPanel(
      leafletOutput("world_map"),
      tableOutput("world_table")
    )
  ),
  h3(""),
  plotlyOutput("US_map")
)

interactive_page_two <- tabPanel(
  "Covid Vaccines",
  h1("Covid Vaccines"),
  sidebarPanel(
    radioButtons(inputId = "state", 
                 label = "States",
                 choices = c("North Dakota", "Rhode Island", 
                             "South Dakota", "Utah", "Tennessee",
                             "Arizona", "Iowa", "Nebraska", "Wisconsin",
                             "Oklahoma"))
  ),
  mainPanel(
    plotOutput("bar")
  )
)


interactive_page_three <- tabPanel(
  "Percentage of Deaths in March 2021",
  sidebarPanel(
    checkboxGroupInput(
      inputId = "checkbox",
      label = h3("Select Continent"),
      choices = c("Africa",  "Asia", "Europe", "North America", 
                  "Oceania", "South America"),
      selected = c("Africa",  "Asia", "Europe", "North America", 
                   "Oceania", "South America")
    )
    #,submitButton("Apply Continent(s)", icon("globe-americas"))
    # I have problems with this particular button
  ),
  mainPanel(
    plotOutput("covidratio")
  )
)

summary_page <- tabPanel(
  "Summary Takeaway"
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
