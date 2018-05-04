#Chapter 11
library(tidyverse)
#Exercises
x <-  "12345.1345"
parse_number(x, locale = locale(grouping_mark = ",",decimal_mark = "."))

#4
custom_locale <- locale(date_format = "%d%m%y", time_format = "%h%m%s")

#7
d1 <- "January 1, 2010"
d2 <- "2015-Mar-07"
d3 <- "06-Jun-2017"
d4 <- c("August 19 (2015)", "July 1 (2015)")
d5 <- "12/30/14" # Dec 30, 2014
t1 <- "1705"
t2 <- "11:15:10.12 PM"

parse_date(d1, format = "%B %d, %Y")
parse_date(d2, format = "%Y-%b-%d")
parse_date(d3, format = "%d-%b-%Y")
parse_date(d4, format = "%B %d (%Y)")
parse_date(d5, format = "%m/%d/%y")
parse_time(t1, format = "%H%M")
parse_time(t2)

#Parsing a file
challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)

challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date()
  )
) #using double parser

tail(challenge)

challenge2 <- read_csv(readr_example("challenge.csv"), guess_max = 1002)
tail(challenge2)

challenge2 <- read_csv(readr_example("challenge.csv"),#read .csv file as character vector
                       col_types = cols(.default = col_character())) 

type_convert(challenge2)

challenge_input <- read_lines("challenge.csv")

#Writing to a file
write_csv(challenge, "challenge.csv")
write_rds(challenge, "challenge.rds") #write into RDs

install.packages("feather")
library(feather)
write_feather(challenge, "challenge.feather")
read_feather("challenge.feather")
