# Orgainzed df with population, cases, and deaths
case_death_ratio_march <- function(df) {
  updated_df <- df %>%
    filter(continent != "", continent != "Oceania") %>% 
    select(continent, new_cases, new_deaths, date) %>% 
    filter(is.na(new_deaths) != TRUE & is.na(new_cases) != TRUE) %>% 
    filter(new_deaths >= 0 & new_cases >= 0) %>%
    filter(date >= as.POSIXct("2021-3-1") & date < as.POSIXct("2021-4-1")) %>% 
    group_by(continent, date) %>% 
    summarise(new_cases = sum(new_cases, na.rm = T),
              new_deaths = sum(new_deaths, na.rm = T),
              percentage = round(new_deaths/new_cases * 100, 1),
              .groups = 'drop') %>% 
    mutate(day = as.numeric(format(as.Date(date),"%d")))

  ggplot(data = updated_df) +
    geom_point(mapping = aes(x = day, y = percentage, color = continent)) +
    geom_smooth(mapping = aes(x = day, y = percentage, color = continent),
                method = 'lm',
                formula = y ~ splines::bs(x, 3),
                se = FALSE) +
    xlab("Day in March") +
    ylab("Percentage %") +
    ggtitle("Death/Cases Percentage in March 2021 by Continent") +
    labs(fill = "Continents") +
    scale_x_continuous(name ="Day in March", breaks=seq(1,31,3))
}
