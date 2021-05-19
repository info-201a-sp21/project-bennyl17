library(dplyr)
library(ggplot2)
library(leaflet)
library(plotly)


covid_deaths <- read.csv("./data/owid-covid-data.csv", stringsAsFactors = FALSE)

# Orgainzed df with population, cases, and deaths
deaths_by_country <- covid_deaths %>%
  filter(location != "World", location != "Asia", location != "North America",
         location != "Europe", location != "South America", location != "European Union", location != "International") %>%
  group_by(location) %>%
  summarize(total_population = mean(population, na.rm = TRUE),
            total_covid_cases = sum(new_cases, na.rm = TRUE),
            total_covid_deaths = sum(new_deaths, na.rm = TRUE)) %>%
  arrange(desc(total_population)) %>%
  arrange(desc(total_covid_cases)) %>%
  arrange(desc(total_covid_deaths))
  


ggplot(data = deaths_by_country) +
  geom_point(mapping = aes(x = total_covid_deaths, y = total_covid_cases)) +
  xlab("Deaths") +
  ylab("Cases") +
  ggtitle("Total Deaths Compares to Total Cases by Country")

