introduction_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction to our Covid-19 project"),
  p("For our group's project, we decided to look into how much covid has really
    affected the world as a whole. Throughout the project, we looked at not only
    the worlds numbers, but also look in more specific areas such as the US and
    also Washington. Some of the main things that we were trying to answer were
    how has covid affected the world throughout this year with the pandemic.
    Another thing that we thought was important to look into was the future of
    this disease and how vaccinations will come into play and we answer a few
    questions related to that about the spread of people getting the
    vaccination. Will that cause cases to go up? down?"),
  h3("About our data sources:"),
  HTML("<p> First data set:
  <a href=https://www.kaggle.com/paultimothymooney/usa-covid19-vaccinations'>
       USA COVID-19 Vaccinations</a>
  <br>Description:</br> This data set gives us information about how many 
    daily vaccinations there are daily in every state. They are partnered
    up with the CDC and numerous healthcare companies in order to
    track the vaccination campaign in the US. This is a dataset where they
    update it daily as well.</p>
  <p> Second data set:
  <a href= https://ourworldindata.org/covid-deaths'>
       Coronavirus (COVID-19) Deaths</a>
  <br>Description:</br>The data was collected by a team of researchers and
    statisticians who drew data from a combination of data sources, lab
    reportings, and disease surveillance. The data is mainly about the deaths
    from coronavirus, with information about other stuff available through
    the csv file.</p>
  <p> Third data set:
  <a href=https://www.doh.wa.gov/Emergencies/COVID19/DataDashboard'>
       COVID-19 in Washington State</a>
  <br>Description:</br> The data was collected by the Washington state 
    department of health. This dataset about COVID-19 in Washington State has
    information on cases, hospitalizations, deaths, and vaccination by county
    in a format of XLSX file. Which we then translated into cases.csv file to
    make further investigations about cases of covid-19 in Washington. The data
    set talks about the county, cases, age and time.</p>"),
  tags$br(),
  img(src = "virus-picture.jpeg", width = 600, height = 300),
  tags$p(id = "caption",
         "This images show the novel virus at a microscopic level"),
  tags$br(),
  h3("Summary Table:"),
  tableOutput("overview_table"),
  tags$p(id = "warning",
         "Our data sources are huge will take quite a bit of time to
         load. So please be patient and sorry for any inconveniences.")
)

interactive_page_one <- tabPanel(
  "Covid-19 World and WA",
  h1("Different Informations about covid-19"),
  p("For the this interactive page, we used the covid 19 data of the world and
    the data about washington to generate two different maps on this page and a
    pie chart. This page will interactive maps and piechart showing different
    level of information. The first map will be about the world. We will be
    able to gain data from hovering over the markers. While the second
    map will be focused within the Washington State and its county. The last pie
    chart is to further investigate about Washington State"),
  p("Possible questions answered in this page:"),

  tags$ol(
    tags$li(tags$p(id = "question",
  "Which country in the world contained the most cases
    of Covid-19?")),
  tags$li(tags$p(id = "question",
  " Which age group in Washington had the most covid cases?")),
  tags$li(tags$p(id = "question",
  "Which county have the most cases of covid-19 in the state of Washington?")),
  tags$li(tags$p(id = "question",
         "What age group in Washington have the most covid cases?"))
  ),
  h2("Covid map of the world"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "data_types",
        label = "Types of Statistics",
        choices = list("Total Cases" = "total_cases",
                       "Total Deaths" = "total_deaths",
                       "New Cases" = "new_cases", "New Deaths" = "new_deaths")
      ),
      h3(paste0("Top 5 countries of different statistics")),
      tableOutput("world_table")
    ),
    mainPanel(
      leafletOutput("world_map"),
      tags$p(id = "caption",
             "A world map where each red circle shows the different statistics
             of the selected input. This was updated on 2021-05-01")
    )
  ),
  h2("Covid Map of Cases in Washington"),
  sidebarLayout(position = "right",
    sidebarPanel(
      h4("Top 5 county of Covid cases"),
      tableOutput("washington_table")
    ),
    mainPanel(
      plotlyOutput("washington_map"),
      tags$p(id = "caption",
             "A Washington State map showing the total cases of Covid
             in each county, hovering will show the county names and cases.
             This was updated on 29/11/2020")
    )
  ),
  h2("Washington Covid Cases Distribution of Ages"),
  plotOutput("washington_covid_cases"),
  tags$p(id = "caption",
         "A pie chart showing the distribution of ages in washington
         according to the ages")
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
  tags$ol(
    tags$li(tags$p(id = "question",
    "Do any of the top 5 vaccinated states rank in the top 10 states with
    the most covid cases per 100,000 people?")),
    tags$li(tags$p(id = "question",
    "Among these most affected states, which day of the week was most common for
      people to get vaccinated?")),
    tags$li(tags$p(id = "question",
    "Which state had the highest number of vaccination cases and do they
      rank among the top ten worst states based on covid cases?"))
  ),
  sidebarPanel(
    radioButtons(inputId = "state",
                 label = "Top 10 States with most Cases per 100,000",
                 choices = c("North Dakota", "Rhode Island",
                             "South Dakota", "Utah", "Tennessee",
                             "Arizona", "Iowa", "Nebraska", "Wisconsin",
                             "Oklahoma"))
  ),
  mainPanel(
    plotOutput("bar"),
    tags$p(id = "caption",
           "An interactive bar plot showing vaccinations by day of the week
           where the selected input will be the states")
  ),
  h2("Vaccination of Covid map of the United States"),
  fluidRow(
    column(8),
    column(4, "Below we decided to include an aggregate table of the
               top 5 states in the US getting vaccinations. The table
               decends from highest to lowest on the number of people
               getting vaccinated.")
  ),
  sidebarLayout(position = "right",
                sidebarPanel(
                  h4("Top 5 vaccinations states"),
                  tableOutput("vaccination_table")
                ),
                mainPanel(
                  plotlyOutput("us_map"),
                  tags$p(id = "caption",
                         "A map of Covid 19 vaccination in the USA where
                         information about new york wasn't avaliable.
                         This was updated on: 2021-05-08")
                )
  ),
)

interactive_page_three <- tabPanel(
  "Percentage of Deaths in March 2021",
  h1("Death Charts"),
  p("On this page we decided to create an interactive scatter plot which
    represented each Continent (excluding Antarctica) with data on the
    percentage of deaths from covid cases through the month of March 2021.
    The scatter plot provides a detailed insight on the percentages of
    deaths through all of March 2021. While the bar plot is an easier to read
    condensed version of the scatter plot, it provides insight on the average
    percentage of deaths through the whole month of March. With these 2
    visulizations, we can answer the following questions:"),
  tags$ol(
    tags$li(tags$p(id = "question",
    "Which continent had the highest death percentage in March 2021?")),
    tags$li(tags$p(id = "question",
         "Which continent had the lowest average deaths?")),
  tags$li(tags$p(id = "question",
  "Which continent had the highest death percentage on the last day of March
    (3-31-2021)?"))
  ),
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
    plotlyOutput("covidratio"),
    tags$p(id = "caption",
           "This shows the scatter plot with a trend line showing
           different continent covid ratio on each day in March")
  ),
  h2("Average Percentages of Deaths per Continent in March 2021"),
  plotOutput("covid_percentage_barplot"),
  tags$p(id = "caption",
         "This is a bar plot showing average percentages of deaths from Covid
         cases in the month of March 2021")

)

summary_page <- tabPanel(
  "Key Takeaway",
  h1("Key Take Aways from this Project"),
  h2("Takeaway #1"),
  p("The first take away is that the Country that contains the most Covid cases
    is the United States. Which we decided to investigate further into this
    Country. We zoom in right where we are which is Washington. From the map,
    we can see that the County that contain the most cases is King County,
    which is where the University of Washington is located. Futhermore,
    from the pie chart, we see that within Washington, the age group that get
    the most amount of Covid cases is the 20 to 34. This is really reasonable
    because this particular age group have great potentials to go outside which
    is the number one way to attract covid-19."),
  fluidRow(
    column(4, tags$h5(id = "bold", "World countries"),
           tableOutput("world_table_sum")),
    column(4, tags$h5(id = "bold", "Washington Table"),
           tableOutput("washington_table_sum")),
    column(4, tags$h5(id = "bold", "Washington Pie chart"),
           plotOutput("washington_covid_sum", height = "200px"))
  ),
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
    California, Texas, New York, and Florida. With these visulizations we
    were also able to learn that Friday was the most common day for people
    in those top 10 states to get vaccinated."),
  fluidRow(
    column(6, tags$h5(id = "bold", "Vaccination Table"),
           tableOutput("vaccination_table_sum"))
  ),

  h2("Takeaway #3"),
  p("A final major takeaway comes from the Covid death percentages plots. As we
    can see, Africa has the highest death toll per cases out of all the
    continents. Although other continents, such as North America, may be
    yielding a higher number of deaths, their percentage is still lower. We
    also can see that the continent with the lowest average percentage
    of deaths per cases, is Asia. With this, what we can takeaway is that there
    are many factors such as accessibility to vaccines, that may affect the
    percentage of deaths. Not solely just the number of cases."),
  fluidRow(
    column(4, tags$h5(id = "bold", "Table of Covid deaths to cases
                      percentages"),
           tableOutput("covid_table_sum"))
  )
)

ui <- fluidPage(
  includeCSS("www/style.css"),
  navbarPage(
    "Project Covid",
    introduction_page,
    interactive_page_one,
    interactive_page_two,
    interactive_page_three,
    summary_page
  )
)