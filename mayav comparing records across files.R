library(foreign)
maya_applications <- read.dta(
                      "C:/Documents and Settings/Ahlu/My Documents/IFMR/Credit Scoring/Mayavaram applications.dta")
names(maya_applications)[names(maya_applications)=="fathershusbandname"] <- "fatherhusbandname"
names(maya_applications)[names(maya_applications)=="ticketno"] <- "uniqueticketnumber"
var.labels <- attr(maya_applications,"var.labels")
data.key_app <- data.frame(var.name=names(maya_applications),var.labels)
#Function to compare two dataframes and return rows that are not the same 
fun.12 <- function(x.1,x.2,...){
       x.1p <- do.call("paste", x.1)
       x.2p <- do.call("paste", x.2)
       x.1[! x.1p %in% x.2p, ]
   }
#Cull out appropriate columns from transactions and applications
mtrans_names<-data.frame(maya_transactions$name,
                         maya_transactions$uniquegroup,
                         maya_transactions$uniqueticketnumber)
mapp_names<-data.frame(maya_applications$name,
                       maya_applications$uniquegroup,
                       maya_applications$uniqueticketnumber)
mapp_names[,2]<-gsub("\\s","",mapp_names[,2]) #remove spaces from uniquegroup
#Compare trans and applications and return those rows from trans which are not in app
not_common<-fun.12(mtrans_names,mapp_names)
not_common<-merge(not_common,mapp_names,
                  by.x=c("maya_transactions.uniquegroup",
                         "maya_transactions.uniqueticketnumber"),
                  by.y=c("maya_applications.uniquegroup",
                         "maya_applications.uniqueticketnumber"),
                  all.x=T)
write.table(not_common,
            "C:/Documents and Settings/Ahlu/My Documents/IFMR/Credit Scoring/not_common.txt"
             , sep=";") 
#Compare trans and applications and return those rows from app which are not in trans
not_common2<-fun.12(mapp_names,mtrans_names)
not_common2<-merge(not_common2,mtrans_names,
                  by.y=c("maya_transactions.uniquegroup",
                         "maya_transactions.uniqueticketnumber"),
                  by.x=c("maya_applications.uniquegroup",
                         "maya_applications.uniqueticketnumber"),
                  all.x=T)
write.table(not_common2,
            "C:/Documents and Settings/Ahlu/My Documents/IFMR/Credit Scoring/not_common2.txt"
            , sep=";") 

auctions <- read.dta("C:/Documents and Settings/Ahlu/My Documents/IFMR/Credit Scoring/Mayavaram auctions.dta")
var.labels <- attr(auctions,"var.labels")
data.key_auc <- data.frame(var.name=names(auctions),var.labels)


rm(not_common2)
rm(not_common)
rm(mapp_names)
rm(mtrans_names)