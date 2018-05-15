library(tidyverse)
library(jsonlite)


json_file <- fromJSON("kenh14data.json")

# Tidying data
df <- as.tibble(json_file) %>% 
  unnest(list) %>% 
  mutate(date = parse_date(day)) %>% 
  select(-size, -day)

kenh14_df <- df[c(6, 1, 2, 3, 4, 5)]

kenh14_df %>% gather(metrics, c(view_total, view_scroll, user_total, user_scroll))

total_view_df <- kenh14_df %>% 
  group_by(date) %>% 
  summarize(view_total = sum(view_total), view_scroll = sum(view_scroll), 
            sum(user_total), sum(user_scroll)) %>% 
  select(date, view_total, view_scroll)

#Visualize
ggplot(total_view_df, aes(x = date, y = view_scroll)) +
  geom_bar(aes(fill = view_total), stat = "identity", position = "dodge")

melt(total_view_df)
