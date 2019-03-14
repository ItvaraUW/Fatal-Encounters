# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

library(dplyr)
library(maps)
library(leaflet)

# Generates a map of deaths in each state
make_map <- function(profile) {
  state_poly <- map("state", fill = T, plot = F)
  labels <- paste("Total Incidents: ", nrow(profile))

  points_map <- profile %>%
    leaflet(options = leafletOptions(
      dragging = T,
      minZoom = 4,
      maxZoom = 10
    )) %>%
    addProviderTiles("CartoDB.Positron") %>%
    addPolygons(
      lng = state_poly$x,
      lat = state_poly$y,
      color = "white", weight = 1, smoothFactor = 0.5,
      stroke = T,
      label = labels,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")
    ) %>%
    addCircleMarkers(
      lat = ~Latitude, lng = ~Longitude,
      label = ~paste0("(", date, ") ", city, ", ", state),
      radius = 1
    ) %>%
    setView(lat = 39.8282, lng = -98.5795, zoom = 4) ## middle US
}
