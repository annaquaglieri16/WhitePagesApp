
server <- function(input, output) {
  
  # choose columns to display
  output$mytable1 <- DT::renderDataTable(
    data.frame(white_pages_display[!(colnames(white_pages_display) %in% "NameDisplay")]),
    options = list(pageLength=10))
  
  ###############
  # People's page
  
  output$student_profile <- renderUI({
    file <- file.path(dirAppImages,gsub(" ","_",input$name),"student_profile.md")
    includeMarkdown(file)
  })
  
  output$acc <- renderText({
    file.path(dirAppImages,gsub(" ","_",input$name),"student_profile.md")
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


