# Upload required file
util<- read.csv(file.choose())
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

#?POSIXct
util$PosixTime<- as.POSIXct(util$Timestamp, format="%d/%m/%Y %H:%M")
head(util,12)

# Delete and arrange column
util$Timestamp<-NULL
head(util)
util2<- util[,c(4,1,2,3)]
head(util2)

# What is list?
RL1<- util2[util2$Machine=="RL1",]
RL1
summary(RL1)
# Remove other machine name then convert RL1 in factor

RL1$Machine<- factor(RL1$Machine)
summary(RL1)
# 

util_stats_RL1<- c(min(RL1$Percent.Utilisation,na.rm =TRUE),
                   mean(RL1$Percent.Utilisation,na.rm =TRUE),
                   max(RL1$Percent.Utilisation,na.rm =TRUE),
                   var(RL1$Percent.Utilisation,na.rm =TRUE))
util_stats_RL1

util_under_90<- length(which(RL1$Percent.Utilisation<0.9))>0
util_under_90

util_RL1_list<- list("RL1",util_stats_RL1,util_under_90)
util_RL1_list
util_RL1_list[2]
util_RL1_list[[2]][3]
# Naming of list

names(util_RL1_list)<- c("Machine","Stats","LowThreshold")
util_RL1_list

# Remove it to check another way

rm(util_RL1_list)
util_RL1_list

# Another way of list creation like data frame

util_RL1_list<- list(Machine="RL1",Stats="util_stats_RL1",LowThreshold="util_under_90")
util_RL1_list
util_RL1_list[1]
util_RL1_list[[2]][1]
util_RL1_list$Machine
util_RL1_list$Stats
util_stats_RL1

# Time series plot

library(ggplot2)
p<- ggplot(data=util)
my_plot<-p+geom_line(aes(x=PosixTime,y=Percent.Utilisation,
                         color=Machine),
                     size=1.2)+facet_grid(Machine~.)+ 
  ggtitle("Machines Utilisation")+
  geom_hline(yintercept = 0.90,
             color="Gray",size=1.3,linetype=3)+
    xlab("Posix Time")+ylab("Percent.Utilisation")+ 
    
    theme(plot.title = element_text(hjust=0.5,size = 40,color = "Blue"),
          axis.title.x = element_text(size=20,color="Dark Green"),
          axis.title.y = element_text(size=20,color="Dark Green"))


my_plot



