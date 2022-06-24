# FVT 
z<- c("2","3","11","11","11","2","3")
z
z<- factor(z)
z
typeof(z)
y<-as.numeric(z)
y
x<-as.numeric(as.character(z))
x
typeof(x)
# FVT error

fin<- read.csv(file.choose(),na.strings = c(""))
head(fin,n=4)
str(fin)
# let us see factor of profit
#fin$Profit<- factor(fin$Profit)
#str(fin)
#summary(fin)
# let us change profit factor to again in integer
#fin$Profit<- as.numeric(fin$Profit)
summary(fin)
head(fin)  # see profit clearly it is wrong

# rectify factor error

#  fin$Profit<- as.numeric(as.character(fin$Profit))

# To remove commas and dollar sign from data

# use gsub() and sub()
?gsub
head(fin,4)
fin$Expenses<- gsub("Dollars","",fin$Expenses)
head(fin,3)
fin$Expenses<- gsub(",","",fin$Expenses)
head(fin,3)

# Remove comma and dollar from revenue column
fin$Revenue<-gsub("\\$","",fin$Revenue)
fin$Revenue<-gsub(",","",fin$Revenue)
fin$Growth<- gsub("\\%","",fin$Growth)
head(fin,4)
str(fin)
typeof(fin$Revenue)
# Change char into int for Revenue,Expenses, Profit

# as.numeric is enough in this case bcoz vector already converted into chr
fin$Revenue<- as.numeric(fin$Revenue)
fin$Expenses<-as.numeric(fin$Expenses)
fin$Growth<- as.numeric(fin$Growth)
head(fin,4)
str(fin)

# An elegant way to see missing data
?complete.cases
complete.cases(fin)
head(fin,24)
fin[!complete.cases(fin),]
# But we have seen more data is missing but R is not counting here empty cell.
# In beginning of data import we have to use na.strings=c("any")


# use of which 

fin[fin$Inception=="2010",]

# But above formula include na also

fin[which(fin$Inception=="2010"),]
fin[is.na(fin$Revenue),]
sum(is.na(fin))
# Create always back up data to save yourself 

fin_backup<- fin

# To see all empty or NA values and remove

# Remove NAs from Industry

fin[!complete.cases(fin$Industry),]
fin[is.na(fin$Industry),]
fin<-fin[!is.na(fin$Industry),]
fin
sum(is.na(fin$Industry))

# Resetting data frames rows or Index
row.names(fin)<-1:nrow(fin)

# Fix values of NA in case of state
fin[is.na(fin$State),]

fin[is.na(fin$State) & fin$City=="New York","State"]<-"NY"

fin[is.na(fin$State) & fin$City=="San Francisco","State"]<-"CA"

fin[is.na(fin$State),]
fin[!complete.cases(fin),]

# Median Imputation method

med_Indu_retail<- median(fin[fin$Industry=="Retail","Employees"],na.rm = TRUE)
med_Indu_retail
fin[is.na(fin$Employees)& fin$Industry=="Retail","Employees"]<-med_Indu_retail
fin[!complete.cases(fin),]

med_Indu_Financial<- median(fin[fin$Industry=="Financial Services","Employees"],na.rm = TRUE)
med_Indu_Financial
fin[is.na(fin$Employees)& fin$Industry=="Financial Services","Employees"]<-med_Indu_Financial

fin[!complete.cases(fin),]

med_Cons_growth<- median(fin[fin$Industry=="Construction","Growth"],na.rm = T)
fin[is.na(fin$Growth)& fin$Industry=="Construction","Growth"]<- med_Cons_growth
fin[8,]

fin[!complete.cases(fin),]

med_Cons_reve<- median(fin[fin$Industry=="Construction","Revenue"],na.rm = T)
med_Cons_reve
fin[is.na(fin$Revenue)&fin$Industry=="Construction","Revenue"]<- med_Cons_reve
fin[!complete.cases(fin),]

med_expenses<- median(fin[fin$Industry=="Construction","Expenses"],na.rm = T)
med_expenses
fin[is.na(fin$Expenses)&fin$Industry=="Construction"&is.na(fin$Profit),"Expenses"]<- med_expenses
fin[!complete.cases(fin),]

fin[is.na(fin$Profit),"Profit"]<- fin[is.na(fin$Profit),"Revenue"]-fin[is.na(fin$Profit),"Expenses"]

fin[!complete.cases(fin),]

fin[is.na(fin$Expenses),"Expenses"]<-fin[is.na(fin$Expenses),"Revenue"]-fin[is.na(fin$Expenses),"Profit"]


fin[!complete.cases(fin),]
fin[15,]

#-------------------Visualisation data wrangling is over---------------------------------------------------

#They have requested the following charts:

# A scatterplot classified by industry showing revenue, expenses, profit
# A scatterplot that includes industry trends for the expenses~revenue relationship
# BoxPlots showing growth by industry




library(ggplot2)

# A scatterplot classified by industry showing revenue, expenses, profit

u<-ggplot(fin, aes(x=Revenue,y=Expenses,size=Profit,color=Industry))
u+geom_point()

# A scatterplot that includes industry trends for the expenses~revenue relationship

d<- ggplot(fin,aes(x=Revenue,y=Expenses,color=Industry))
d+geom_point()+geom_smooth(fill=NA,size=1.3)

# BoxPlots showing growth by industry

f<- ggplot(fin,aes(x=Industry,y=Growth,color=Industry))
f+geom_jitter()+geom_boxplot(size=1,alpha=0.5,outlier.colour = NA)+
  theme(axis.title.x = element_text(size=20,color="Dark Green"),
        axis.title.y = element_text(size=20,color="Dark Green"))+ ylim(0,30)

            




