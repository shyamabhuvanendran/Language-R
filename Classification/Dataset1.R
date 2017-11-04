
library(e1071)
library(caret)
library(Metrics)
library(C50)



train1<-read.csv('TrainData1.csv', header = FALSE)
test1<-read.csv('TestData1.csv',header=FALSE)
head(train1)


X<-train1[,1:48]
Y<-train1[,49]


trainX<-X[1:28700,]
trainY<-Y[1:28700]

testX<-X[28701:41000,]
testY<-Y[28701:41000]


#Naive Bayes
trainY<- make.names(trainY)
model = train(trainX,trainY,'nb',trControl=trainControl(method='cv',number=10))
summary(model)
pred1 <- predict(model,testX)
pred1

pred1<-substr(pred1,start=2,stop=2)
pred1<-as.numeric(pred1)

rmse(pred1,testY)

trainY<-Y[1:28700]

#svm
trainX2<-train1[1:28700,]

svm_model <- svm(V49 ~ ., data=trainX2)
summary(svm_model)

pred2 <- predict(svm_model,testX)
pred2

rmse(pred2,testY)


#c50

trainY3<-str(trainY)
trainY3<-as.factor(trainY)

model3 <- C50::C5.0( trainX, trainY3 , type="class")
summary( model3 )
pred3=predict(model3,testX)

pred3<-as.numeric(pred3)


pred3                 
rmse(pred3,testY)


#using c5.0

train1<-read.csv('TrainData1.csv', header = FALSE)
test1<-read.csv('TestData1.csv',header=FALSE)

X<-train1[,1:48]
Y<-train1[,49]

str(Y)
Y3<-as.factor(Y)
Y3
model3 <- C50::C5.0( X, Y3 , type="class")
summary( model3 )
pred3=predict(model3,test1)
pred3
write.csv(pred3, file='TestData1Results_Final.csv')



