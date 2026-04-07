# Install packages (run only once)
install.packages(c("randomForest", "e1071", "caret", "corrplot"))

# Load libraries
library(randomForest)   # Random Forest model
library(e1071)          # SVM model
library(caret)          # Data splitting & evaluation
library(corrplot)       # Correlation heatmap

# Check current working directory
getwd()
# Set working directory where inventory.json is stored
setwd("C:/Users/Mullai Aghalya/Documents")

#load dataset from csv file
dataset <- read.csv("creditcard.csv")
#get first 6 rows from dataset
head(dataset)

#understand the data - Exploratory Data Analysis (EDA)
#get the structure of dataset
str(dataset)
#to get all cumulative values
summary(dataset)

#table classified based on class value(0/1)
table(dataset$Class)
# Visualize class distribution
barplot(table(dataset$Class),
        col=c("blue","red"),
        main="Fraud vs Normal Transactions",
        names.arg=c("Normal","Fraud"))

# Distribution of transaction amount
hist(dataset$Amount,
     main="Transaction Amount Distribution",
     col="lightblue",
     xlab="Amount")

# Boxplot for detecting outliers
boxplot(dataset$Amount,
        main="Outlier Detection in Amount",
        col="orange")

# Correlation heatmap
corrplot(cor(dataset), method="color")

#Data Preprocessing
# Check for missing values
colSums(is.na(dataset))
# Scale Amount
dataset$Amount <- scale(dataset$Amount)
# Remove Time column 
dataset$Time <- NULL

#Handle Imbalanced Data (Undersampling)
set.seed(123)
# Separate classes
fraud <- dataset[dataset$Class == 1, ]
normal <- dataset[dataset$Class == 0, ]
# Undersample normal class
normal_sample <- normal[sample(nrow(normal), nrow(fraud)), ]
# Combine balanced dataset
new_data <- rbind(fraud, normal_sample)
# Check new distribution
table(new_data$Class)

#Data Splitting
set.seed(123)
# Split into 70% train, 30% test
index <- createDataPartition(new_data$Class, p = 0.7, list = FALSE)
train <- new_data[index, ]
test <- new_data[-index, ]

#model training
#Random Forest
model_rf <- randomForest(as.factor(Class) ~ ., data=train, ntree=100)
pred_rf <- predict(model_rf, test)
#logistic Regression
model_lr <- glm(Class ~ ., data=train, family=binomial)
pred_lr <- predict(model_lr, test, type="response")
pred_lr <- ifelse(pred_lr > 0.5, 1, 0)
#svm model
model_svm <- svm(as.factor(Class) ~ ., data=train)
pred_svm <- predict(model_svm, test)

#Model evaluation
# Confusion matrices
conf_rf <- confusionMatrix(as.factor(pred_rf), as.factor(test$Class))
conf_lr <- confusionMatrix(as.factor(pred_lr), as.factor(test$Class))
conf_svm <- confusionMatrix(as.factor(pred_svm), as.factor(test$Class))
# Display results
conf_rf
conf_lr
conf_svm

#Feature Importance
# Feature importance from Random Forest
importance(model_rf)
# Plot importance
varImpPlot(model_rf)

#INTERACTIVE DASHBOARD
install.packages(c("shiny", "plotly"))
library(shiny)
library(plotly)
ui <- fluidPage(
  titlePanel("Credit Card Fraud Detection Dashboard"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "var",
        "Select Feature:",
        choices = names(dataset)   # all columns
      )
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  )
)
server <- function(input, output) {
  output$plot <- renderPlotly({
    # If Class selected → show bar chart
    if(input$var == "Class"){
      
      counts <- table(dataset$Class)
      percent <- round(100 * counts / sum(counts), 2)
      
      plot_ly(
        x = c("Normal", "Fraud"),
        y = percent,
        type = "bar",
        text = paste(percent, "%"),
        textposition = "auto"
      ) %>%
        layout(title = "Class Distribution (%)",
               yaxis = list(title = "Percentage"))
    } else {
      # For other features → histogram
      plot_ly(
        dataset,
        x = ~dataset[[input$var]],
        type = "histogram"
      ) %>%
        layout(title = paste("Distribution of", input$var))
    }
  })
}
shinyApp(ui = ui, server = server)