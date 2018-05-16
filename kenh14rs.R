library(tidyverse)
library(jsonlite)
library(scales)
<<<<<<< HEAD
=======

>>>>>>> 2a27ba1d48c0d582f43e0604c6d01c05128dae70

json_file <- fromJSON("kenh14data.json")

# Tidying data
df <- as.tibble(json_file) %>% 
  unnest(list) %>% 
  mutate(date = parse_date(day), 
         box_id = parse_character(box_id)) %>%
  arrange(as.integer(box_id)) %>% 
  select(-size, -day)

df <- df[c(6, 1, 2, 3, 4, 5)]

kenh14_df <- df %>% 
  group_by(date, box_id) %>% 
  summarize(view_total = sum(view_total), 
            view_scroll = sum(view_scroll), 
            user_total = sum(user_total), 
            user_scroll = sum(user_scroll))

#Shared legend adapted from http://rpubs.com/sjackman/grid_arrange_shared_legend
grid_arrange_shared_legend <- function(...) {
  plots <- list(...)
  g <- ggplotGrob(plots[[1]] + theme(legend.position = "bottom"))$grobs
  legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
  lheight <- sum(legend$height)
  grid.arrange(legend,
    do.call(arrangeGrob, lapply(plots, function(x)
      x + theme(legend.position = "none"))),
    ncol = 1,
    heights = unit.c(lheight, unit(1, "npc") - lheight))
}

#Adjusting plot style
plot_style <- function() {
  list(
    scale_x_date(date_breaks = "2 days",
                 date_labels = "%B %d"),
    scale_y_continuous(labels = comma),
    geom_line(size = 1),
    theme_minimal(),
    theme(plot.title = element_text(size = 12, color = "#666666"))
  )
}

#view_scroll by box_id
plot1 <- ggplot(kenh14_df, aes(date, view_scroll, group = box_id, color = box_id)) +
  ggtitle("view_scroll by box_id") +
  plot_style()

#view_total by box_id
plot2 <- ggplot(kenh14_df, aes(date, view_total, group = box_id, color = box_id)) +
  ggtitle("view_total by box_id") +
  plot_style()

#user_scroll by box_id
plot3 <- ggplot(kenh14_df, aes(date, user_scroll, group = box_id, color = box_id)) +
  ggtitle("user_scroll by box_id") +
  plot_style()

#user_total by box_id
plot4 <- ggplot(kenh14_df, aes(date, user_total, group = box_id, color = box_id)) +
  ggtitle("user_total by box_id") +
  plot_style() 

#Installing requirements for grid arrangement
#install.packages(c("grid", "gtable", "gridExtra"))
library(gtable)
library(grid)
library(gridExtra)

#grid.arrange
grid_arrange_shared_legend(plot1, plot3, plot2, plot4)

