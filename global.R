library(shiny)
library(ggplot2)  # for the diamonds dataset
library(DT)
library(readr)
# install.packages("shinythemes")
library(shinythemes)
library(png)
library(grid)

# Directory
## App directory
dirApp <- "/Users/quaglieri.a/WhitePages/WhitePagesApp"
# data directory
dirAppData <- "/Users/quaglieri.a/WhitePages/WhitePagesApp/data"
## Folder where student photos are saved
dirAppImages <-  "/Users/quaglieri.a/WhitePages/WhitePagesApp/images"
## R function
dirRfunctions <-  "/Users/quaglieri.a/WhitePages/WhitePagesApp/Rfunction"
dirPages <-  "/Users/quaglieri.a/WhitePages/WhitePagesApp/pages"

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

# Remove columns
white_pages <- white_pages[,colnames(white_pages)[!(colnames(white_pages) %in%
c("record_id","redcap_survey_identifier","wehi_white_pages_timestamp","wehi_white_pages_complete","photo_upload"))]]

# Dataset to display
white_pages_display <- white_pages[,!(colnames(white_pages) %in% c("PhotoName","dtimes","thetimes","NameFolder"))]

# white oages default student profile
white_pages_display <- rbind(white_pages_display,NA)
white_pages_display$NameDisplay <- ifelse(is.na(white_pages_display$NameDisplay), " ", as.character(white_pages_display$NameDisplay))

# Home 'Student Profiles' 'About' 'How to'

# With Si make the How to 
# How to navigate it and how to add your own record
# In the how to page - how to access the survey and disclaimer
# How to add your record
# Disclaimer paragraph (from James)
# and click to redcap t add your record
# 
# Under the logo put: Create a profile
