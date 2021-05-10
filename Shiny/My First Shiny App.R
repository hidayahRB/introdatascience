# BY Siti Norhidayah Binti Abdul Bari Arbee

library(shiny)
library(shinythemes)


ui <- fluidPage(theme = shinytheme("superhero"),
                navbarPage(
                  
                  theme = "superhero", "My First Shiny App",
                  #first tab
                  tabPanel("Basic Calculator",
                           sidebarPanel(
                             tags$h3("Input: "),
                             numericInput("int1", "Integer 1: ",""),
                             numericInput("int2","Integer 2: ",""),
                             selectInput("ops","Select Operation:",
                                         choices = c("Addition","Subtraction",
                                         "Multiplication","Division"))
                           ),#sidebar Panel
                           
                           mainPanel(
                             img(src = "https://familiesforlife.sg/discover-an-article/PublishingImages/Maths.jpg", 
                                 height = 180, width = 400),
                             h2("Final Result : "),
                             verbatimTextOutput("numResult")
                           )
                           
                  ),
                  
                  tabPanel("BMI Calculator",
                           sidebarPanel(
                             h3("Your Information"),
                             
                             radioButtons("unit", "Units",
                                          c("Metric (kg & cm)" = "norm",
                                            "Imperial (lb & in)" = "uniq")),
                             
                             numericInput("wNum","Weight : ",""),
                             numericInput("hNum","Height : ",""),
                             img(src = "https://pbs.twimg.com/media/EweXRVnXAAAduOV.jpg", 
                                 height = 180, width = 180),
                             h5("Stay healthy!!")
                             
                           ),
                           mainPanel(
                             h4("Entered Weight : "), textOutput("wEnter"),
                             h4("Entered height : "), textOutput("hEnter"),
                             h2("Your BMI Result"),
                             verbatimTextOutput("finalResult"),
                             h2("Status"),
                             h6("below 18.5  : Underweight"),
                             h6("18.5 - 24.9 : Normal"),
                             h6("25.0 - 29.9 : Overweight"),
                             h6("above 30.0  : Obese")
                             
                           )
                  )
                  
                )
  
)

server <- function(input, output) {
  
  output$numResult <- renderText({
    switch(input$ops,
           "Addition" = input$int1 + input$int2,
           "Subtraction" = input$int1 - input$int2,
           "Multiplication" = input$int1 * input$int2,
           "Division" = input$int1 / input$int2)
  })
  
  output$wEnter <- renderText({
    unit <- switch(input$unit,
                   norm = paste(input$wNum, "kg", sep = " "),
                   uniq = paste(input$wNum, "lb", sep = " ")
                   )
    
  })
  
  output$hEnter <-renderText({
    unit <- switch(input$unit,
                   norm = paste(input$hNum, "cm", sep = " "),
                   uniq = paste(input$hNum, "lb", sep = " "))
    
  })
  
  output$finalResult <- renderText({
    unit <- switch(input$unit,
              norm = input$wNum / ((input$hNum/100)^2),
              uniq = 703 * input$wNum / ((input$hNum)*(input$hNum)),
            )        
    
  })
  
  
  
}

shinyApp(ui = ui, server = server)
