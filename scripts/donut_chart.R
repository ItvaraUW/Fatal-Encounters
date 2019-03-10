library(dplyr)
library(plotly)


# Make an interactive donut chart that shows individuals within each group 
# that die to fatal encounters.

fatal_encounters_df <- read.csv("data/Fatal_Encouters_dataset.csv", 
                                stringsAsFactors = F,
                                na.strings = c("", "NA"))

donut_chart <- function(data_frame_num, variable = ""){
  fatal_encounters_df <- fatal_encounters_df[!(grepl(
    "2100", fatal_encounters_df$Date..Year.)),]
  
  data_frame_num <- transform(fatal_encounters_df, 
                              Date..Year. = as.numeric(Date..Year.),
                              Cause.of.death = as.character(Cause.of.death))
  
  data_for_graph <- data_frame_num %>%
    select(Unique.ID, Subject.s.age, Subject.s.gender, Subject.s.race, 
           Cause.of.death, Date..Year.) %>%
    rename(subject_gender = Subject.s.gender,
           subject_race = Subject.s.race,
           cause_of_death = Cause.of.death,
           year = Date..Year.)

  interactive_plot <- data_for_graph %>% 
    group_by(year) %>% 
    summarise(freq = length(year)) %>% 
    plot_ly(
      labels = ~year,
      values = ~freq,
      type = "pie",
      textinfo = 'percent',
      hoverinfo = 'text',
      text = ~paste(freq, year),
      hole = 0.6
    ) %>% 
    layout(
      title = "Total Police Fatal Encounter by",
      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    )
}