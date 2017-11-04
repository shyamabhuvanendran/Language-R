data2 <- read.csv("TrainData2_MissingData.csv", header = FALSE)

library(mice)
tempData <- mice(data2,m=5,maxit=0,meth='cart')
imputed <- complete(tempData)

write.table(imputed,file="Traindata2_imputed.csv",row.names=FALSE,col.names=FALSE, sep=",")

testdata <- read.csv("Testdata2.csv", header = FALSE)
Testtempdata <- mice(testdata,m=5,maxit=0,meth='rf')
test1 <- complete(Testtempdata)
write.table(test1,file="Testdata2_imputed.csv",row.names=FALSE,col.names=FALSE, sep=",")
