vaccinations_df <- read.csv("data/us_state_vaccinations.csv",
                            stringsAsFactors = FALSE)
library(dplyr)
library(ggplot2)
#Get day of week
updated_df <- vaccinations_df %>%
  mutate(day_name = weekdays(as.Date(date)))
#Condense df
condensed_df <- updated_df %>%
  select(daily_vaccinations, day_name)

#Condense more getting the sum of each day
new_condensed_df <- condensed_df %>%
  group_by(day_name) %>%
  summarise(vaccinations = sum(daily_vaccinations, na.rm = T))
#Sort by weekday
new_condensed_df$day_name <- factor(new_condensed_df$day_name,
                                levels = c("Monday", "Tuesday", "Wednesday",
                                           "Thursday", "Friday", "Saturday",
                                           "Sunday"))
#Bar plot
bar_plot <- ggplot(data = new_condensed_df) +
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
