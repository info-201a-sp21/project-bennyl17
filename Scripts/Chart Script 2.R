# Orgainzed df with population, cases, and deaths
covid_case_to_death_ratio <- function(df) {
  deaths_by_country <- df %>%
    filter(continent != "")

  ggplot(data = deaths_by_country) +
    geom_point(mapping = aes(x = new_cases, y = new_deaths, color = continent)) +
    xlab("Cases") +
    ylab("Deaths") +
    ggtitle("Total Cases Compared to Total Deaths by Continent")
}