#Functions

rescales01 <- function(x) {
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

#Exercises
rescales01(c(0, 5, 10))

weight <- function(x) {
  x / sum(x, na.rm = TRUE)
}

weight(c(1, 2, 3))

#coefficient variation
coeff_var <- function(x) {
  sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)
}

coeff_var(c(1, 2, 3))     
x <- c("abc", "dfg", "asdf")
x[-length(x)]

#Exercises
#2 Greeting
greeting <- function (h = hour(now()), m = minute(now())) {
  minutes_from_midnight <- h * 60 + m
  if (minutes_from_midnight >= 0 && minutes_from_midnight < 720) {
    "Good morning"
  } else if (minutes_from_midnight >= 720 && minutes_from_midnight < 1080) {
    "Good afternoon"
  } else {
    "Good evening"
  }
}

greeting()

#4
temp <- seq(-10, 50, by = 5)
cut(temp, 5, c(Inf, 0, 10, 20, 20, Inf), right = TRUE,
    labels = c("freezing", "cold", "cool", "warm", "hot"))


