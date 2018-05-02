library(tidyverse)

as_tibble(iris)

tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y
)

tribble(
  ~x, ~y, ~z,
  #--/--/----
  "a", 2, 3.6,
  "b", 1, 8.5
)

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df$x
df[["x"]]
df[[1]]

#Exercise
print(mtcars)
cars_df <- as_tibble(mtcars)
print(cars_df)

#2
df <- data.frame(abc = 1, xyz = "a")
df$x
df[, "xyz"]
df[, c("abc", "xyz")]

#4
