library(dplyr)
library(plotly)

# Make an interactive donut chart that shows individuals within each group 
# that was killed to fatal encounters.

donut_chart <- function(data_frame, sym_factor, factor){
  data_for_graph <- data_frame %>%
    mutate(
      Subject.s.gender = replace(Subject.s.gender,
                                 Subject.s.gender == "Femalr", "Female"),
      Subject.s.gender = replace(Subject.s.gender,
                                 Subject.s.gender == "White", NA)) %>% 
    select(Subject.s.gender, Subject.s.race, 
           Cause.of.death, Date..Year.) %>%
    rename(gender = Subject.s.gender,
           race = Subject.s.race,
           cause = Cause.of.death,
           year = Date..Year.)

  interactive_plot <- data_for_graph %>% 
    group_by(!!sym_factor) %>% 
    summarise(freq = length(!!sym_factor)) %>% 
    filter(!(is.na(!!sym_factor))) %>% 
    plot_ly(
      labels = ~eval(parse(text = factor)),
      values = ~freq,
      type = "pie",
      textinfo = 'percent',
      hoverinfo = 'text',
      text = ~paste(freq, eval(parse(text = factor))),
      hole = 0.6
    ) %>% 
    layout(
      title = paste("Total Police Fatal Encounter by ",
                    toupper(substr(factor, 1, 1)), 
                    substring(factor, 2), sep = ""),
      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    )
}