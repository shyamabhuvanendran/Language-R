
library(e1071)
library(caret)
library(Metrics)
library(C50)



train5<-read.csv('TrainData5.csv', header = FALSE)
test5<-read.csv('TestData5.csv',header=FALSE)
head(train5)


X<-train5[,1:19]
Y<-train5[,20]


trainX<-X[1:640,]
trainY<-Y[1:640]


testX<-X[641:800,]
testY<-Y[641:800]


#Naive Bayes
trainY<- make.names(trainY)
model = train(trainX,trainY,'nb',trControl=trainControl(method='cv',number=10))
summary(model)
pred1 <- predict(model,testX)
pred1

pred1<-substr(pred1,start=2,stop=2)
pred1<-as.numeric(pred1)
pred1

rmse(pred1,testY)



#svm
trainY<-Y[1:640]
trainX2<-train5[1:640,]

svm_model <- svm(V20 ~ ., data=trainX2)
summary(svm_model)

pred2 <- predict(svm_model,testX)
pred2

rmse(pred2,testY)


#c50


trainY3<-as.factor(trainY)
trainY3

model3 <- C50::C5.0( trainX, trainY3 , type="class")
summary( model3 )
pred3=predict(model3,testX)
pred3
pred4<-as.numeric(pred3)


pred4                 
rmse(pred4,testY)

trainY<-Y[1:640]

#knn
trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)


knn_fit <- train(V20 ~., data = trainX2, method = "knn",
                 trControl=trctrl,
                 preProcess = c("center", "scale"),
                 tuneLength = 10)

knn_fit
pred4<-predict(knn_fit,testX)
rmse(pred4,testY)


#using svm

train5<-read.csv('TrainData5.csv', header = FALSE)
test5<-read.csv('TestData5.csv',header=FALSE)

svm_model <- svm(V20 ~ ., data=train5)
summary(svm_model)

pred5 <- predict(svm_model,test5)
pred5

write.csv(pred5, file='TestData5Results_Final.csv')
