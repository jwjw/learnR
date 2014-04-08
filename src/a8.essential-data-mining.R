# Essential data mining
library(hflights)
data(hflights)
View(head(hflights,1000))

hflights <- hflights[!is.na(hflights$ArrDelay),]

## Partition models {party}
library(party)
fit <- ctree(factor(ArrDelay>0)~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=hflights,controls = ctree_control(maxdepth = 3))
plot(fit)

### Cross validation
tdata.i <- sample(1:nrow(hflights),size = nrow(hflights)*0.90, replace = F)
tdata <- hflights[tdata.i,]
vdata <- hflights[-tdata.i,]
fit <- ctree(factor(ArrDelay>0)~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=tdata,controls = ctree_control(maxdepth = 8))
vdata.actual <- vdata$ArrDelay>0
vdata.pred <- as.logical(predict(fit,newdata=vdata))
table(pred=vdata.pred,actual=vdata.actual)/c(length(vdata.pred[!vdata.pred]),length(vdata.pred[vdata.pred]))



## Neural networks {nnet}
library(nnet)

fit <- nnet(factor(ArrDelay>0)~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=hflights,size = 3, rang=0.1,decay=5e-4,maxit=200)

tdata.i <- sample(1:nrow(hflights),size = nrow(hflights)*0.90, replace = F)
tdata <- hflights[tdata.i,]
vdata <- hflights[-tdata.i,]
fit <- nnet(factor(ArrDelay>0)~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=tdata,size = 3, rang=0.1,decay=5e-4,maxit=200)

pred <- predict(fit,newdata=vdata)
preds <- pred >= 0.9 | pred <= 0.3
vdata.pred <- logical(length(pred))
vdata.pred[pred>=0.9] <- TRUE
vdata.pred[pred<=0.3] <- FALSE
vdata.pred <- vdata.pred[preds]
vdata.actual <- (vdata$ArrDelay>0)[preds]
table(pred=vdata.pred,actual=vdata.actual)
table(pred=vdata.pred,actual=vdata.actual)/c(length(vdata.pred[!vdata.pred]),length(vdata.pred[vdata.pred]))



## Support Vector Machine
library(kernlab)
fit <- ksvm(ArrDelay~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=hflights)

### Cross validation
tdata.i <- sample(1:nrow(hflights),size = nrow(hflights)*0.3, replace = F)
tdata <- hflights[tdata.i,]
vdata <- hflights[-tdata.i,]
fit <- ksvm(ArrDelay~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=tdata)
vdata.actual <- vdata$ArrDelay>0
vdata.pred <- predict(fit,newdata=vdata)>0
table(pred=vdata.pred,actual=vdata.actual)/c(length(vdata.pred[!vdata.pred]),length(vdata.pred[vdata.pred]))


## Random forest model {randomForest}
library(randomForest)
fit <- randomForest(ArrDelay~Month+Distance+DayOfWeek+AirTime,data=hflights)

### Cross validation
tdata.i <- sample(1:nrow(hflights),size = nrow(hflights)*0.95, replace = F)
tdata <- hflights[tdata.i,]
vdata <- hflights[-tdata.i,]
fit <- randomForest(formula = ArrDelay~Month+Distance+DayOfWeek+AirTime,data=tdata,ntree = 8,maxnodes=80,importance = T,na.action=na.omit)
vdata.actual <- vdata$ArrDelay>0
vdata.pred <- predict(fit,newdata=vdata)>0
table(pred=vdata.pred,actual=vdata.actual)/c(length(vdata.pred[!vdata.pred]),length(vdata.pred[vdata.pred]))



## C5.0 model {C50}
library(C50)
fit <- C5.0(factor(ArrDelay>0)~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=hflights)

### Cross validation
tdata.i <- sample(1:nrow(hflights),size = nrow(hflights)*0.95, replace = F)
tdata <- hflights[tdata.i,]
vdata <- hflights[-tdata.i,]
fit <- C5.0(factor(ArrDelay>0)~Month+factor(UniqueCarrier)+Distance+DayOfWeek+AirTime,data=tdata)
vdata.actual <- vdata$ArrDelay>0
vdata.pred <- as.logical(predict(fit,newdata=vdata))
table(pred=vdata.pred,actual=vdata.actual)/c(length(vdata.pred[!vdata.pred]),length(vdata.pred[vdata.pred]))
