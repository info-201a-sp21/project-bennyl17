# Need comments
pie_chart_df <- function(df) {
  updated_df <- df %>%
    summarise(age0_19 = sum(df$Age.0.19, na.rm = T),
              age20_34 = sum(df$Age.20.34, na.rm = T),
              age35_49 = sum(df$Age.35.49, na.rm = T),
              age50_64 = sum(df$Age.50.64, na.rm = T),
              age65_79 = sum(df$Age.65.79, na.rm = T),
              age80_up = sum(df$Age.80., na.rm = T)) %>%
    gather("Age", "sum_of_cases") %>%
    arrange(desc(Age)) %>%
    mutate(prop = sum_of_cases / sum(sum_of_cases) * 100) %>%
    mutate(ypos = cumsum(prop) - 0.5 * prop)

  ggplot(data = updated_df, aes(x = factor(1), y = prop, fill = Age)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y", start = 180) +
    ggtitle("Cases by Age group in Washington") +
    theme_void() +
    geom_text(aes(y = ypos, label = sum_of_cases), color = "black", size = 3) +
    scale_fill_discrete(name = "Ages",
                        labels = c("Age 0 to 19",
                                   "Age 20 to 34",
                                   "Age 35 to 49",
                                   "Age 50 to 64",
                                   "Age 65 to 79",
                                   "Age 80+"))
}