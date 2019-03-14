# title: "INFO&201: Final Project"
# subtitle: "Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

library(shiny)
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
  "All Races" = "all",
  "African-American/Black" = "African-American/Black",
  "Asian/Pacific Islander" = "Asian/Pacific Islander",
  "European-American/White" = "European-American/White",
  "Hispanic/Latino" = "Hispanic/Latino",
  "Middle Eastern" = "Middle Eastern",
  "Native American/Alaskan" = "Native American/Alaskan",
  "Race unspecified" = "Race unspecified"
)

states <- list(
  "United States" = "all",
  "Alabama" = "AL",
  "Alaska" = "AK",
  "Arizona" = "AZ",
  "Arkansas" = "AR",
  "California" = "CA",
  "Colorado" = "CO",
  "Connecticut" = "CT",
  "Delaware" = "DE",
  "Florida" = "FL",
  "Georgia" = "GA",
  "Hawaii" = "HI",
  "Idaho" = "ID",
  "Illinois" = "IL",
  "Indiana" = "IN",
  "Iowa" = "IA",
  "Kansas" = "KS",
  "Kentucky" = "KY",
  "Louisiana" = "LA",
  "Maine" = "ME",
  "Maryland" = "MD",
  "Massachusetts" = "MA",
  "Michigan" = "MI",
  "Minnesota" = "MN",
  "Mississippi" = "MS",
  "Missouri" = "MO",
  "Montana" = "MT",
  "Nebraska" = "NE",
  "Nevada" = "NV",
  "New Hampshire" = "NH",
  "New Jersey" = "NJ",
  "New Mexico" = "NM",
  "New York" = "NY",
  "North Carolina" = "NC",
  "North Dakota" = "ND",
  "Ohio" = "OH",
  "Oklahoma" = "OK",
  "Oregon" = "OR",
  "Pennsylvania" = "PA",
  "Rhode Island" = "RI",
  "South Carolina" = "SC",
  "South Dakota" = "SD",
  "Tennessee" = "TN",
  "Texas" = "TX",
  "Utah" = "UT",
  "Vermont" = "VT",
  "Virginia" = "VA",
  "Washington" = "WA",
  "West Virginia" = "WV",
  "Wisconsin" = "WI",
  "Wyoming" = "WY"
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
    theme = "style.css",
    
    # Project Description Tab
    tabPanel(
      title = "Project Description",
      mainPanel(
        h1("Our Purpose"),
        p("The purpose for this project was to spread awareness of police
          brutality. It is a growing problem in the U.S. that has received
          a lot of attention in the recent years. Despite the attention it
          gets, however, the amount of deaths continue to grow. That is why
          we have created visualizations of death records related to police
          brutality. They were made to visualize possible patterns in how
          these events happen. However, we want to make it clear that
          the correlations found are not 100% the causation. It is only
          made to inform the public of past records so that they may make
          informed decisions based on such information"),
        h1("Data Set"),
        p("The data set we’re working with is called “Fatal Encounters”. 
          This database consists of information of civilian interactions with 
          the police that resulted in the death of that civilian. The database 
          has recorded data of these encounters in the United States of America 
          since January 1st 2000."),
        p("The founding director of this dataset was a journalist called 
          D. Brian Burghart. He’s a former editor and publisher of Reno News 
          and Review, and a journalism instructor at the University of Nevada, 
          Reno."),
        p("The way they collect data is from data sets like KilledByPolice.net 
          or Los Angeles Time’s “The Homicide Report“. They then continue 
          to do further research on any information they may have missed or 
          receive information from reports by volunteers. After that, it is
          verified against published sources by their paid Principal 
          Investigator. All incidents reported are compared to published 
          media reports or public records to verify their accuracy."),
        p("The dataset can be found through ",
          a("Fatal Encounter Datasheet", 
            href = "https://docs.google.com/spreadsheets/d/1dKmaV_JiWcG8XBoRgP8b4e9Eopkpgt7FL7nyspvzAsE/edit#gid=0"
          )
        ),
        h1("Target Audience"),
        p("The target audience for this data set are people concerned about 
          police brutality because in a democracy, citizens should have the 
          right to know who and why they were killed and whether these deaths 
          were justified. This may also help the government to let them know 
          whether they need to modify their policies or training in order to 
          decrease police involved deaths."),
        h1("Interactive Tools"),
        p("The tools in the tabs listed above were made to answer three main
          questions about the data. How does the amount of fatal encounters
          with law enforcement differ per state across the USA? Is there a
          correlated growth rate of deaths based on gender or cause of death
          each year? And does race have a major impact on the mortality rate
          due to police encounters across the USA? If not, what factor has the
          largest impact on mortality rate?"),
        p("To answer this, we've created an interactive map that will provide
          the locations of where each death took place, a line graph that will
          show the progression of the number of deaths year by year, and a
          donut chart that will display the percent ratio of deaths for certain
          groups in multiple categories.")
      )
    ),
    
    # State Distribution Tab
    tabPanel(
      title = "State Distribution",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "state_in",
            label = "State",
            choices = states,
            selected = "all"
          ),
          radioButtons(
            inputId = "gender_in",
            label = "Gender",
            choices = list(
              "All" = "all",
              "Male" = "Male",
              "Female" = "Female",
              "Transgender" = "Transgender",
              "Transexual" = "Transexual"
            ),
            selected = "all"
          ),
          selectInput(
            inputId = "race_in",
            label = "Race",
            choices = races,
            selected = "all"
          ),
          sliderInput(
            inputId = "year_in",
            label = "Year",
            min = 2000,
            max = 2019,
            value = c(2018, 2019)
          )
        ),
        mainPanel(
          leafletOutput("map")
        )
      )
    ),
    
    # Growth Rate Tab
    tabPanel(
      title = "Growth Rates",
      sidebarLayout(
        sidebarPanel(
          checkboxGroupInput(
            inputId = "gender_choices",
            label = "Gender Options:",
            choices = genders,
            selected = "Male"
          ),
          checkboxGroupInput(
            inputId = "cause_choices",
            label = "Cause Options:",
            choices = causes,
            selected = "Asphyxiated/Restrained"
          )
        ),
        mainPanel(
          plotlyOutput("gender_plot"),
          plotlyOutput("cause_plot")
        )
      )
    ),
    
    # Factors of Impact Tab
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
    
    # Data Analysis tab
    tabPanel(
      title = "Data Analysis",
      mainPanel(
        h1("State Distribution Data"),
        p("From the data given in the map, California has the highest amount of
          deaths out of all the states and has the highest amount of deaths of
          each race except Native American/Alaskan since 2002. Not only that,
          but it is also the state that had the most deaths each year. This is
          likely due to the size of California, but it is not the only factor
          since big states like Texas didn't have as many deaths. There are a
          few outliers on the map, but they are so little that they have no
          effect on the patterns of the data."),
        h1("Growth Rate Data"),
        p("The Death Growth Rate data shows that highest number of victims to
          these fatal encounters are males and the most common cause of deaths
          was by gunshot. These two factors have seen steady growth throughout
          the years along with many other people and causes. While the graphs
          see a steep drop towards the end, that is due to the fact that the
          full year of 2019 has not passed yet. 2019 could continue the trend
          of growth by the end of the year"),
        h1("Factors of Impact Data"),
        p("This donut chart shows that there were more victims that were of an
          unspecified race than many of the other races. It also showed us that
          a majority of the victims were male. Many of the deaths were caused
          by gunshot and the year that had the most deaths was 2018. Male
          victims and death by gunshot seem to be a great majority in their
          respective groups. However, victims of an unspecified race seem to
          have a similar ratio to those who are White and those who are Black.
          The years also seem to have a similar ratio of deaths. Although, it
          should be known that other factors can affect the ratios of these
          categories"),
        h1("Use of the Data"),
        p("From all the data visualizations, there have been many leading
          factors of different categories. This could be used to identify the
          problem and how it can be fixed. However, these factors should **not**
          be treated as the main cause to all deaths by police officers. Many of
          these factors affect the other's outcomes. Our purpose was to provide
          this information so that the public can know about this and make
          informed decisions based on it. Instead of focusing on one category,
          the whole set of data should be used to identify the problem. Our hope
          is that people become more informed and more understanding of the
          problem this way.")
      )
    )
  )
)