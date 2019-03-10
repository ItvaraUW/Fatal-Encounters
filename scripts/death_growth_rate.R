library(dplyr)
library(ggplot2)

# Creates a list of labels for whichever column name is chosen
# for the function
key <- list(
  Subject.s.gender = "Gender",
  Cause.of.death = "Cause of Death"
)

# Creates a line graph of the categories given by the user
# and is plotted by years and number of deaths
death_rate_growth <- function(data_frame, ..., col_name) {
  data_frame %>%
    filter(get(col_name) %in% c(...)) %>%
    group_by_(col_name, "Date..Year.") %>%
    count() %>%
    ggplot(aes(x = Date..Year., y = n, color = get(col_name))) +
    geom_line() +
    geom_point() +
    labs(
      title = "Death Growth Rate",
      x = "Year",
      y = "Number of Deaths",
      color = key[col_name]
    )
}