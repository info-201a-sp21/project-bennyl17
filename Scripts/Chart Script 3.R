Covid_WA_df <- read.csv("data/WA_COVID19_Cases.csv",
                            stringsAsFactors = FALSE)
library(dplyr)
library(ggplot2)

condensed_df <- Covid_WA_df[ , 6:12]

timeseries <- ggplot(Covid_WA_df, aes(x = Covid_WA_df[ , 6:12])) + 
  geom_line(aes(y = ))


age0_19 <- sum(Covid_WA_df$Age.0.19, na.rm = T)
age20_34 <- sum(Covid_WA_df$Age.20.34, na.rm = T)
age35_49 <- sum(Covid_WA_df$Age.35.49, na.rm = T)
age50_64 <- sum(Covid_WA_df$Age.50.64, na.rm = T)
age65_79 <- sum(Covid_WA_df$Age.65.79, na.rm = T)
age80_up <- sum(Covid_WA_df$Age.80., na.rm = T)
unknown_age <- sum(Covid_WA_df$UnknownAge, na.rm = T))
