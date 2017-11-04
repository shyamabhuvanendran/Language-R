
library(e1071)
library(caret)
library(Metrics)
library(C50)
library(randomForest)



train3<-read.csv('TrainData3.csv', header = FALSE)
test3<-read.csv('TestData3.csv',header=FALSE)
head(train3)


X3<-train3[,1:9182]
Y3<-train3[,9183]

trainX3<-X3[1:80,]
trainY3<-Y3[1:80]

testX3<-X3[81:100,]
testY3<-Y3[81:100]


trainY3

trainX3

trainX<-train3[1:80,]

#Naive Bayes
trainYN3<- make.names(trainY3)
model3 = train(trainX3,trainYN3,'nb',trControl=trainControl(method='cv',number=10))
summary(model3)
pred1 <- predict(model3,testX3)
pred1

pred2<-substr(pred1,start=2,stop=2)
pred2<-as.numeric(pred2)
pred2
testY3
rmse(pred2,testY3)



#svm
trainX2<-train3[1:80,]

svm_model3 <- svm(V9183 ~ ., data=trainX2)
summary(svm_model3)

pred2 <- predict(svm_model3,testX3)
pred2

rmse(pred2,testY3)


#c50

str(trainY3)
trainY3<-as.factor(trainY3)

model3 <- C50::C5.0( trainX3, trainY3 , type="class")
summary( model3 )
pred3=predict(model3,testX3)

pred3<-substr(pred3,start=2,stop=2)
pred3<-as.numeric(pred3)
pred3                 
rmse(pred3,testY)

trainY3<-Y3[1:80]

#random Forest


X3<-train3[,1:9182]
Y3<-train3[,9183]

trainX3<-X3[1:80,]
trainY3<-Y3[1:80]

testX3<-X3[81:100,]
testY3<-Y3[81:100]

trainX<-train3[1:80,]

fit1 <- randomForest(V9183~., data=trainX)
summary(fit1)
predictions <- predict(fit1, testX3)
table(predictions, testY)
rf<-rmse(predictions, testY)
rf

#Choosing random Forest

train3<-read.csv('TrainData3.csv', header = FALSE)
test3<-read.csv('TestData3.csv',header=FALSE)

fit1 <- randomForest(V9183~., data=train3)
summary(fit1)
predictions <- predict(fit1, test3)
write.csv(predictions, file='TestData3Results_Final.csv')
