library(tidyverse)

!is.infinite(1/0)

#Exercises
x <- c(1, NA)

mean(is.na(x))
sum(!is.finite(x))

is.nan("abc")
