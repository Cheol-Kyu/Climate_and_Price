## 환경 및 라이브러리 셋팅
library(readr);library(ggplot2);library(dplyr); library(stringr);library(stats)
setwd("c:/Users/ray67/.R")


## 데이터셋 불러오기
# Allen-Unger price set
allen <- read.csv('./Allen-Unger/all_commodities.csv')
allen <- allen[,-c(8,9)]

# Climate datasets
climate_city <- read.csv('./Climate/GlobalLandTemperaturesByCity.csv',encoding='UTF-8')
climate_MC <- read.csv('./Climate/GlobalLandTemperaturesByMajorCity.csv',encoding='UTF-8')
climate_s <- read.csv('./Climate/GlobalLandTemperaturesByState.csv',encoding='UTF-8')
climate_con <- read.csv('./Climate/GlobalLandTemperaturesByCountry.csv',encoding='UTF-8')
climate_g <- read.csv('./Climate/GlobalTemperatures.csv',encoding='UTF-8')

'Location' -> colnames(climate_city)[4]
'Location' -> colnames(climate_s)[4]
'Location' -> colnames(climate_con)[4]

climate_city$dt <- as.Date(climate_city$dt)
climate_MC$dt <- as.Date(climate_MC$dt)
climate_s$dt <- as.Date(climate_s$dt)
climate_con$dt <- as.Date(climate_con$dt)
climate_g$dt <- as.Date(climate_g$dt)



## 양측 데이터 모두 존재하는 지역만 남기기
# 리스트
loc_list <- read.csv("./dataset/location_list.csv",encoding='UTF-8')
colnames(loc_list) <- 'Location'
loc_list

# allen-unger
allen_r <- merge(allen,loc_list,by='Location')
colnames(allen_r)[2]<-"dt"

# climate_city
colnames(climate_city)[4] <- 'Location'
climate_city$dt <- as.Date(climate_city$dt)
climate_city_L <- merge(climate_city,loc_list,by='Location')
climate_city_L <- climate_city_L %>% arrange(Location,dt)
colnames(climate_city_L)[3:4] <- c("Avg.Tem","Avg.Vol")
climate_city_L <- climate_city_L %>% filter(dt>=as.Date('1753-01-01')&dt<as.Date('2013-01-01'))

colnames(climate_s)[4] <- 'Location'
climate_s$dt <- as.Date(climate_s$dt)
climate_state_L <- merge(climate_s,loc_list,by='Location')
climate_state_L <- climate_state_L %>% arrange(Location,dt)
colnames(climate_state_L)[3:4] <- c("Avg.Tem","Avg.Vol")
climate_state_L <- climate_state_L %>% filter(dt>=as.Date('1753-01-01')&dt<as.Date('2013-01-01'))

colnames(climate_con)[4] <- 'Location'
climate_con$dt <- as.Date(climate_con$dt)
climate_con_L <- merge(climate_con,loc_list,by='Location')
climate_con_L <- climate_con_L %>% arrange(Location,dt)
colnames(climate_con_L)[3:4] <- c("Avg.Tem","Avg.Vol")
climate_con_L <- climate_con_L %>% filter(dt>=as.Date('1753-01-01')&dt<as.Date('2013-01-01'))

# csv 파일로 저장
write.csv(allen_r,"./dataset/Allen_L.csv")
write.csv(climate_city_L,"./dataset/climate_city_L.csv")
write.csv(climate_state_L,"./dataset/climate_state_L.csv")
write.csv(climate_con_L,"./dataset/climate_con_L.csv")
