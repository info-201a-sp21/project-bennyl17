WA_df <- read.csv("data/WA_COVID19_Cases.csv", stringsAsFactors = FALSE)

summary_df <- WA_df %>%
  filter(ConfirmedCases > 2500) %>%
  select(County, WeekStartDate, ConfirmedCases, Age.0.19, Age.20.34, Age.35.49, 
         Age.50.64, Age.65.79, Age.80.)
