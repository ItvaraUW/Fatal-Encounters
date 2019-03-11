# title: "INFO&201: Final Project"
# subtitle: "On Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"
library(shiny)
library(shinythemes)
library(plotly)

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
        h1("Project Description"),
        h2("Data Set"),
        p("The data set we’re working with is called “Fatal Encounters”. 
          This database consists of information of civilian interactions with 
          the police and resulting in the death of a civilian - 
          in the United States of America since January 1st 2000."),
        p("The founding director of this dataset was a journalist called 
          D. Brian Burghart. He’s a former editor and publisher of Reno News 
          and Review, and a journalism instructor at the University of Nevada, 
          Reno."),
        p("The way they collect data is from data sets like KilledByPolice.net 
          or Los Angeles Time’s The Homicide Report. They then continue to 
          do further research on any information they may have missed or 
          from reports by volunteers. After that, they start to verify it
          against published source by their paid Principal Investigator. 
          The verification of data are all compared to published media reports
          or public records."),
        p("The dataset can be found through ",
          a("Fatal Encounter Datasheet", 
            href = "https://docs.google.com/spreadsheets/d/1dKmaV_JiWcG8XBoRgP8b4e9Eopkpgt7FL7nyspvzAsE/edit#gid=0"
            )
          )
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
          p("Options here")
        ),
        mainPanel(
          p("Graph here")
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
  