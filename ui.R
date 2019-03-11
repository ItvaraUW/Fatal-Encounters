# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"
library(shiny)
library(shinythemes)

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
shinyUI(
  navbarPage(
    "Fatal Encounters",
    theme = shinytheme("journal"),
    
    tabPanel(
      "About this project",
      mainPanel(
        p("Placeholder")
      )
    ),
    
    tabPanel(
      "Growth Rate by Gender and Cause",
      sidebarLayout(
        sidebarPanel(
          checkboxGroupInput(
            "gender_choices",
            "Gender Options:",
            genders
          ),
          checkboxGroupInput(
            "cause_choices",
            "Cause Options:",
            causes
          )
        ),
        mainPanel(
          plotOutput("gender_plot"),
          plotOutput("cause_plot")
        )
      )
    ),
    
    tabPanel(
      "Distrubution by State",
      sidebarLayout(
        sidebarPanel(
          p("Options here")
        ),
        mainPanel(
          p("Graph here")
        )
      )
    ),
    
    tabPanel(
      "Factors of Impact",
      sidebarLayout(
        sidebarPanel(
          p("Options here")
        ),
        mainPanel(
          p("Graph here")
        )
      )
    ),
    
    tabPanel(
      "Final Wrap Up and Conclusion",
      mainPanel(
        p("Placeholder")
      )
    )
  )
)
  