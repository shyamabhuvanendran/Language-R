
library(mice)
library(VIM)
library(lattice)

miss2<-read.csv('MissingData2.csv',header=FALSE)
miss2

md.pattern(miss2)

head(miss2)
summary(miss2)

imp2<-mice(miss2)
imp2
imp2$imp$V1


#checking the distribution of observed vs imputed for each colum to choose the best out of the five imputed datasets
long2 <- complete(imp2,"long")
long2
levels(long2$.imp) <- paste("Imputation",1:5)
long2 <- cbind(long2, hc.na=is.na(imp2$data$V49))
densityplot(~V49|.imp, data=long2, group=hc.na, plot.points=FALSE,
            ref=TRUE, xlab="Head circumference",scales=list(y=list(draw=F)),
            par.settings=simpleTheme(col.line=rep(c("blue","red"))),
            auto.key = list(columns=2,text=c("Observed","Imputed")))

com2 <- complete(imp2, 1)
write.csv(com2,'imputed2_Final.csv')


