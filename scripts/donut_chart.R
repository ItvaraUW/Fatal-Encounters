# title: "INFO&201: Final Project"
# subtitle: "Fatal Encounters"
# authors: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: "20190301"

library(dplyr)
library(plotly)

# Make an interactive donut chart that shows individuals within each group 
# that was killed to fatal encounters.

donut_chart <- function(data_frame, sym_factor, factor){
  # acquire data from input data frame
  # change some error from the data frame 
  # and select needed variables only
  data_for_graph <- data_frame %>%
    mutate(
      Subject.s.gender = replace(Subject.s.gender,
                                 Subject.s.gender == "Femalr", "Female"),
      Subject.s.gender = replace(Subject.s.gender,
                                 Subject.s.gender == "White", NA)) %>% 
    select(Subject.s.gender, Subject.s.race, 
           Cause.of.death, Date..Year.) %>%
    rename(gender = Subject.s.gender,
           race = Subject.s.race,
           cause = Cause.of.death,
           year = Date..Year.)

  # plot data
  interactive_plot <- data_for_graph %>% 
    group_by(!!sym_factor) %>% 
    summarise(freq = length(!!sym_factor)) %>% # calculate the frequency happen
    filter(!(is.na(!!sym_factor))) %>% # filter out if there's any NAs
    plot_ly(
      labels = ~eval(parse(text = factor)), #
      values = ~freq, # set values from the frequency calculated
      type = "pie", # create pie chart
      textinfo = 'percent', # show percentage on the plot
      hoverinfo = 'text', # determine which information to appear when hover
      text = ~paste("People Killed: ", freq, "<br>", 
                    toupper(substr(sym_factor, 1, 1)), 
                    substring(sym_factor, 2), sep = "", ": ",
                    eval(parse(text = factor))), # show the information 
                                                 # when hovering over a bar
      hole = 0.6 # make a hole at the pie chart to make a donut shape
    ) %>% 
    layout( # set up the title of the plot and get rid or x and y axis
      title = paste("Total Police Fatal Encounter by ",
                    toupper(substr(factor, 1, 1)), 
                    substring(factor, 2), sep = ""),
      xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
      yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
    )
}