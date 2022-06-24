##-------------- Financial Analysis------------------------------------------------------------------------------

fin<- read.csv('C://Users//Dell//Desktop//R tutorials//advanced_R_tutorial//P3-Future-500-The-Dataset.csv',na.strings = c(''))
head(fin)
colnames(fin)
str(fin)

?gsub()

#  sub() and gsub()          For replace 

fin$Expenses <- gsub('Dollars', '', fin$Expenses)
fin$Expenses <- gsub(',', '', fin$Expenses)
head(fin,5)
str(fin)
fin$Revenue <- gsub('\\$', '', fin$Revenue)
head(fin,5)
fin$Revenue <- gsub(',', '', fin$Revenue)
head(fin,5)

fin$Growth <- gsub('%', '', fin$Growth)
head(fin,4)
str(fin)
fin$Expenses<- as.numeric(fin$Expenses)
fin$Revenue<- as.numeric(fin$Revenue)
fin$Growth<- as.numeric(fin$Growth)
str(fin)
summary(fin)

##-------------------------------Dealing With Missing Data-----------------------------------------------------

# colsum(is.na(data frame))
# sum(is.na(data frame$column name)
# Missing values can be treated using following methods :
# Mean/ Mode/ Median Imputation: Imputation is a method to fill in the missing values with estimated ones

is.na(fin)
sum(is.na(fin))
sum(is.na(fin$Industry))
colnames(fin)
#fin$Industry
?complete.cases()
complete.cases(fin)
fin[!complete.cases(fin),]
sum(is.na(fin))

# fin2<- read.csv('C://Users//Dell//Desktop//R tutorials//advanced_R_tutorial//P3-Future-500-The-Dataset.csv',na.strings = 
#                  c('any') )
# sum(is.na(fin2))
# fin2[!complete.cases(fin2),]
str(fin)

#----------------- How to filter missing data------------------------------------
#--------------------------------------------------------------------------------
  
head(fin)
fin[fin$Revenue == 9746272,]

# Which
?which  #Give the TRUE indices of a logical object, 
# allowing for array indices.

which(fin$Revenue == 9746272)
fin[which(fin$Revenue == 9746272),]
fin[which(fin$Employees == 45),]
tail(fin)

fin[which(fin$Inception ==  2012),]

#fin[fin$Expenses ==  NA,]

# a <- c(1,23,32,NA,34,11)
# is.na(a)
# fin[which(is.na(a)),]

fin[is.na(fin$Industry),]

fin[is.na(fin$State),]

##---------------------- Removing records with missing data---------------------------------------------
#-----------------------

fin_back <- fin

fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),] # Opposite

fin <- fin[!is.na(fin$Industry),]
fin
fin[!complete.cases(fin),]


