df <- read.csv("data/WA_COVID19_Cases.csv",
               stringsAsFactors = FALSE)
library(dplyr)
library(ggplot2)
#variables
age0_19 <- sum(df$Age.0.19, na.rm = T)
age20_34 <- sum(df$Age.20.34, na.rm = T)
age35_49 <- sum(df$Age.35.49, na.rm = T)
age50_64 <- sum(df$Age.50.64, na.rm = T)
age65_79 <- sum(df$Age.65.79, na.rm = T)
age80_up <- sum(df$Age.80., na.rm = T)
#new dataframe
age <- c("Ages 0-19", "Ages 20-34", "Ages 35-49", "Ages 50-64",
         "Ages 65-79", "Ages 80+")
sum_of_cases <- c(age0_19, age20_34, age35_49, age50_64, age65_79, age80_up)
new_df <- data.frame(sum_of_cases, age)



#pie chart
new_df <- new_df %>%
  arrange(desc(age)) %>%
  mutate(prop = sum_of_cases / sum(new_df$sum_of_cases) * 100) %>%
  mutate(ypos = cumsum(prop) - 0.5 * prop)



pie_chart <- ggplot(new_df, aes(x = "", y = prop, fill = age)) +
  geom_bar(stat = "identity", width = 1, color = "black") +
  coord_polar("y", start = 0) +
  ggtitle("Cases by Age group in Washington") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme_void() +
  geom_text(aes(y = ypos, label = sum_of_cases), color = "black", size = 3) +
  coord_polar("y", start = 180)