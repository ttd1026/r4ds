#Prerequisites-------------------------------------------------
library(tidyverse)
library(gtable)
library(grid)
library(gridExtra)
library(scales)

#Import data----------------------------------------------------
df <- read_csv("rocket1h_rawdata_thang04.csv")

colnames(df)[5] <- "Sessions"

#Plot----------------------------------------------------------
plot_style <- list(
  geom_point(),
  geom_line(),
  scale_x_continuous(labels = comma),
  scale_y_continuous(labels = comma),
  theme_minimal()
)

#Budget x Impressions
p1 <- ggplot(df, mapping = aes(Budget, Impressions)) +
  plot_style +
  ggtitle("Budget x Impressions")

#Adding trend line
p2 <- ggplot(df, mapping = aes(Budget, Impressions)) +
  geom_point() +
  geom_smooth() +
  scale_x_continuous(labels = comma) +
  scale_y_continuous(labels = comma) +
  theme_minimal() +
  ggtitle("Budget x Impressions w/ trendline")


#Binning
label_list <- c("0-1m", "1-2m",
                "2-3m", "3-4m",
                "4-5m", "5-6m", "6-7m",
                "7-8m", ">8m")

df$bins <- cut(df$Budget,
               breaks = c(seq(0, 9000000, by = 1000000)),
               labels = label_list,
               include.lowest = TRUE)

df_binned <- df %>% 
  group_by(bins) %>% 
  summarize(mean_impressions = mean(Impressions),
            mean_clicks = mean(Clicks),
            mean_sessions = mean(Sessions),
            mean_conversions = mean(Conversions))

p3 <- ggplot(df_binned, mapping = aes(x = bins, y = mean_impressions)) +
  geom_point(size = 3) +
  geom_path(group = 1, size = 0.8) +
  theme_minimal() +
  xlab("Budget range") +
  ylab("Avg. impressions") +
  scale_y_continuous(labels = comma)

#Displaying
grid.arrange(p1, p3, p2, nrow = 2)
