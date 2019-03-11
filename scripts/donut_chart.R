library(dplyr)
library(plotly)
source(data/data.R)

# Make an interactive donut chart that shows individuals within each group 
# that was killed to fatal encounters.

donut_chart <- function(data_frame_num, variable){
  data_for_graph <- data_frame_num %>%
    select(Subject.s.gender, Subject.s.race, 
           Cause.of.death, Date..Year.) %>%
    rename(subject_gender = Subject.s.gender,
           subject_race = Subject.s.race,
           cause_of_death = Cause.of.death,
           year = Date..Year.)

  interactive_plot <- data_for_graph %>% 
    group_by(variable) %>% 
    summarise(freq = length(variable)) %>% 
    plot_ly(
      labels = ~variable,
      values = ~freq,
      type = "pie",
      textinfo = 'percent',
      hoverinfo = 'text',
      text = ~paste(freq, variable),
      hole = 0.6
    ) %>% 
    layout(
      title = paste("Total Police Fatal Encounter by", variable),
      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    )
}