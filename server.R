library(shiny)

library(datasets)
library(caret)
library(party)

train.arbol <- function(caret.method, trainData) {
  
  modFit <- train(Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, method=caret.method, data=trainData)
  
  modFit
  
}

plot.arbol <- function(caret.method, model) {

  plot(model$finalModel)
  
  if(caret.method == "rpart" || caret.method == "rpart2") {
    text(model$finalModel,use.n=TRUE,all=TRUE)
  } 
  
}

test.arbol <- function(model, testData) {
  
  testPred <- predict(model, newdata = testData)
  table(testPred, testData$Species)  

}

predict.arbol <- function(model, sepal_length, sepal_width, petal_length, petal_width) {
  df <- data.frame(Sepal.Length=sepal_length, Sepal.Width=sepal_width, Petal.Length=petal_length, Petal.Width=petal_width)
  testPred <- predict(model, newdata = df)
  testPred
}

# Define a server for the Shiny app
shinyServer(function(input, output) {
  
  set.seed(1234)
  
  intrain <- createDataPartition(y=iris$Species,p=0.7,list=FALSE)
  
  trainData <- iris[intrain,]
  testData <- iris[-intrain,]
  
  final.model <- reactive({
    train.arbol(input$model, trainData)
  })
  

  # Fill in the spot we created for a plot
  output$treePlot <- renderPlot({
    
    input$goButton
    
    isolate(plot.arbol(input$model, final.model()))
    
  })
  
  
  output$testValue <- renderPrint({
    input$goTest
    isolate(test.arbol(final.model(),testData))
  })
  
  output$predictValue <- renderPrint({
    input$goPredict
    
    isolate(predict.arbol(final.model(),input$sepal_length, input$sepal_width, input$petal_length, input$petal_width))
    
  })
  
})