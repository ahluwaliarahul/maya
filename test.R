library(foreign)
maya_transactions <- read.dta("C:/Documents and Settings/Ahlu/My Documents/IFMR/Credit Scoring/Mayavaram transactionsv2.dta")
var.labels <- attr(maya_transactions,"var.labels")
data.key <- data.frame(var.name=names(maya_transactions),var.labels)
length(unique(maya_transactions$uniquegroup)) #Total number of schemes in transaction file
table(maya_transactions$noofticketstaken) #Number of tickets taken in transaction file
length(unique(maya_transactions$name_changed)) #Total members
range(maya_transactions$year_c,na.rm=T)  #starting point of time covered in dataset
range(maya_transactions$year_t,na.rm=T)  #ending point of time covered
range(maya_transactions$chitamount,na.rm=T) #Range of Chit Values
range(maya_transactions$subsrs,na.rm=T) #Range of monthly contribution
range(maya_transactions$monthduration,na.rm=T) #Range of scheme duration
