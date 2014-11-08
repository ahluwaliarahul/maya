#find individuals that are reported as separate members but are not
members<-data.frame(maya_transactions)
to_remove <- which(members$name_changed=="" & members$fatherhusbandname==""& members$doorno=="")  # empty records
members<-members[-to_remove,]
members$duplicates_name<-(duplicated(members$name_changed) | duplicated(members$name_changed, fromLast=TRUE))  # Mark duplicate names
members$dup_fname<-(duplicated(members$fatherhusbandname) | duplicated(members$fatherhusbandname, fromLast=TRUE))  # Mark duplicate father names
#members$dup_fname_not_name<- (!members$duplicates_name & members$dup_fname)  # Mark records with duplicate father names, but not duplicate names 
#fnames_fname_dup<-members[members$dup_fname,2] #create vector with duplicate fathers names 
reducedmem <- members[(members$dup_fname & !members$duplicates_name),]  # "create dataframe of members who have father names 
                                                                  # in common with other members, but not their own name
newmem<-reducedmem[order(reducedmem$fatherhusbandname),]
members$dup_door <- (duplicated(members$doorno) | duplicated(members$doorno, fromLast=TRUE))  # duplicate door number
#members$dup_door_not_name<- (!members$duplicates_name & members$dup_door)  # Mark records with duplicate doorno, but not duplicate names
#doors_door_dup<-members[members$dup_door_not_name,3]
reducedmem_door <- members[(members$dup_door & !members$duplicates_name),]
newdoor<-reducedmem_door[order(reducedmem_door$doorno,reducedmem_door$name),]
View(newdoor)
View(newmem)
reducedmem <- members[(members$duplicates_name),] # duplicate name 
newmem_next<-reducedmem[order(reducedmem$name,reducedmem$fatherhusbandname),]
reducedmem_door <- members[(!members$dup_door & members$duplicates_name),] # duplicate name but diff door
newdoor_next<-reducedmem_door[order(reducedmem$name,reducedmem$doorno),]
View(newdoor_next)
View(newmem_next)
rm(to_remove)
rm(reducedmem)
rm(reducedmem_door)
rm(newdoor)
rm(newmem)
rm(members)
rm(newdoor_next)
rm(newmem_next)  
