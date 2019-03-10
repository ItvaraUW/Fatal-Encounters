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

# library(dplyr)
library(tidyverse)
# library(maps)
library(leaflet)

profile <- FE_df[!(grepl(
  "2100", FE_df$Date..Year.)),] %>%
  rename(
    name = Subject.s.name,
    age = Subject.s.age,
    gender = Subject.s.gender,
    race = Subject.s.race,
    date = Date.of.injury.resulting.in.death..month.day.year.,
    long = Longitude,
    lat = Latitude,
    year = Date..Year.) %>%
  select(name, age, gender, race, date, long, lat, year) %>%
  filter(age == input$age_in | gender == input$gender_in |
         race == input$race_in | year == input$year_in)
  # filter(age == 24 | gender == "Female" |
  #        race == "Race unspecified" | year == 2000)
  
points_map <- profile %>%
  leaflet(options = leafletOptions(dragging = FALSE,
                           minZoom = 3,
                           maxZoom = 5))  %>%
  addProviderTiles("CartoDB.Positron")  %>%
  addCircleMarkers(lat = ~lat, lng = ~long,
             label = ~paste(name, date, sep = " | "), radius = 1) %>%
  setView(lat = 39.8282, lng = -98.5795, zoom = 4) ## middle US

# choropleth_map <- map_data("state") %>% # load state shapefile
#   rename(state = region) %>% # rename for joining
#   left_join(state_deaths, by="state") # join eviction data
# 
# # Draw the map setting the `fill` of each state using its eviction rate
# ggplot(choropleth_map) +
#   geom_polygon(
#     mapping = aes(x = long.x, y = lat.x, group = group, fill = sum()),
#     color = "white", # show state outlines
#     size = .001        # thinly stroked
#   ) +
#   coord_map() + # use a map-based coordinate system
#   scale_fill_continuous(low = "#132B43", high = "Red") +
#   labs(fill = "Legend")
  
# mymap <- leaflet() %>%
#   addProviderTiles("CartoDB.Positron",
#                    options = tileOptions(minZoom=10, maxZoom=16)) %>%
# addPolygons(data = choropleth_map,
#             ##polygon filled with
#             fillOpacity = 0.6,         ## how transparent do you want the polygon to be?
#             color = "darkgrey",       ## color of borders between districts
#             weight = 1.5,            ## width of borders
#             popup = "almond",         ## which popup?
#             group = group)


