# title: "INFO&201: Final Project"
# subtitle: "Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

library(shiny)
library(dplyr)

source("data/data.R")
source("scripts/death_growth_rate.R")
source("scripts/donut_chart.R")
source("scripts/state_deaths_map.R")

shinyServer(function(input, output) {

  # Renders a map showing distribution of fatalities across specified areas.
  # Filtering of data is done here to ensure the error is correctly thrown.
  output$map <- renderLeaflet({
    profile <- FE_df %>%
      rename(
        name = Subject.s.name,
        gender = Subject.s.gender,
        race = Subject.s.race,
        state = Location.of.death..state.,
        city = Location.of.death..city.,
        date = Date.of.injury.resulting.in.death..month.day.year.,
        year = Date..Year.
      ) %>%
      select(name, gender, race, state, city, date, Longitude, Latitude, year) %>%
      filter(if (input$state_in == "all") T
             else state == input$state_in) %>%
      filter(if (input$gender_in == "all") T
             else gender == input$gender_in) %>%
      filter(if (input$race_in == "all") T
             else race == input$race_in) %>%
      filter(year >= input$year_in[1]) %>%
      filter(year <= input$year_in[2])

    # If there is no data under specification,
    # throws an error replacement message.
    validate(
      need(nrow(profile) != 0, "Data not found for that specification.")
    )

    make_map(profile)
  })

  # Renders a graphic detailing growth rate by gender.
  output$gender_plot <- renderPlotly({
    death_rate_growth(FE_df,
                      input$gender_choices,
                      col_name = "Subject.s.gender")
  })

  # Renders a graphic detailing growth rate by cause.
  output$cause_plot <- renderPlotly({
    death_rate_growth(FE_df,
                      input$cause_choices,
                      col_name = "Cause.of.death")
  })

  # Renders a donut chart sorted by the inputed factor.
  output$donut_chart <- renderPlotly({
    donut_chart(FE_df,
                sym(input$factor),
                input$factor)
  })
})