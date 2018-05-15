#Chapter 14 Strings
library(tidyverse)
library(stringr)

x <- c("\"", "\\")

writeLines(x)

str_length(c("a", "R for data science", NA))

str_c("x", "y")
str_c("x", "y", sep = ", ")

str_c("prefix-", c("a", "b", "c"), "-suffix", collapse = "")

x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "haw")

#Exercises
#3
test_string <- "abcde" 
str_sub(test_string,
        str_length(test_string) / 2 + 1, str_length(test_string) / 2 + 1)

#6
str_sep <- function(x, sep = ", ", last = ", and ") {
  if(length(x) > 1) {
    str_c(str_c(x[-length(x)], collapse = sep),
          x[length(x)],
          sep = last)
  }
  else {
    x
  }
}

#Matching pattern with regular expressions
#2
str_view("\"'\\", "\"'\\\\")

#Anchor
#Exercise
str_view(c("$^$", "abc$^$abc"), 
         "$\\^\\$")

