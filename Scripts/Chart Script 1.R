bar_graph_df <- function(df) {
  #Get day of week
  updated_df <- df %>%
    mutate(day_name = weekdays(as.Date(date))) %>%
    select(daily_vaccinations, day_name) %>%
    group_by(day_name) %>%
    summarise(vaccinations = sum(daily_vaccinations, na.rm = T))
    
  updated_df$day_name <- factor(updated_df$day_name,
                                      levels = c("Monday", "Tuesday",
                                                 "Wednesday", "Thursday",
                                                 "Friday", "Saturday",
                                                 "Sunday"))
  #Bar plot
  ggplot(data = updated_df) +
    geom_col(mapping = aes(x = day_name, y = vaccinations, fill = day_name)) +
    scale_fill_manual(values = c("Monday" = "yellow",
                                 "Tuesday" = "orange",
                                 "Wednesday" = "red",
                                 "Thursday" = "blue",
                                 "Friday" = "green",
                                 "Saturday" = "white",
                                 "Sunday" = "grey"),
                      labels = c("Monday",
                                 "Tuesday",
                                 "Wednesday",
                                 "Thursday",
                                 "Friday",
                                 "Saturday",
                                 "Sunday")) +
    ggtitle("Vaccinations by Day of Week") +
    theme(plot.title = element_text(hjust = 0.5)) +
    xlab("Day Name") +
    ylab("Occurences") +
    labs(fill = "Occurences")
}
