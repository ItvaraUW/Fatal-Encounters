library(dplyr)
library(ggplot2)
library(plotly)

# Creates a list of labels for whatever column name is chosen
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
    plot_ly(
      x = ~Date..Year.,
      y = ~n,
      text = ~paste0(
        "Year: ", Date..Year., "<br>Number Killed: ", n, "<br>",
        key[col_name], ": ", get(col_name)
      ),
      hoverinfo = 'text',
      group = ~get(col_name),
      type = "scatter", color = ~get(col_name),
      mode = "lines+markers"
    ) %>% 
    add_trace(
      type = "scatter",
      mode = "line",
      showlegend = F
    ) %>%
    layout(
      title = paste("Death Growth Rate by", key[col_name]),
      xaxis = list(title = "Year"),
      yaxis = list(title = "Number of Deaths")
    )
}