# Abraham Choi, Christina Berardi, Edgar Delgado, Frieden Stone
# Introduction to Data Science
# Baseball Data Cleanup

setwd("~/Desktop/DS Project/")

library(plyr)
require(gdata)

mb <- read.csv("moneyball-2.csv", header=TRUE)
head(mb)
str(mb)
summary(mb)
names(mb) <- tolower(names(mb))

# clean/format the data with regular expressions

# OFFENSE
mb$bat.h <- as.numeric(gsub("[^[:digit:]]","",mb$team_batting_h))
mb$bat.2b <- as.numeric(gsub("[^[:digit:]]","",mb$team_batting_2b))
mb$bat.3b <- as.numeric(gsub("[^[:digit:]]","",mb$team_batting_3b))
mb$bat.hr <- as.numeric(gsub("[^[:digit:]]","",mb$team_batting_hr))
mb$bat.bb <- as.numeric(gsub("[^[:digit:]]","",mb$team_batting_bb))
mb$bat.hbp <- as.numeric(gsub("[^[:digit:]]","",mb$team_batting_hbp))
mb$bat.so <- as.numeric(gsub("[^[:digit:]]","",mb$team_batting_so))

# DEFENSE
mb$pitch.h <- as.numeric(gsub("[^[:digit:]]","",mb$team_pitching_h))
mb$pitch.hr <- as.numeric(gsub("[^[:digit:]]","",mb$team_pitching_hr))
mb$pitch.bb <- as.numeric(gsub("[^[:digit:]]","",mb$team_pitching_bb))
mb$pitch.so <- as.numeric(gsub("[^[:digit:]]","",mb$team_pitching_so))

# FIELDING
mb$field.e <- as.numeric(gsub("[^[:digit:]]","",mb$team_fielding_e))
mb$field.dp <- as.numeric(gsub("[^[:digit:]]","",mb$team_fielding_dp))

# BASERUN 
mb$baserun.sb <- as.numeric(gsub("[^[:digit:]]","",mb$team_baserun_sb))
mb$baserun.cs <- as.numeric(gsub("[^[:digit:]]","",mb$team_baserun_cs))

# find the sum of missing values for attributes
sum(is.na(mb$bat.h))
sum(is.na(mb$bat.2b))
sum(is.na(mb$bat.3b))
sum(is.na(mb$bat.hr))
sum(is.na(mb$bat.hbp))    # 2085 NA
sum(is.na(mb$bat.bb))
sum(is.na(mb$bat.so))     # 102 NA

sum(is.na(mb$pitch.so))   # 102 NA
sum(is.na(mb$pitch.h))
sum(is.na(mb$pitch.hr))
sum(is.na(mb$pitch.bb))

sum(is.na(mb$field.e))
sum(is.na(mb$field.dp))   # 286 NA

sum(is.na(mb$baserun.sb)) #131 NA
sum(is.na(mb$baserun.cs)) # 772 NA

# delete attributes bat.hbp, baserun.sb, baserun.cs
# bat.hbp: missing 2085 entries out of 2277
# baserun.cs: missing 772 entries out of 2277
# baserun.sb: reflects off of baserun.cs and is greatly
# overestimated according to ScienceDaily. https://www.sciencedaily.com/releases/2011/09/110929122932.htm
mb = subset(mb, select = -c(bat.hbp, baserun.cs, baserun.sb) )

#delete the old columns
mb <- mb[-c(3,4,5,6,7,8,9,10,11,12,13,14,15,16,17)]

# delete the rest of NA values (delete all rows with missing values)
mb = na.omit(mb)

# export new table
write.csv(mb,"~/Desktop/MoneyBall-Clean.csv")








