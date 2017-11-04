
library(mice)
library(VIM)
library(lattice)

miss1<-read.csv('MissingData1.csv',header=FALSE)
miss1

md.pattern(miss1)

imp1<-mice(miss1)
imp1
imp1$imp$V1


#checking the distribution of observed vs imputed for each colum to choose the best out of the five imputed datasets
long <- complete(imp1,"long")
levels(long$.imp) <- paste("Imputation",1:5)
long <- cbind(long, hc.na=is.na(imp1$data$V14))
densityplot(~V14|.imp, data=long, group=hc.na, plot.points=FALSE,
             ref=TRUE, xlab="Head circumference",scales=list(y=list(draw=F)),
             par.settings=simpleTheme(col.line=rep(c("blue","red"))),
             auto.key = list(columns=2,text=c("Observed","Imputed")))

com1 <- complete(imp1, 5)
write.csv(com1,'imputed1_Final.csv')


