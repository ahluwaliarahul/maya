#find number of members
members<-data.frame(maya_transactions[c("name","fatherhusbandname","doorno")])
to_remove <- which(members$name=="" & members$fatherhusbandname==""& members$doorno=="") #empty records
members<-members[-to_remove,]
members$duplicates_name<-duplicated(members$name)
members$dup_fname<-duplicated(members$fatherhusbandname)