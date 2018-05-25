library(tidyverse)

data <- read_csv("CR_16-22_sample.csv")

df <- as_tibble(data)

gathered_df <- df %>% 
  gather(ADX, "24h", Eclick, key = "Source", value = value, convert = TRUE)


gathered_df$type <- c("Sessions", "Actions")

gathered_df %>% 
  spread(key = type, value = "value") %>% 
  write_csv("final_CR.csv")
