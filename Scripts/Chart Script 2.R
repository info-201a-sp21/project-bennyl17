# Orgainzed df with population, cases, and deaths
covid_case_to_death_ratio <- function(df) {
  deaths_by_country <- df %>%
    filter(continent != "", continent != "Oceania") %>% 
    select(continent, new_cases, new_deaths, date) %>% 
    filter(is.na(new_deaths) != TRUE & is.na(new_cases) != TRUE) %>% 
    filter(new_deaths >= 0 & new_cases >= 0) %>%
    filter(date >= as.POSIXct("2021-3-1") & date <= as.POSIXct("2021-4-1")) %>% 
    group_by(continent, date) %>% 
    summarise(new_cases = sum(new_cases, na.rm = T),
              new_deaths = sum(new_deaths, na.rm = T),
              .groups = 'drop')

  ggplot(data = deaths_by_country) +
    geom_point(mapping = aes(x = new_cases, y = new_deaths, color = continent)) +
    xlab("Cases") +
    ylab("Deaths") +
    ggtitle("Each Continent Cases versus Deaths by Day in March 2021") +
    labs(fill = "Continents")
}

covid_case_to_death_ratio(covid_df)
