# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

##A function needs to be made to generate a map of the amount of deaths in each 
# state. It should be colored differently based on amount of deaths and hovering 
# over a state should provide the exact amount of deaths.

################################################################################
# States interactive map
################################################################################

source("../data/data.R")



library(dplyr)
library(ggplot2)

# library(plotly)
# library(leaflet)
# fatal_encounters_df

interactive_map <- FE_df %>%
  select(Location.of.death..state.) %>%
  rename(state = Location.of.death..state.) %>%
  group_by(state) %>%
  tally()

