# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

## A function needs to be made to generate a map of deaths in each state

################################################################################
# States interactive map
################################################################################

library(dplyr)
library(maps)
library(leaflet)

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
    addCircleMarkers(
      lat = ~Latitude, lng = ~Longitude,
      label = ~paste(name, date, sep = " - "), radius = 1
    ) %>%
    addPolygons(
      lng = state_poly$x,
      lat = state_poly$y,
      color = "white", weight = 1, smoothFactor = 0.5,
      fillColor = rainbow(30, alpha = NULL),
      stroke = T,
    
      label = labels,
      labelOptions = labelOptions(
        style = list("font-weight" = "normal", padding = "3px 8px"),
        textsize = "15px",
        direction = "auto")
    ) %>%
    setView(lat = 39.8282, lng = -98.5795, zoom = 4) ## middle US
}