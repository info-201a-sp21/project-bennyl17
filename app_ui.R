introduction_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction of Covid-19"),
  p("This is an introductory page into our shiny application...")
)

interactive_page_one <- tabPanel(
  "Covid-19 Map",
  h1(""),
  sidebarPanel(
    selectInput(
      inputId = "data_types",
      label = "types",
      choices = c("total_cases", "total_deaths", "new_cases", "new_deaths")
    )
  ),
  mainPanel(
    leafletOutput("world_map")
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
  )
)
############################################################
covid_df <- read.csv("data/owid-covid-data.csv", stringsAsFactors = FALSE)
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

continents <- unique(updated_df$continent)
interactive_page_three <- tabPanel(
  "Percentage of Deaths in March 2021",
  checkboxGroupInput(
    inputId = "checkbox",
    label = h3("Select Continent"),
    choices = continents
  ),
  submitButton("Apply Continent(s)", icon("globe-americas")),
  plotOutput(
    outputId = "covidratio"
  )
)
############################################################
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
