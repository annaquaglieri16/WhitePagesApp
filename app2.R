library(shiny)
library(ggplot2)  # for the diamonds dataset
library(DT)
library(readr)
install.packages("shinythemes")
library(shinythemes)
library(png)
library(grid)

library(redcapAPI)
api_token <- '9938D7E7B9B2D861EE7E1F4FFB64637A'

rcon <- redcapConnection(url="https://redcap.wehi.edu.au/api/", token=api_token)
myData <- exportRecords(rcon)


redcap_uri                  <- "https://redcap.wehi.edu.au/api/" 
token                       <- api_token


exportFiles(rcon, record = "6",field = "photo_upload", dir="~",
            filePrefix = TRUE, proj = NULL)

#Export all files in a project
library(reshape2)
myData <- exportRecords(rcon)
filesToExport <- melt(myData[, c("record_id", "first_name","photo_upload")], c("record_id","first_name"),na.rm=TRUE)

for(i in 1:nrow(filesToExport)){
    exportFiles(rcon, record=as.numeric(filesToExport$record_id[i]),
                  field=as.character(filesToExport$variable[i]),
                dir = "/Users/quaglieri.a/WhitePages/WhitePagesApp/student_photos")
  
  }


white_pages <- myData

# Clean text
white_pages$areas_of_interest_or_exper <- gsub("\n",",",white_pages$areas_of_interest_or_exper)
white_pages$areas_of_interest_or_exper <- gsub(" ,",",",white_pages$areas_of_interest_or_exper)
white_pages$areas_of_interest_or_exper <- gsub(",",", ",white_pages$areas_of_interest_or_exper)
white_pages$areas_of_interest_or_exper <- gsub("  "," ",white_pages$areas_of_interest_or_exper)
white_pages$areas_of_interest_or_exper <- gsub(", ,",",",white_pages$areas_of_interest_or_exper)

white_pages$equipment_experience <- gsub("\n",",",white_pages$equipment_experience)
white_pages$equipment_experience <- gsub(" ,",",",white_pages$equipment_experience)
white_pages$equipment_experience <- gsub(",",", ",white_pages$equipment_experience)
white_pages$equipment_experience <- gsub("  "," ",white_pages$equipment_experience)
white_pages$equipment_experience <- gsub(", ,",",",white_pages$equipment_experience)

white_pages$technical_skills <- gsub("\n",",",white_pages$technical_skills)
white_pages$technical_skills <- gsub(" ,",",",white_pages$technical_skills)
white_pages$technical_skills <- gsub(",",", ",white_pages$technical_skills)
white_pages$technical_skills <- gsub("  "," ",white_pages$technical_skills)
white_pages$technical_skills <- gsub(", ,",",",white_pages$technical_skills)

white_pages$hobbies_interests <- gsub("\n",",",white_pages$hobbies_interests)
white_pages$hobbies_interests <- gsub(" ,",",",white_pages$hobbies_interests)
white_pages$hobbies_interests <- gsub(",",", ",white_pages$hobbies_interests)
white_pages$hobbies_interests <- gsub("  "," ",white_pages$hobbies_interests)
white_pages$hobbies_interests <- gsub(", ,",",",white_pages$hobbies_interests)

# Change colnames
colnames(white_pages) <- c("record_id","redcap_survey_identifier","wehi_white_pages_timestamp",
                           "First name","Last name","Lab","Division","Contact email","Areas of interest or expertise",
                           "Technical skills","Equipment experience","Hobbies/Interests","wehi_white_pages_complete")

white_pages <- white_pages[,colnames(white_pages)[!(colnames(white_pages) %in%
                                                      c("record_id","redcap_survey_identifier","wehi_white_pages_timestamp","wehi_white_pages_complete"))]]

# Home 'Student Profiles' 'About' 'How to'

# With Si make the How to 
# How to navigate it and how to add your own record
# In the how to page - how to access the survey and disclaimer
# How to add your record
# Disclaimer paragraph (from James)
# and click to redcap t add your record
# 
# Under the logo put: Create a profile



ui <- navbarPage("WEHI White Pages",theme = shinytheme("flatly"),
                 
                 tabPanel("White Pages",
                          fluidRow(
                            column(1,
                              includeMarkdown("white_pages.md")
                            ),
                            
                            column(10,
                              DT::dataTableOutput('mytable1')
                            )
                          )
                 ),
                 
                 tabPanel("Student Profiles",
                          sidebarLayout(
                            sidebarPanel(
                              # Input: Choose Name
                              selectInput("name", "Choose a name:",
                                          choices = white_pages$Name)
                            ),
                            
                            mainPanel(
                              h1(textOutput('text_name')),
                              plotOutput('image_person',width = "20%", height = "250px"),
                              h2(textOutput('skills_title')),
                              textOutput('skills'),
                              h2(textOutput('Hobbies_title')),
                              textOutput('Hobbies')
                            )
                          )
                 ),
                 
                 tabPanel("About"
                 ),
                 
                 tabPanel("User guide"
                 )
)


server <- function(input, output) {
  
  # WEHI pages dataframe  
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("WEHI_white_pages", ".csv", sep = "")
    },
    content = function(file) {
      write.csv(white_pages, file, row.names = FALSE)
    }
  )
  
  # choose columns to display
  output$mytable1 <- DT::renderDataTable(data.frame(white_pages),options = list(pageLength=10))
  
  output$logo <- renderPlot({
    img <- readPNG("./images/logo.png")
    grid.raster(img)
  })
  
  ###############
  # People's page
  
  output$text_name <- renderText({
    input$name
  })
  
  output$image_person <- renderPlot({
    img <- readPNG(paste0("./images/",input$name,".png"))
    grid.raster(img)
  })
  
  # skills
  output$skills_title <- renderText({
    "Skills"
  })
  
  output$skills <- renderText({
    skills <- white_pages$Skills[white_pages$Name %in% input$name]
  })
  
  # Hobbies
  output$Hobbies_title <- renderText({
    "Hobbies"
  })
  
  output$Hobbies <- renderText({
    Hobbies <- white_pages$Hobbies[white_pages$Name %in% input$name]
  })
}

shinyApp(ui, server)

runApp("/Users/quaglieri.a/WhitePages/WhitePagesApp")
