
ui <- navbarPage("WEHI White Pages",theme = shinytheme("flatly"),
                 
                 tabPanel("White Pages",
                          fluidRow(
                            column(2,
                                   includeMarkdown(file.path(dirPages,"white_pages.md"))
                            ),
                            
                            column(10,
                                   DT::dataTableOutput('WPData')
                            )
                          )
                 ),
                 
                 tabPanel("Student Profiles",
                          sidebarLayout(
                            sidebarPanel(
                              # Input: Choose Name
                              selectInput("name", "Choose a name:",selected = " ",
                                          choices = white_pages_display$NameDisplay,
                                          selectize=TRUE)
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

