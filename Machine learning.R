data(iris)
View(iris)
##
install.packages("e1071")
install.packages("kernlab")##contain algorithm for the ML
install.packages("caret")

##to set the seed
set.seed(123)

##to perform splitting the data
library(caret)
trainingindex <- createDataPartition(iris$Species, p=0.8, list = FALSE) ##splitting data, training 80% and testing 20%
trainingset <- iris[trainingindex,] #setting training set -- > using for building model
testingset <- iris[-trainingindex,] #setting testing set
View(trainingindex)
View(trainingset)
View(testingset)

##to set the seed
set.seed(1000000)
trainingindex <- createDataPartition(iris$Species, p=0.8, list = FALSE) ##splitting data, training 80% and testing 20%
View(trainingindex)

plot(trainingset$Sepal.Length,trainingset$Sepal.Width)
plot(testingset$Sepal.Length,testingset$Sepal.Width)
plot(iris$Petal.Length,iris$Sepal.Width)

##svmPoly -- refer to support vector machine -- supervised learning model which using algorithm to analyze data for classification and regression analysis
##to create the model -- > classification model
model <- train(    Species ~ ., data = trainingset, ##class label -- > species
                   method = "svmPoly", 
                   na.action = na.omit,
                   preProcess=c("scale","center"),
                   trControl=trainControl(method="none",number=10),
                   tunegrid = data.frame(degree=1,scale=1,c=1)
                    )

##to build cross-validation model
##we need to set up the k value (fold value) to divide the training dataset into smaller subgroups
model.cv <- train(Species ~ .,data =trainingset,
                  method = "svmPoly",
                  na.action = na.omit,
                  preProcess=c("scale","center"),
                  trControl=trainControl(method="cv",number=10),
                  tunegrid=data.frame(degree=1,scale=1,c=1)
                  )

#Exploit the model for the prediction
model.training <- predict(model, trainingset)##predict the outcome by using the model with the training dataset
model.testing <- predict(model, testingset)##predict the outcome by using the model with the testing dataset
model.cv <- predict(model.cv, trainingset)## cross-validate the training dataset

#To observe the model performance after cross-validation -- > displays confusion matrix and statistics
model.training.confusion <- confusionMatrix(model.training, trainingset$Species)
model.testing.confusion <- confusionMatrix(model.testing, testingset$Species)
model.cv.confusion <- confusionMatrix(model.cv, trainingset$Species)

print(model.training.confusion)
#Confusion Matrix and Statistics

#Reference
#Prediction   setosa versicolor virginica
#setosa         40          0         0 -- > predict correctly
#versicolor      0         35        10 --> not accurate
#virginica       0          5        30 --> not accurate

#Overall Statistics

#Accuracy : 0.875 ## if it is 99% it does not mean it is truely accurate, depending on the distribution of the data       
#95% CI : (0.8022, 0.9283)
#No Information Rate : 0.3333          
#P-Value [Acc > NIR] : < 2.2e-16       

#Kappa : 0.8125          

#Mcnemar's Test P-Value : NA              

#Statistics by Class:

#                     Class: setosa Class: versicolor Class: virginica
#Sensitivity                 1.0000            0.8750           0.7500
#Specificity                 1.0000            0.8750           0.9375
#Pos Pred Value              1.0000            0.7778           0.8571
#Neg Pred Value              1.0000            0.9333           0.8824
#Prevalence                  0.3333            0.3333           0.3333
#Detection Rate              0.3333            0.2917           0.2500
#Detection Prevalence        0.3333            0.3750           0.2917
#Balanced Accuracy           1.0000            0.8750           0.8438

print(model.testing.confusion)
print(model.cv.confusion)

#Feature importance -- > telling which variable affect the model accuracy
importance <- varImp(model)
plot(importance)
plot(importance, col = 'dark')


