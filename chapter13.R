library(tidyverse)
library(nycflights13)

planes %>% 
  filter(engine != "Turbo-fan" & engine != "Turbo-jet")

planes %>% 
  count(tailnum) %>% 
  filter(n > 1)

flights %>% 
  count(year, month, day, tailnum, flight) %>% 
  filter(n > 1)

#Exercises
Lahman::Batting %>% 
  count(playerID, yearID, stint) %>% 
  filter(n > 1)

library("babynames")
babynames::babynames %>% 
  count(year, sex, name) %>% 
  filter(nn > 1)

library("nasaweather")
nasaweather::atmos %>% 
  count(lat, long, year, month) %>% 
  filter(n > 1)

library("fueleconomy")
fueleconomy::vehicles %>% 
  count(id) %>% 
  filter(n > 1)

# Mutating joins
flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier) %>% 
  left_join(airlines, by = "carrier")

# Defining the key column
flights2 %>% 
  left_join(weather)

flights2 %>% 
  left_join(airports, by = c("dest" = "faa"))

flights2 %>%
  left_join(airports, c("origin" = "faa"))

flights3 <- flights %>% 
  select(year:day, flight, dest, arr_delay) %>% 
  group_by(dest) %>% 
  summarize(avg_delay = mean(arr_delay, na.rm = TRUE))

airports %>% 
  semi_join(flights, c("faa" = "dest")) %>% 
  left_join(flights3, c("faa" = "dest")) %>%  
  ggplot(aes(lon, lat)) + 
    borders("state") +
    geom_point(aes(color = avg_delay)) + 
    coord_quickmap()

#2
airports1 <- airports %>% 
  select(faa, lat, lon)

flights %>% 
  select(year:day, origin, dest) %>% 
  left_join(airports1, c("dest" = "faa")) %>% 
  left_join(airports1, c("origin" = "faa"), suffix = c(".dest", ".origin"))


#3
planes1 <- planes %>% 
  select(tailnum, year)

flights4 <- flights %>% 
  select(year:day, dep_delay, tailnum) %>% 
  left_join(planes1, by = "tailnum", suffix = c(".flight", ".manufactured")) %>% 
  arrange(year.manufactured)
 
ggplot(flights4, mapping = aes(dep_delay, year.manufactured)) + 
  geom_point()

#Exercises
#1
flights %>% 
  filter(is.na(tailnum) == TRUE) #flights that don't have tailnum

flights %>% 
  anti_join(planes, by = "tailnum") %>% 
  count(carrier, sort = TRUE)

#3
vehicles %>% 
  semi_join(common)

#5
View(anti_join(flights, airports, by = c("dest" = "faa")))
View(anti_join(airports, flights, by = c("faa" = "dest")))

#6
flights %>% 
  filter(!is.na(tailnum)) %>% 
  count(tailnum, carrier) %>% 
  count(tailnum) %>% 
  filter(nn > 1)

carrier_transmulti_carrier_planes %>% 
  group_by(tailnum) %>% 
  mutate(
    carrier_num = seq_along(tailnum),
    carrier_num = paste0("carrier_", carrier_num)
  ) %>% 
  left_join(airlines, by = "carrier") %>% 
  select(-carrier) %>% 
  spread(carrier_num, name)

  
