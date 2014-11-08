library(foreign)
maya_transactions <- read.dta("C:/Documents and Settings/Ahlu/My Documents/IFMR/Credit Scoring/Mayavaram transactionsv2.dta")
var.labels <- attr(maya_transactions,"var.labels")
data.key <- data.frame(var.name=names(maya_transactions),var.labels)
# Changing one value of 99 in the years to 1999
maya_transactions[,4]<- replace(maya_transactions[,4],maya_transactions[,4]==99,1999) 
# Changing one value of 5 in duration to 50, based on others in same group(107)
maya_transactions[,10]<- replace(maya_transactions[,10],maya_transactions[,10]==5,50) 
# Changing one value of 6 in duration to 60, based on others in same group(40)
maya_transactions[,10]<- replace(maya_transactions[,10],maya_transactions[,10]==6,60) 
# Changing chitamount of two observations in group(s) 17, based on others in group(s)
maya_transactions[,23]<- replace(maya_transactions[,23],maya_transactions[,23]==10000 &
                                 maya_transactions[,9]==17,150000) 
maya_transactions[,23]<- replace(maya_transactions[,23],maya_transactions[,23]==500000 &
                                   maya_transactions[,9]==17,300000) 
