# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"
library(shiny)
library(shinythemes)
library(plotly)
library(leaflet)

genders <- list(
  "Male" = "Male",
  "Female" = "Female",
  "Transgender" = "Transgender",
  "Transexual" = "Transexual"
)

causes <- list(
  "Asphyxiated/Restrained" = "Asphyxiated/Restrained",
  "Beaten/Bludgeoned with instrument" = "Beaten/Bludgeoned with instrument",
  "Burned/Smoke inhalation" = "Burned/Smoke inhalation",
  "Chemical agent/Pepper spray" = "Chemical agent/Pepper spray",
  "Drowned" = "Drowned",
  "Drug overdose" = "Drug overdose",
  "Fell from a height" = "Fell from a height",
  "Gunshot" = "Gunshot",
  "Medical emergency" = "Medical emergency",
  "Stabbed" = "Stabbed",
  "Tasered" = "Tasered",
  "Undetermined" = "Undetermined",
  "Vehicle" = "Vehicle",
  "Other" = "Other"
)

races <- list(
  "African-American/Black" = "African-American/Black",
  "Asian/Pacific Islander" = "Asian/Pacific Islander",
  "European-American/White" = "European-American/White",
  "Hispanic/Latino" = "Hispanic/Latino",
  "Middle Eastern" = "Middle Eastern",
  "Native American/Alaskan" = "Native American/Alaskan",
  "Race unspecified" = "Race unspecified"
)

factors <- list(
  "Race" = "race",
  "Gender" = "gender",
  "Cause of Death" = "cause",
  "Year" = "year"
)

shinyUI(
  navbarPage(
    title = "Fatal Encounters",
    theme = shinytheme("journal"),
    
    tabPanel(
      title = "About this project",
      mainPanel(
        p("Placeholder")
      )
    ),
    
    tabPanel(
      title = "Growth Rate by Gender and Cause",
      sidebarLayout(
        sidebarPanel(
          checkboxGroupInput(
            inputId = "gender_choices",
            label = "Gender Options:",
            choices = genders
          ),
          checkboxGroupInput(
            inputId = "cause_choices",
            label = "Cause Options:",
            choices = causes
          )
        ),
        mainPanel(
          plotOutput("gender_plot"),
          plotOutput("cause_plot")
        )
      )
    ),
    
    tabPanel(
      title = "Distrubution by State",
      sidebarLayout(
        sidebarPanel(
          textInput(
            inputId = "state_in",
            label = "State",
            value = "WA"
          ),
          radioButtons(
            inputId = "gender_in",
            label = "Gender",
            choices = genders
          ),
          selectInput(
            inputId = "race_in",
            label = "Race",
            choices = races,
            selected = c(1)
          ),
          sliderInput(
            inputId = "year_in",
            label = "Year",
            min = 2000,
            max = 2019,
            value = 2019
          )
        ),
        mainPanel(
          leafletOutput("map")
        )
      )
    ),
    
    tabPanel(
      title = "Factors of Impact",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "factor",
            label = "Sort by:",
            choices = factors,
            selected = "race"
          )
        ),
        mainPanel(
          plotlyOutput("donut_chart")
        )
      )
    ),
    
    tabPanel(
      title = "Final Wrap Up and Conclusion",
      mainPanel(
        p("Placeholder")
      )
    )
  )
)
  