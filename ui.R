
ui <- navbarPage("WEHI White Pages",theme = shinytheme("flatly"),
                 
                 tabPanel("White Pages",
                          fluidRow(
                            column(2,
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

