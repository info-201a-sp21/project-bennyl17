introduction_page <- tabPanel(
  "Covid-19 Overview",
  h1("Introduction of Covid-19"),
  p("This is an introductory page into our shiny application...")
)

interactive_page_one <- tabPanel(
  "Covid-19 Map",
  h1("")
)

interactive_page_two <- tabPanel(
  "title"
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
