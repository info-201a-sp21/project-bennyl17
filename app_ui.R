ui <- navbarPage(
  "Covid Project",
  introduction_page,
  interactive_page_one,
  interactive_page_two,
  interactive_page_three,
  summary_page
)

home_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction of Covid-19"),
  p("This is an introductory page into our shiny application...")
)

interactive_page_one <- tabPanel(
  
)

interactive_page_two <- tabPanel(
)

interactive_page_three <- tabPanel(
)

summary_page <- tabPanel(
)