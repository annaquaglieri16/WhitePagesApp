# Cron script

# Install all packages - add external portal
install.packages("chron")
library(chron)
library(tidyverse)
library(rmarkdown)
library(png)
library(grid)
library(DT)
library(tidyverse)
library(redcapAPI)
library(reshape2)
library(knitr)
library(chron)


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
date <- Sys.Date()
dirAppBackupDate <- file.path(dirApp,"backedup_files",date)

# R and Rmd function dir 
dirRfunctions <- "/Users/quaglieri.a/WhitePages/WhitePagesApp/Rfunction"

dir.create(dirApp,recursive = TRUE,showWarnings = FALSE)
dir.create(dirAppImages,recursive = TRUE,showWarnings = FALSE)
dir.create(dirAppBackup,recursive = TRUE,showWarnings = FALSE)

# Render report update_data.Rmd with date specified

rmarkdown::render(input=file.path(dirRfunctions,"update_data.Rmd"),
                  output_file  = file.path(dirAppBackupDate,paste0("backup_data_summary_",date,".html")))


