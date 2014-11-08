library(foreign)
maya_applications <- read.dta(
  "C:/Documents and Settings/Ahlu/My Documents/IFMR/Credit Scoring/Mayavaram applications.dta")
names(maya_applications)[names(maya_applications)=="fathershusbandname"] <- "fatherhusbandname"
names(maya_applications)[names(maya_applications)=="ticketno"] <- "uniqueticketnumber"
var.labels <- attr(maya_applications,"var.labels")
data.key_app <- data.frame(var.name=names(maya_applications),var.labels)
#Calculate salary + business income, treat NA as 0
maya_applications$total_income<-rowSums(cbind(maya_applications[,"totalincomebusiness"]
                                        ,maya_applications[,"totalincomesalary"]),na.rm=T)
#maya_applications$total_income<-maya_applications$totalincomebusiness
                                  #+maya_applications$totalincomesalary
maya_applications$total_income_month<-maya_applications$total_income/12
#Calculate mean income by year
aggregate(maya_applications$total_income_month,
       by=list(maya_applications$year_application), 
       FUN = mean,na.rm=T)
#Calculate income s.d by year
aggregate(maya_applications$total_income_month,
          by=list(maya_applications$year_application), 
          FUN = sd,na.rm=T)
library(dplyr)
#Calculate total observations by year
years<-group_by(maya_applications[,c("year_application","total_income_month")]
                ,year_application)
summarise(years,n())
#Calculate observations for which data is available by year(same in this case)
years<-group_by(maya_applications[which(!is.na(maya_applications$total_income_month))
                ,c("year_application","total_income_month")]
                ,year_application)
summarise(years,n())
rm(years)
#names_dup<-ddply(maya_transactions,.(maya_transactions$name_changed),nrow)
#table(names_dup$V1)
#rm(names_dup)
#TABLE 5 - find number of tickets bought
table(group_size(group_by(maya_transactions,name_changed)))
