#Make dataset of members with multiple tickets
multi_mems<-maya_transactions[(duplicated(maya_transactions$name_changed) 
                          | duplicated(maya_transactions$name_changed
                                       , fromLast=TRUE))
                          ,]
#Create commencement date
multi_mems$date_c<-ISOdate(multi_mems$year_c,multi_mems$month_c,
                           multi_mems$day_c,tz="Asia/Calcutta")
#Sort on name and date
multi_mems<-multi_mems[order(multi_mems$name_changed, multi_mems$date_c),]
#Differences between previous commencement date and current and summarise
library(dplyr)
multi_mems<-ddply(multi_mems, .(name_changed)
                  , transform, diff=c(NA,diff(date_c)))
multi_mems$diff_months<-multi_mems$diff/30.43
summary(multi_mems$diff_months,na.rm=T)
sd(multi_mems$diff_months,na.rm=T)
#Create termination date
multi_mems$date_t<-ISOdate(multi_mems$year_t,multi_mems$month_t,
                           multi_mems$day_t,tz="Asia/Calcutta")
#Create lagged termination date variable by group
multi_mems <- 
  multi_mems %>%
  group_by(name_changed) %>%
  mutate(lag.date_t = lag(date_t, 1))
#Time between starting date of next scheme and ending date of previous scheme
multi_mems$diff_date_c_t <- multi_mems$date_c - multi_mems$lag.date_t
multi_mems$diff_c_t_months <- as.numeric(multi_mems$diff_date_c_t)/30.43
summary(multi_mems$diff_c_t_months) #negative value implies next scheme started before ending last
sd(multi_mems$diff_c_t_months,na.rm=T)
#Number of people participating in more than one scheme at a time
multi2<-ddply(multi_mems, .(name_changed)
              ,summarise, min(diff_date_c_t,na.rm=T))
length(multi2[multi2$..1<0,1])
