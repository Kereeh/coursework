<<<<<<< HEAD

=======
<<<<<<< HEAD
>>>>>>> 05b4f4c04b63d9a212933ec47e347e3aedf96f28
########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')

########################################
# plot trip data
########################################

trips %>%
  summarise(quant = quantile(tripduration, prob=0.99)) %>%
  View

# plot the distribution of trip times across all rides
ggplot(trips, aes(x=tripduration)) +
  geom_histogram(position = "identity") +
  scale_y_continuous(label=comma) +
  scale_x_log10(label=comma)

# plot the distribution of trip times by rider type
ggplot(trips, aes(x=tripduration, color=usertype)) +
  geom_histogram(position = "identity", alpha = 0.2) +
  scale_y_continuous(label=comma) +
  scale_x_log10(label=comma)
  
# plot the number of trips over each day
trips %>% group_by(ymd) %>% 
  summarize(count = n()) %>%
  ggplot(aes(x = ymd, y = count)) + 
  geom_line()

trips <- mutate(trips, age = 2017-birth_year)

# plot the number of trips by gender and age
trips %>% 
  group_by(gender, age) %>%
  summarize(count=n()) %>%
  ggplot(aes(x = age, color= gender, y = count)) + 
  geom_point() +
  scale_y_continuous(label=comma) +
  ylim(0,250000) + 
  geom_smooth(fill = NA)
  
# plot the ratio of male to female trips by age
# hint: use the spread() function to reshape things to make it easier to compute this ratio
trips %>% group_by(gender, age) %>% 
  filter(gender!="Unknown") %>% 
  summarize(count=n()) %>% 
  spread(gender, count) %>% 
  mutate(ratio = Male/Female) %>%
  ggplot(aes(x=age, y=ratio, size=(Male+Female))) +
  xlim(15,70) +
  ylim(0,7.5) +
  geom_point() 


########################################
# plot weather data
########################################
# plot the minimum temperature over each day
weather %>%
  ggplot(aes(x=ymd, y=tmin)) +
  geom_point()

# plot the minimum temperature and maximum temperature over each day
# hint: try using the gather() function for this to reshape things before plotting
weather %>% View
  select(tmin,tmax,ymd) %>% 
  gather("range","temp",1:2) %>% 
  ggplot(aes(x=ymd, y=temp, color=range)) +
  geom_point()

#ribbon type of thing  
weather %>%
  ggplot(aes(x=ymd)) +
  geom_ribbon(aes(ymin=tmin, ymax=tmax), alpha=0.2) +
  geom_point(data = weather, aes(x=ymd, y=tmin, color="min temperature")) +
  geom_point(data = weather, aes(x=ymd, y=tmax, color ="max temperature"))
    
########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, 
# where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this
stuff <- trips %>% group_by(ymd) %>% summarize(count=n()) 
stuff2 <- inner_join(stuff, weather, by = "ymd") 
stuff2 %>%
  ggplot(aes(x=tmin, y=count, color=ymd)) +
  geom_point()


trips_with_weather %>%
  group_by(tmin,ymd) %>%
  summarise(count=n()) %>%
  ggplot(aes(x=tmin, y=count)) +
    geom_point()
  
# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new 
# T/F column to indicate this
trips_with_weather %>%
  mutate(subs = prcp >=quantile(prcp,0.8)) %>%
  group_by(tmin,ymd,subs) %>%
  summarise(count=n()) %>%
  ggplot(aes(x=tmin, y=count, color=subs)) +
  geom_point() +
  geom_smooth()

# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in 
# number of trips by hour of the day
# hint: use the hour() function from the lubridate package

# plot the above

# repeat this, but now split the results by day of the week or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
<<<<<<< HEAD
=======
########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides

# plot the distribution of trip times by rider type

# plot the total number of trips over each day

# plot the total number of trips (on the y axis) by age (on the x axis) and age (indicated with color)

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the spread() function to reshape things to make it easier to compute this ratio

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the gather() function for this to reshape things before plotting

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package

=======
=======
########################################
# load libraries
########################################

# load some packages that we'll need
library(tidyverse)
library(scales)

# be picky about white backgrounds on our plots
theme_set(theme_bw())

# load RData file output by load_trips.R
load('trips.RData')


########################################
# plot trip data
########################################

# plot the distribution of trip times across all rides

# plot the distribution of trip times by rider type

# plot the total number of trips over each day

# plot the total number of trips (on the y axis) by age (on the x axis) and age (indicated with color)

# plot the ratio of male to female trips (on the y axis) by age (on the x axis)
# hint: use the spread() function to reshape things to make it easier to compute this ratio

########################################
# plot weather data
########################################
# plot the minimum temperature (on the y axis) over each day (on the x axis)

# plot the minimum temperature and maximum temperature (on the y axis, with different colors) over each day (on the x axis)
# hint: try using the gather() function for this to reshape things before plotting

########################################
# plot trip and weather data
########################################

# join trips and weather
trips_with_weather <- inner_join(trips, weather, by="ymd")

# plot the number of trips as a function of the minimum temperature, where each point represents a day
# you'll need to summarize the trips and join to the weather data to do this

# repeat this, splitting results by whether there was substantial precipitation or not
# you'll need to decide what constitutes "substantial precipitation" and create a new T/F column to indicate this

# add a smoothed fit on top of the previous plot, using geom_smooth

# compute the average number of trips and standard deviation in number of trips by hour of the day
# hint: use the hour() function from the lubridate package

# plot the above

# repeat this, but now split the results by day of the week (Monday, Tuesday, ...) or weekday vs. weekend days
# hint: use the wday() function from the lubridate package
>>>>>>> 9b9e3a5c75035c70277fe8fb616d758b4739bef3
>>>>>>> 05b4f4c04b63d9a212933ec47e347e3aedf96f28
