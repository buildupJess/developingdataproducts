#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Loblolly Tree Predictions"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Predict a Loblolly Tree's height or age"),
      selectInput("selection", label = "Choose a variable to predict on",
                  choices = c('Age', 'Height'), selected = "Height"),
      wellPanel(
        conditionalPanel("input.selection == 'Height'",
          sliderInput("sliderHeight", "What is the height (ft) of the Loblolly tree?", 1, 70, value=30)
        ),
        conditionalPanel("input.selection == 'Age'",
          sliderInput("sliderAge", "What is the age (years) of the Loblolly tree?", 1, 25, value=10)
      )),
      checkboxInput("showModel", "Show Model", value=TRUE)
      #Submit is used so the calculation is made when submitted and not before
      #submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(type="tabs", 
                  #br() is a carriage return to go to new line for textOutput
                  tabPanel("Documentation", br(), textOutput("out1")),
                  tabPanel("Plot", br(), plotOutput("plot1"),
                           conditionalPanel("input.selection == 'Age'",
                                            h3("Predicted height (ft) from Model:")),
                           conditionalPanel("input.selection == 'Height'",
                                            h3("Predicted age (years) from Model")),
                           textOutput("modelPred")
                  )
      )
    )
  )
))
