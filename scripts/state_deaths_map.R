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

# source("../data/data.R")

FE_df <- read.csv("../data/Fatal_Encounters_data.csv", stringsAsFactors = F)

library(dplyr)
library(tidyverse)
library(maps)

# library(plotly)
library(leaflet)
# fatal_encounters_df

# library(ggmaps)
# geocode()


state_deaths <- FE_df %>%
  select(Subject.s.name, Subject.s.gender, Location.of.death..state., Longitude, Latitude) %>%
  rename(name = Subject.s.name, gender = Subject.s.gender, state = Location.of.death..state., long = Longitude, lat = Latitude) %>%
  filter(state %in% state.abb)
  # group_by(state) %>%
  # count() %>%
  
points_map <- state_deaths %>% 
  leaflet(options = leafletOptions(dragging = FALSE,
                           minZoom = 3,
                           maxZoom = 5))  %>%
  addProviderTiles("CartoDB.Positron")  %>%
  addCircleMarkers(lat = ~lat,    # specifying the column to use for latitude
                      lng = ~long, label = ~paste0(name, "<br>", "(line)"), radius = 1) %>%
  setView(lat = 39.8282, lng = -98.5795, zoom = 4) ## middle US


choropleth_map <- map_data("state") %>% # load state shapefile
  rename(state = region) %>% # rename for joining
  left_join(state_deaths, by="state") # join eviction data

# Draw the map setting the `fill` of each state using its eviction rate
ggplot(choropleth_map) +
  geom_polygon(
    mapping = aes(x = long.x, y = lat.x, group = group, fill = sum()),
    color = "white", # show state outlines
    size = .001        # thinly stroked
  ) +
  coord_map() + # use a map-based coordinate system
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(fill = "Legend")
  
# palette <- colorBin(c('#fee0d2',  #an example color scheme. you can substitute your own colors
#                       '#fcbba1',
#                       '#fc9272',
#                       '#fb6a4a',
#                       '#ef3b2c',
#                       '#cb181d',
#                       '#a50f15',
#                       '#67000d'), 
#                     bins = c(0, 5, 8, 10, 12, 14, 18, 24, 26))
# 
#
mymap <- leaflet() %>%
  addProviderTiles("CartoDB.Positron",
                   options = tileOptions(minZoom=10, maxZoom=16)) %>%
addPolygons(data = choropleth_map,
              ## we want the polygon filled with
            ## one of the palette-colors
            ## according to the value in student1$Anteil
            fillOpacity = 0.6,         ## how transparent do you want the polygon to be?
            color = "darkgrey",       ## color of borders between districts
            weight = 1.5,            ## width of borders
            popup = "almond",         ## which popup?
            group = group)


