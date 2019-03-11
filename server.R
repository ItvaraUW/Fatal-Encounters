library(shiny)

source("data/data.R")
source("scripts/death_growth_rate.R")
source("scripts/donut_chart.R")
#source("scripts/state_deaths_map.R")

shinyServer(function(input, output) {
  output$gender_plot <- renderPlot({
    death_rate_growth(FE_df, input$gender_choices, col_name = "Subject.s.gender")
  })
  
  output$cause_plot <- renderPlot({
    death_rate_growth(FE_df, input$cause_choices, col_name = "Cause.of.death")
  })
})