introduction_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction to our Covid-19 project"),
  p("For our groups project, we decided to look into how much covid hasa really
    affected the world as a whole. Throughout the project, we look into not only
    the worlds numbers, but also look in more specific areas such as the US and 
    also Washington. Some of the main things that we were trying to answer were
    how has covid affected the world throughout this year with the pandemic. 
    Another thing that we thought was important to look into was the future of 
    this disease and how vaccinations will come into play and we answer a few 
    questions related to that about the spread of people getting the 
    vaccination. Will that cause cases to go up? down?"),
  img(src = "virus-picture.jpeg", width = 600, height = 300)
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
  ),
  h2("A pie chart into washington covid cases distribution of ages"),
  plotOutput("washington_covid_cases")
)

interactive_page_two <- tabPanel(
  "Covid Vaccines",
  h1("Covid Vaccines"),
  p("For this interactive barplot, we wanted to show how the vaccine has 
    positively affected these ten states. We chose to talk about these ten 
    states because they were the states with the most cases per 100,000 people.
    Specifically we toned down onto how many people get vaccinations each day of
    the week. With this, we were able to answer the following questions:
    "),
  p("With the states most affected by covid, how has the exposure of the vaccine
    been to civilians?"),
  p("Among these most affected states, which day of the week was most common for 
    people to get vaccinated?"),
  p("Which state had the highest number of vaccination cases and where do they
    rank among the top ten worst states based on covid cases?"),
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
  h1("Death Charts"),
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
  ),
  h2("barplot of Covid Ratio on 2021-3-1"),
  plotOutput("covid_percentage_barplot")

)

summary_page <- tabPanel(
  "Summary Takeaway",
  h2("Takeaway #1"),
  p(),
  h2("Takeaway #2"),
  p("We can see based on the vaccinations map and barplot that the states with
    the most cases per 100,000 people and the states with the most total 
    vaccinated people did not match up. As the map shows, California is the 
    state with the most total vaccinations but it also wasnt a top 10 state with
    the most cases per 100,000. We can also see that none of the top 5 states
    with vaccinations matched up with the top 10 states with most cases. As we 
    can see in the covid vaccines tab, none of the top ten states in the first 
    box were listed in the bottom box with the top 5 states with total 
    vaccinations. With this, we can see that they didnt really prioritize about 
    getting the vaccine to the states that needed it most, but instead they 
    prioritized going after the more popular and populated states such as 
    California, Texas, New York, and Florida."),
  h2("Takeaway #3")
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
