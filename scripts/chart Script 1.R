bar_graph_df <- function(df) {
  # Updating the data frame so that it would work well with the bar plot
  updated_df <- df %>%
    mutate(day_name = weekdays(as.Date(date))) %>%
    # select(daily_vaccinations, day_name) %>%
    group_by(day_name) %>%
    summarise(vaccinations = sum(daily_vaccinations, na.rm = T))

  # Factor the date to make sure it is in the correct level.
  updated_df$day_name <- factor(updated_df$day_name,
                                      levels = c("Monday", "Tuesday",
                                                 "Wednesday", "Thursday",
                                                 "Friday", "Saturday",
                                                 "Sunday"))
  # Bar plot data
  ggplot(data = updated_df) +
    geom_col(mapping = aes(x = day_name, y = vaccinations, fill = day_name)) +
    scale_fill_manual(values = c("Monday" = "#FFFFB5",
                                 "Tuesday" = "#FF9161",
                                 "Wednesday" = "#FF6961",
                                 "Thursday" = "#ABDEE6",
                                 "Friday" = "#CCE2CB",
                                 "Saturday" = "#8FCACA",
                                 "Sunday" = "#FFB3BA"),
                      labels = c("Monday",
                                 "Tuesday",
                                 "Wednesday",
                                 "Thursday",
                                 "Friday",
                                 "Saturday",
                                 "Sunday")) +
    ggtitle("Vaccinations by Day of Week in the USA") +
    theme(plot.title = element_text(hjust = 0.5)) +
    xlab("Day Name") +
    ylab("Occurences") +
    labs(fill = "Occurences")
}
