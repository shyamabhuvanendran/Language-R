
library(mice)
library(VIM)
library(lattice)
library(missForest)
library(ggplot2)
library(dplyr) 

miss3<-read.csv('FluDataMissingValue.csv',header=FALSE)
miss3

imp3<-missForest(miss3, xtrue = miss3, verbose = TRUE)

sum(is.na(imp3))
mice_plot <- aggr(miss3, col=c('green','red'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(miss3), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))

mice_plot <- aggr(imp3$ximp, col=c('green','red'),
                  numbers=TRUE, sortVars=TRUE,
                  labels=names(imp3$ximp), cex.axis=.7,
                  gap=3, ylab=c("Missing data","Pattern"))

write.csv(imp3$ximp,'imputed3_Final.csv')


