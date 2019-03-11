# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

## A function needs to be made to generate a map of deaths in each state

################################################################################
# States interactive map
################################################################################

library(dplyr) # includes: ggplot2 dplyr tidyr stringr
library(leaflet)

make_map <- function(FE_df) {
  profile <- FE_df %>%
    rename(
      name = Subject.s.name,
      age = Subject.s.age,
      gender = Subject.s.gender,
      race = Subject.s.race,
      state = Location.of.death..state.,
      date = Date.of.injury.resulting.in.death..month.day.year.,
      year = Date..Year.
    ) %>%
    select(name, age, gender, race, state, date, Longitude, Latitude, year) %>%
    filter(state %in% state.abb) %>%
    filter(state == input$state_in) %>%
    filter(age == input$age_in & gender == input$gender_in &
      race == input$race_in | year == input$year_in)
  points_map <- profile %>%
    leaflet(options = leafletOptions(
      dragging = F,
      minZoom = 5,
      maxZoom = 10
    )) %>%
    addProviderTiles("CartoDB.Positron") %>%
    addCircleMarkers(
      lat = ~Latitude, lng = ~Longitude,
      label = ~paste(name, date, sep = " - "), radius = 2
    )
}
