# Cron script

# Install packages if needed
list.of.packages <- c("shiny","tidyverse","DT","readr","redcapAPI","reshape2","knitr","chron","rmarkdown","png","grid")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages,repos = "https://cloud.r-project.org")
lapply(list.of.packages, require, character.only = TRUE)


#########################
# Initial directory setup
#########################
# Only run once

## App directory
dirApp <- getwd()
dirAppData <- file.path(dirApp,"data")
dirAppImages <-  file.path(dirApp,"images")
dirRfunctions <-  file.path(dirApp,"Rfunction")

## The best thing would be that this backed up data would be saved into the WESA folder so that they are easily accessed by everyone
## Folder where backed up data are saved
date <- Sys.Date()
dirAppBackup <-  file.path(dirApp,"backedup_files")
dirAppBackupDate <- file.path(dirAppBackup,date)

dir.create(dirApp,recursive = TRUE,showWarnings = FALSE)
dir.create(dirAppImages,recursive = TRUE,showWarnings = FALSE)
dir.create(dirAppBackup,recursive = TRUE,showWarnings = FALSE)

# Render report update_data.Rmd with date specified

rmarkdown::render(input=file.path(dirApp,"update_data.Rmd"),
                  output_file  = file.path(dirAppBackupDate,paste0("backup_data_summary_",date,".html")))


