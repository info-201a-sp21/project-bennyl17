introduction_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction of Covid-19"),
  p("This is an introductory page into our shiny application...")
)

interactive_page_one <- tabPanel(
  "Covid-19 Map",
  h1("Different Maps about covid-19"),
  p("For the map interactive page, we used the covid 19 data of the world and 
    the data about washington to generate two different maps on this page. This 
    page will contain only maps where all of them will be interactive showing 
    different types of map. The first map will be about the world. We will be 
    able to gain data from hovering over the markers. While the second 
    map will be focused within the Washington State and its county."),
  p("Question Number one: Which country in the world contained the most cases
    of Covid-19"),
  p("Question number two: Which contry contains the most new cases of Covid"),
  p("Question number three: Which county have the most cases of covid-19 in
    the state of Washington"),
  h2("Covid map of the world"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "data_types",
        label = "types",
        choices = c("total_cases", "total_deaths", "new_cases", "new_deaths")
      ),
      h4(paste0("Top 5 countries of different statistics")),
      tableOutput("world_table")
    ),
    mainPanel(
      leafletOutput("world_map")
    )
  ),
  h2("Covid map of Cases in Washington"),
  sidebarLayout(position = "right",
    sidebarPanel(
      h4("Top 5 county of Covid cases"),
      tableOutput("washington_table")
    ),
    mainPanel(
      plotlyOutput("washington_map")
    )
  )
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
  ),
  h2("Vacination of Covid map of the United States"),
  sidebarLayout(position = "right",
                sidebarPanel(
                  h4("Top 5 vaccinations states"),
                  tableOutput("vaccination_table")
                ),
                mainPanel(
                  plotlyOutput("US_map")
                )
  ),
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
