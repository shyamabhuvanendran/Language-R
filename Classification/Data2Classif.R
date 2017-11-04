
train1 <- read.csv("Traindata2_imputed.csv", header = FALSE)

test1 <- read.csv("Testdata2.csv", header = FALSE)

library(e1071)
library(caret)
library(Metrics)
library(C50)



X<-train1[,1:3312]
Y<-train1[,3313]


trainX<-X[1:120,]
trainY<-Y[1:120]

trainY<- make.names(trainY)

testX<-X[121:150,]
testY<-Y[121:150]


#svm
trainX2<-train1[1:120,]

svm_model <- svm(V3313 ~ ., data=trainX2)
summary(svm_model)

pred2 <- predict(svm_model,testX)
pred2

rmse(pred2,testY)


#c50

str(trainY)
trainY3<-as.factor(trainY)

model3 <- C50::C5.0( trainX, trainY3 , type="class")
summary( model3 )
pred3=predict(model3,testX)
pred3 <- substr(pred3,start=2, stop=2)
pred3 <- as.numeric(pred3)
#write.table(pred3, file='pred11.csv', row.names=FALSE, col.names=FALSE, sep=",")
#pred3<-read.csv('pred11.csv', header = FALSE)

pred3                 
rmse(pred3,testY)



#using C50

str(Y)
trainY3<-as.factor(Y)

model3 <- C50::C5.0( X, trainY3 , type="class")
summary( model3 )
pred3=predict(model3,test1)
pred3 <- substr(pred3,start=2, stop=2)
pred3 <- as.numeric(pred3)

write.table(pred3, file='TestDatalabels.csv', row.names=FALSE, col.names=FALSE, sep=",")
