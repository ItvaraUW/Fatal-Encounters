# title: Final Project: Fatal Encounters
# subtitle: "Data Script"
# author: "Bernabe Ibarra | Feng Yu Yeh | Sean Le | Thomas That"
# date: 20190301

# library("googlesheets") // to maybe use later as api access

read_data <- read.csv("data/Fatal_Encounters_data.csv",
                  stringsAsFactors = F,
                  na.strings = c("", "NA"))

removed_invalids_df <- read_data[!(grepl(
  "2100", read_data$Date..Year.)),]

FE_df <- transform(removed_invalids_df, Date..Year. = as.numeric(Date..Year.))
