# Cron script

# Install all packages - add external portal
install.packages("chron")
library(chron)
library(tidyverse)


#########################
# Initial directory setup
#########################
# Only run once

## App directory
dirApp <- "/Users/quaglieri.a/WhitePages/WhitePagesApp"

# data directory
dirAppData <- "/Users/quaglieri.a/WhitePages/WhitePagesApp/data"

## Folder where student photos are saved
dirAppImages <-  "/Users/quaglieri.a/WhitePages/WhitePagesApp/images"

## The best thing would be that this backed up data would be saved into the WESA folder so that they are easily accessed by everyone
## Folder where backed up data are saved
dirAppBackup <-  "/Users/quaglieri.a/WhitePages/WhitePagesApp/backedup_files"

dir.create(dirApp,recursive = TRUE)
dir.create(dirAppImages,recursive = TRUE)
dir.create(dirAppBackup,recursive = TRUE)

# Render report update_data.Rmd with date specified

library(rmarkdown)
date <- Sys.Date()
rmarkdown::render(input=file.path(dirAppBackup,"update_data.Rmd"),
                  output_file  = file.path(dirAppBackup,date,paste0("backup_data_summary_",date,".html")))


