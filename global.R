# R Functions to load 

list.of.packages <- c("shiny","tidyverse","DT","readr","shinythemes","png","grid")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages,repos = "https://cloud.r-project.org")
lapply(list.of.packages, require, character.only = TRUE)


# Directory
## App directory
dirApp <- "."
# data directory
dirAppData <- file.path(dirApp,"data")
## Folder where student photos and profiles are saved
dirAppImages <-  file.path(dirApp,"images")
## R functions
dirRfunctions <-  file.path(dirApp,"Rfunction")
# Other pages of the app
dirPages <-  file.path(dirApp,"pages")

# Read in Data
white_pages <- read.csv(file.path(dirAppData,"WhitePagesData.csv"))

# Change colnames
colnames(white_pages)[colnames(white_pages) %in% "first_name"] <- "First name"
colnames(white_pages)[colnames(white_pages) %in% "last_name"] <- "Last name"
colnames(white_pages)[colnames(white_pages) %in% "division"] <- "Division"
colnames(white_pages)[colnames(white_pages) %in% "lab"] <- "Lab"
colnames(white_pages)[colnames(white_pages) %in% "contact_email"] <- "Contact email"
colnames(white_pages)[colnames(white_pages) %in% "areas_of_interest_or_exper"] <- "Areas of interest or expertise"
colnames(white_pages)[colnames(white_pages) %in% "lab_skills"] <- "Lab skills"
colnames(white_pages)[colnames(white_pages) %in% "equipment_experience"] <- "Equipment experience"
colnames(white_pages)[colnames(white_pages) %in% "software_experience"] <- "Software experience"
colnames(white_pages)[colnames(white_pages) %in% "prof_development"] <- "Professional development"
colnames(white_pages)[colnames(white_pages) %in% "hobbies_interests"] <- "Hobbies/Interests"

# Remove columns not needed for display on the website
white_pages <- white_pages[,colnames(white_pages)[!(colnames(white_pages) %in%
c("record_id","redcap_survey_identifier","wehi_white_pages_timestamp","wehi_white_pages_complete","photo_upload"))]]

# Dataset to display
white_pages_display <- white_pages[,!(colnames(white_pages) %in% c("PhotoName","dtimes","thetimes","NameFolder"))]

# White Pages default student profile
white_pages_display <- rbind(white_pages_display,NA)
white_pages_display$NameDisplay <- ifelse(is.na(white_pages_display$NameDisplay), " ", 
                                          as.character(white_pages_display$NameDisplay))

