# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

## A function needs to be made to generate a map of deaths in each state

################################################################################
# States interactive map
################################################################################

library(dplyr)
library(leaflet)

make_map <- function(FE_df, state_p, gender_p, race_p, year_p) {
  profile <- FE_df %>%
    rename(
      name = Subject.s.name,
      gender = Subject.s.gender,
      race = Subject.s.race,
      state = Location.of.death..state.,
      date = Date.of.injury.resulting.in.death..month.day.year.,
      year = Date..Year.
    ) %>%
    select(name, gender, race, state, date, Longitude, Latitude, year) %>%
    filter(if (state_p == "all") T else state == state_p) %>%
    filter(if (gender_p == "all") T else gender == gender_p) %>%
    filter(if (race_p == "all") T else race == race_p) %>%
    filter(year == year_p)

  state_poly <- map("state", fill = T, plot = F)
  points_map <- profile %>%
    leaflet(options = leafletOptions(
      dragging = T,
      minZoom = 2,
      maxZoom = 10
    )) %>%
    addProviderTiles("CartoDB.Positron") %>%
    addCircleMarkers(
      lat = ~Latitude, lng = ~Longitude,
      label = ~paste(name, date, sep = " - "), radius = 1
    ) %>%
    addPolygons(
      lng = state_poly$x,
      lat = state_poly$y,
      fillColor = rainbow(30, alpha = NULL),
      stroke = F
    )
}