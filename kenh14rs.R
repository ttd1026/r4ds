library(tidyverse)
library(jsonlite)


json_file <- fromJSON("kenh14data.json")

# Tidying data
df <- as.tibble(json_file) %>% 
  unnest(list) %>% 
  mutate(date = parse_date(day), 
         box_id = parse_character(box_id)) %>%
  arrange(as.integer(box_id))
  select(-size, -day)

df <- df[c(6, 1, 2, 3, 4, 5)]

kenh14_df <- df %>% 
  group_by(date, box_id) %>% 
  summarize(view_total = sum(view_total), view_scroll = sum(view_scroll), 
            sum(user_total), sum(user_scroll))

#Visualize
ggplot(kenh14_df, aes(date, view_scroll, group = box_id, color = box_id)) +
  scale_x_date(date_breaks = "2 days",
               date_labels = "%B %d") +
  scale_y_continuous(labels = comma) +
  geom_line(size = 1) +
  ggtitle("view_scroll by box_id") +
  theme_minimal()

