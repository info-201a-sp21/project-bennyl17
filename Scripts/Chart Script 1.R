library(dplyr)
library(ggplot2)
#Get day of week 
updated_df <- vaccinations_df %>%
  mutate(day_name = weekdays(as.Date(date)))
#Condense df
condensed_df <- updated_df %>%
  select(new_vaccinations, day_name)

new_condensed_df <- condensed_df %>% 
  group_by(day_name) %>% 
  summarise(vaccinations = sum(new_vaccinations, na.rm = T))

bar_plot <- ggplot(data = new_condensed_df) + 
  geom_col(mapping = aes(x = vaccinations)) + 
  scale_fill_manual(values = c("Monday" = "Red",
                               "Tuesday" = "Red4",
                               "Wednesday" = "Red4",
                               "Thursday" = "Red4",
                               "Friday" = "Red4",
                               "Saturday" = "Red4",
                               "Sunday" = "Red"), 
                    labels = c("",
                               "",
                               "",
                               "",
                               "",
                               "",
                               "")) +
  ggtitle("Vaccinations by Day of Week") +
  theme(plot.title = element_text(hjust = 0.5)) +
  xlab("Day Name") +
  ylab("Occurences") +
  labs(fill = "Occurences")



bar_plot

#Sort the x-axis by day of week
condensed_df$day_name <- factor(updated_df$day_name, 
                                levels = c("Monday", "Tuesday", "Wednesday",
                                           "Thursday", "Friday", "Saturday",
                                           "Sunday"))