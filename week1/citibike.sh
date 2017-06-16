#/bin/bash
#
# add your solution after each of the 10 comments below
#

echo 'count the number of unique stations'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f5,9 | tr , '\n' | sort | uniq | wc -l

echo 'count the number of unique bikes'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f12 | sort | uniq | wc -l

echo 'count the number of trips per day'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f2 | cut -c2-11 | sort | uniq -c | sort -nr

echo 'find the day with the most rides'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f2 | cut -c2-11 | sort | uniq -c | sort -nr | head -n1

echo 'find the day with the fewest rides'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f2 | cut -c2-11 | sort | uniq -c | sort -nr | tail -n1

echo 'find the id of the bike with the most rides'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f12 | cut -d, -f12 | sort | uniq -c | sort -nr | head -n1

echo 'count the number of rides by gender and birth year'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f14,15 | sort | uniq -c | sort -nr 

echo 'count the number of trips that start on cross streets that both contain numbers (e.g., "1 Ave & E 15 St", "E 39 St & 2 Ave", ...)'
sed 1d 201402-citibike-tripdata.csv | cut -d, -f5 | grep '.*[0-9].*&.*[0-9]' | wc -l

echo 'compute the average trip duration'
sed 1d 201402-citibike-tripdata.csv | tr -d '"' | awk '{sum+=$1} END {if(NR>0) print sum/NR}'

