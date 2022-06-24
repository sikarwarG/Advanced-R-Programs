getwd()
setwd("C:/Users/Dell/Desktop/R tutorials/advanced_R_tutorial")
getwd()
setwd("./Weather Data")
getwd()
# Read data
Chicago<-read.csv("Chicago-F.csv")
Chicago
colnames(Chicago)
T_Chicago<- t(Chicago)
T_Chicago
# But we dont want x as column but as rows
Chicago<-read.csv("Chicago-C.csv",row.names = 1)
NewYork<-read.csv("NewYork-C.csv",row.names = 1)
SanFrancisco<-read.csv("SanFrancisco-C.csv",row.names = 1)
Houston<-read.csv("Houston-C.csv",row.names = 1)
#Chicago
Chicago
#New york
NewYork
#SanFrancisco
SanFrancisco
#Houston
Houston

# Convert all data into matrix bcoz these data frame contain same type of data
is.data.frame(NewYork)
# Convert into matrix
Chicago<-as.matrix(Chicago)
Chicago
#Check
is.matrix(Chicago)
# Converts all and store them in list
NewYork<- as.matrix(NewYork)
NewYork
Houston<-as.matrix(Houston)
SanFrancisco<-as.matrix(SanFrancisco)
Weather<-list(NewYork=NewYork,Houston=Houston,Chicago=Chicago,SanFrancisco=SanFrancisco)
Weather
rownames(Weather)
# Extract
Weather[3]
Weather[[3]]
Weather$Chicago
# Apply
?apply
NewYork
apply(NewYork,1,mean)
apply(Chicago,1,mean)
apply(SanFrancisco,1,mean)
apply(Houston,1,mean)

# How works apply fubction

output<-NULL
for (i in 1:nrow(NewYork)) {
  output[i]<-mean(NewYork[i,])
  
}
output
names(output)<-c("AvgHigh_C","AvgLow_C ","AvgPrecip_mm", "DaysWithPrecip", "HoursOfSunshine")
apply(NewYork,1,mean)

# lapply
?lapply
# 1 example
new_Weather<-lapply(Weather, t)    # transpose all weather data
new_Weather
new_Weather1<- lapply(new_Weather,t)
new_Weather1
# 2 example
new_Weather2<-lapply(Weather,rowMeans)
new_Weather2
# add new row
new_Weather3<-lapply(Weather, rbind,1:12)
new_Weather3
# add column
new_Weather4<-lapply(Weather, cbind,newcol=1:5)
new_Weather4
# Combine lapply with []

lapply(Weather,"[",1,1) # Extract avghigh_c for jan for each city
lapply(Weather,"[",1,)# Extract row for each city
lapply(Weather, "[", ,3) # Extract column for each city by month

# Adding your own functions
lapply(Weather,function(x)x[1,])
lapply(Weather,function(x)x[,12])
Weather
lapply(Weather,function(x) round((x[1,]-x[2,])/x[1,],2))

# sapply it means simply lapply result also make in matrix form
lapply(Weather,"[",1,1)
is.vector(lapply(Weather,"[",1,1))
sapply(Weather, "[",1,1)
sapply(Weather,"[",1,10:12)
lapply(Weather,rowMeans)
sapply(Weather,rowMeans)
round(sapply(Weather,rowMeans),2)
sapply(Weather,function(x) round((x[1,]-x[2,])/x[1,],2))
sapply(Weather,rowMeans,simplify = FALSE)
# Nested apply
lapply(Weather,function(x)apply(x, 1, max))
sapply(Weather,function(x)apply(x, 1, max))
# Another way to do
lapply(Weather,apply,1,max)
sapply(Weather,apply,1,max)

# Which.max
which.max(Chicago[1,])
names(which.max(Chicago[1,]))
apply(Chicago, 1, function(x) names(which.max(x)))
lapply(Weather,function(y)apply(y, 1, function(x) names(which.max(x))))
sapply(Weather,function(y)apply(y, 1, function(x) names(which.max(x))))




