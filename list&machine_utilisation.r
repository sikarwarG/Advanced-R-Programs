# Upload required file
getwd()
setwd("C:/Users/Dell/Desktop/R tutorials/advanced_R_tutorial")
util<- read.csv("P3-Machine-Utilization.csv")
head(util,4)
tail(util,4)
summary(util)
str(util)
# Check for missing data
sum(is.na(util))
complete.cases(util)
util[!complete.cases(util),]
# Derive utilisa column

util$Percent.Utilisation<- 1- util$Percent.Idle
head(util)
tail(util)

#  Handle time

?POSIXct





