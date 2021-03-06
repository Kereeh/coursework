library(tidyverse)
library(lubridate)

########################################
# READ AND TRANSFORM THE DATA
########################################

# read one month of data
trips <- read_csv('201402-citibike-tripdata.csv')

# replace spaces in column names with underscores
names(trips) <- gsub(' ', '_', names(trips))

# convert dates strings to dates
# trips <- mutate(trips, starttime = mdy_hms(starttime), stoptime = mdy_hms(stoptime))

# recode gender as a factor 0->"Unknown", 1->"Male", 2->"Female"
trips <- mutate(trips, gender = factor(gender, levels=c(0,1,2), labels = c("Unknown","Male","Female")))

#convert birthyear type from character to string
trips <- mutate(trips, birth_year = as.numeric(birth_year))

########################################
# YOUR SOLUTIONS BELOW
########################################

# count the number of trips (= rows in the data frame)
nrow(trips)

# find the earliest and latest birth years (see help for max and min to deal with NAs)
summarize(trips)
max(trips[,"birth_year"], na.rm=T)
min(trips[,"birth_year"], na.rm=T)

# use filter and grepl to find all trips that either start or end on broadway
(filter(trips, grepl('Broadway', start_station_name) | grepl('Broadway', end_station_name)))

# do the same, but find all trips that both start and end on broadway
(filter(trips, grepl('Broadway', start_station_name) , grepl('Broadway', end_station_name)))

# find all unique station names
unique(combine(trips[,"start_station_name"],trips[,"end_station_name"]))

# count the number of trips by gender
trips %>% group_by(gender) %>% summarize(count = n())

# compute the average trip time by gender
trips %>% group_by(gender) %>% summarize(mean_duration = mean(tripduration) /60)

# comment on whether there's a (statistically) significant difference
trips %>% group_by(gender) %>% summarize(sd_duration = sd(tripduration) /60)

# find the 10 most frequent station-to-station trips
trips %>% group_by(start_station_name, end_station_name) %>% summarize(count = n()) %>% arrange(desc(count))
t <- count(trips, start_station_name, end_station_name, sort=TRUE)
t[1:10,]

# find the top 3 end stations for trips starting from each start station
trips %>% group_by(start_station_name, end_station_name) %>% summarize(count = n()) %>% arrange(desc(count)) %>% arrange(start_station_name) %>% top_n(3) %>% View


# find the top 3 most common station-to-station trips by gender
trips %>%
  group_by(gender, start_station_name, end_station_name) %>%
  summarize(count = n()) %>%
  arrange(-count) %>%
  group_by(gender) %>%
  top_n(3) %>%
  View

# find the day with the most trips
# tip: first add a column for year/month/day without time of day (use as.Date or floor_date from the lubridate package)
trips<-trips%>%mutate(ymd = as.Date(starttime)) %>% View
trips %>% group_by(ymd) 
# compute the average number of trips taken during each of the 24 hours of the day across the entire month
# what time(s) of day tend to be peak hour(s)?
