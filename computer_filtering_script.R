install.packages("tidyverse")#Must install package to use the tidyverse library
install.packages("lubridate")#Must install package to use the lubridate library
library(tidyverse)# This is used in order to get to readr and dplyr
library(readr)#Used to read csv files
library(lubridate)#Used to change Computer successful scan date from chr to dttm data type
library(dplyr)#Use to arrange by computer name

computernames <- read_csv("Workstations By Site.csv")#Read csv file
computername_ <- read.csv("computer.csv")#Read second csv file that has the list of computers I need information about
computername$'Computer Successful Scan Date' <- mdy_hm(computernames$'Computer Successful Scan Date')#Convert computer Successful Scan date from chr to dttm
joined <- left_join(computernames_, computernames, by = c("Computer.Serial.Number" = "Computer Serial Number"))#using the left table as a filter for the information I need from the right table
joined <- joined %>%filter(! duplicated('Computer.Serial.Number'))#Remove duplicates
status <- select(joined, "Computer.Serial.Number", "Computer Current User", "Computer Successful Scan Data", "SP/Release")#selecting the columns management is wanting information for
write.csv(status,"C:\\R\\RDQ Search\\Computer_Status.csv",row.names = FALSE)#Export results to csv file