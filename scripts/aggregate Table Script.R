# Create a aggregate table to summarize the top ten county of the most cases
# within the state Washington.
summary_df <- function(df) {
  df %>%
    group_by(County) %>%
    summarise(
      cases = sum(ConfirmedCases, na.rm = T),
      Age.0.19 = sum(Age.0.19, na.rm = T),
      Age.20.34 = sum(Age.20.34, na.rm = T),
      Age.35.49 = sum(Age.35.49, na.rm = T),
      Age.50.64 = sum(Age.50.64, na.rm = T),
      Age.65.79 = sum(Age.65.79, na.rm = T),
      Age.80. = sum(Age.80., na.rm = T),
    ) %>%
    arrange(-cases) %>%
    top_n(10, cases)
}
