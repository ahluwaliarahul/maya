#Table 2
maya_transactions <- read.dta("C:/Documents and Settings
                              /Ahlu/My Documents/IFMR/Credit Scoring/
                              Mayavaram transactionsv2.dta")
maya_transactions<-maya_transactions[!duplicated(maya_transactions$uniquegroup)
                                     ,] #temporary unique schemes
#Schemes started by year
tapply(maya_transactions$year_c,maya_transactions$year_c, FUN = length)
#Schemes started above or at subscription of 3000 by year
tapply(maya_transactions$year_c[maya_transactions$subsrs>=3000],
       maya_transactions$year_c[maya_transactions$subsrs>=3000], FUN = length)
#Schemes started below or at duration of 30 months by year
tapply(maya_transactions$year_c[maya_transactions$monthduration<=30],
       maya_transactions$year_c[maya_transactions$monthduration<=30], 
       FUN = length)
