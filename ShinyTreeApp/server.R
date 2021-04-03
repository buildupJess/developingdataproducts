#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
data("Loblolly")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  model1 <- lm(height ~ age, data=Loblolly)
  model2 <- lm(age ~ height, data=Loblolly)

  modelPred <- reactive({
    if(input$selection == "Height"){
      heightInput <- input$sliderHeight
      predict(model2, newdata = data.frame(height = heightInput))
    }
    else if(input$selection == "Age"){
      ageInput <- input$sliderAge
      predict(model1, newdata = data.frame(age = ageInput))
    }
  })
  
  output$plot1 <- renderPlot({
    plot(Loblolly$age, Loblolly$height, xlab="Age (years)", ylab="Height (feet)", bty="n", 
         pch=16, xlim=c(1,30), ylim=c(0,70))
    if(input$showModel){
      abline(model1, col="red", lwd=2)
    }
  })
  output$modelPred <- renderText({
    modelPred()
  })

  output$out1 <- renderText("Loblolly Tree heights were measured at 3, 5, 10, 15, 20, 
                            and 25 years.
                            A prediction model was generated through the data.
                            This model predicts the height based on any age (1-25 years) 
                            of the tree or predicts the age based on any height 
                            (1-70 feet).
                            The predicted linear model is shown by the red line.")
})
