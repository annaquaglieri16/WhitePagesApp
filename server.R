
server <- function(input, output) {
  
  # choose columns to display
  output$WPData <- DT::renderDataTable(
    data.frame(white_pages_display[!(colnames(white_pages_display) %in% "NameDisplay")]),
    options = list(pageLength=10))
  
  ###############
  # People's page
  
  output$student_profile <- renderUI({
    
    if(input$name == " "){
      file <- file.path(dirPages,"default_student_profile.md")
      includeMarkdown(file)
    }else{
      file <- file.path(dirAppImages,gsub(" ","_",input$name),"student_profile.md")
      includeMarkdown(file)
    }
    
  })

}


