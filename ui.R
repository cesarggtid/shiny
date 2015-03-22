library(shiny)

# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("Classification with trees"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        helpText("This simple application will allow you compare several types of classifiers using the well known iris dataset"),
        helpText("Select a model in the Method Select box and train it doing click on the button Train."),
        helpText("After training, check the accurate of the classifier clicking on the button Test."),
        selectInput("model", "Method:", 
                    choices=c("ctree","rpart","rpart2","ctree2")),
        # numericInput("train_size", "Size to train %:", 70),
        actionButton("goButton", "Train"),
        actionButton("goTest", "Test"),
        hr(),
        h3("Predict"),
        helpText("To predict the class for a specific observation, fill the data in the features text boxes below and click on the button Predict."),
        numericInput("petal_length", "Petal Length:", 0),
        numericInput("petal_width", "Petal Width:", 0),
        numericInput("sepal_length", "Sepal Length:", 0),
        numericInput("sepal_width", "Sepal Width:", 0),
        actionButton("goPredict", "Predict")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        h3("Model"),
        plotOutput("treePlot"),
        h3("Test Result"),
        verbatimTextOutput("testValue"),
        h3("Predict Result"),
        verbatimTextOutput("predictValue")
      )
      
    )
  )
)