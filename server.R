library(shiny)
library(dplyr)

source("data/data.R")
source("scripts/death_growth_rate.R")
source("scripts/donut_chart.R")
source("scripts/state_deaths_map.R")

shinyServer(function(input, output) {
  output$gender_plot <- renderPlotly({
    death_rate_growth(FE_df,
                      input$gender_choices,
                      col_name = "Subject.s.gender")
  })
  
  output$cause_plot <- renderPlotly({
    death_rate_growth(FE_df,
                      input$cause_choices,
                      col_name = "Cause.of.death")
  })
  
  output$map <- renderLeaflet({
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
      filter(if (input$state_in == "all") T else state == input$state_in) %>%
      filter(if (input$gender_in == "all") T else gender == input$gender_in) %>%
      filter(if (input$race_in == "all") T else race == input$race_in) %>%
      filter(year == input$year_in)
    
    validate(
      need(nrow(profile) != 0, "Data not found for that specification.")
    )
    
    make_map(profile)
  })
  
  output$donut_chart <- renderPlotly({
    donut_chart(FE_df,
                sym(input$factor),
                input$factor)
  })
})