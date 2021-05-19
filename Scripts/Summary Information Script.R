##In the united states
summary_information <- function(df) {
  result <- list()

  #total number of cases since 2020-01-22
  result$cases <- df %>%
    filter(location == "United States") %>%
    select(new_cases) %>%
    sum(na.rm = TRUE)

  #total number of death since 2020-01-22
  result$deaths <- df %>%
    filter(location == "United States") %>%
    select(new_deaths) %>%
    sum(na.rm = TRUE)

  #total number of vaccinations since 2020-01-22
  result$vaccination <- df %>%
    filter(location == "United States") %>%
    select(new_vaccinations) %>%
    sum(na.rm = TRUE)

  #total number of test
  result$tests <- df %>%
    filter(location == "United States") %>%
    select(new_tests) %>%
    sum(na.rm = TRUE)

  #Average positive testing rate
  total_rates <- df %>%
    filter(location == "United States") %>%
    select(positive_rate)
  result$positive_rate <- round(mean(total_rates$positive_rate, na.rm = T)
                                * 100, 1)

  return(result)
}
