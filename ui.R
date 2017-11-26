
ui <- navbarPage("WEHI White Pages",theme = shinytheme("flatly"),
                 
                 tabPanel("White Pages",
                          fluidRow(
                            column(2,
                                   includeMarkdown(file.path(dirRfunctions,"white_pages.md"))
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
                                          choices = white_pages$NameDisplay)
                            ),
                            
                            mainPanel(
                              uiOutput("student_profile")
                            )
                          )
                 ),
                 
                 tabPanel("About"
                 ),
                 
                 tabPanel("User guide"
                 )
)

