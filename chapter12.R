# Chapter 12: Tidy Data
library(tidyverse)
library(ggplot2)

table1 %>% 
  mutate(rate = cases / population * 10000)

table1 %>% 
  count(year, wt = cases)

ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color =country))

#Exercises
#2 
#table 2
tb2_cases <- filter(table2, type == "cases")[["count"]]
tb2_country <- filter(table2, type == "cases")[["country"]]
tb2_year <- filter(table2, type == "cases")[["year"]]
tb2_population <- filter(table2, type == "population")[["count"]]
table2_tidy <- tibble(country = tb2_country,
                      year = tb2_year,
                      rate = tb2_cases/ tb2_population * 10000)

#table4
table4_rate <- tibble(country = table4a[["country"]],
                      "Rate 1999" = table4a[["1999"]] / table4b[["1999"]] * 10000,
                      "Rate 2000" = table4a[["2000"]] / table4b[["2000"]] * 10000
                      )

#Gathering
table4a <- table4a %>% 
  gather('1999', '2000', key = "year", value = "cases")
table4b <-  table4b %>% 
  gather('1999', '2000', key = 'year', value = 'population')
left_join(table4a, table4b)

spread(table2, key = type, value = count)

#Exercise
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", "2015", "2016")


#3
people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

gather(people, name, value, key = key, value = value)

people <- tribble(
  ~name,             ~key,    ~value, ~obs,
  #-----------------|--------|------|------
  "Phillip Woods",   "age",       45, 1,
  "Phillip Woods",   "height",   186, 1,
  "Phillip Woods",   "age",       50, 2,
  "Jessica Cordero", "age",       37, 1,
  "Jessica Cordero", "height",   156, 1
)
spread(people, key, value)

#4
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

gather(preg, sex, count, male, female) %>% 
  mutate(female = sex == "female",
         pregnant = pregnant == "yes") %>% 
  select(-sex)

#Separating and uniting
table3 %>% 
  separate(rate, into = c("cases", "population"))

