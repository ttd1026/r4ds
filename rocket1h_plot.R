#Prerequisites-------------------------------------------------
library(tidyverse)
library(gtable)
library(grid)
library(gridExtra)

#Import data----------------------------------------------------
rocket1h_df <- read_csv("rocket1h_rawdata_thang04.csv")

colnames(rocket1h_df)[5] <- "Sessions"

#Plot----------------------------------------------------------
plot_rocket1h_style <- list(
  geom_point(),
  geom_line(),
  scale_x_continuous(labels = comma),
  scale_y_continuous(labels = comma),
  theme_minimal()
)

#Budget x Impressions
p1 <- ggplot(rocket1h_df, mapping = aes(Budget, Impressions)) +
  plot_rocket1h_style +
  ggtitle("Budget x Impressions")

#Budget x Sessions
p2 <- ggplot(rocket1h_df, mapping = aes(Budget, Sessions)) +
  plot_rocket1h_style +
  ggtitle("Budget x Sessions")

#Budget x Clicks
p3 <- ggplot(rocket1h_df, mapping = aes(Budget, Clicks)) +
  plot_rocket1h_style +
  ggtitle("Budget x Clicks")

#Budget x Conversions
p4 <- ggplot(rocket1h_df, mapping = aes(Budget, Conversions)) +
  plot_rocket1h_style +
  ggtitle("Budget x Conversions")

grid.arrange(p1, p2, p3, p4)

ggplot(rocket1h_df, mapping = aes(Budget, Conversions)) +
  geom_point() +
  geom_smooth(model = lm)

ggplot(rocket1h_df, mapping = aes(Budget, Impressions)) +
  geom_point() +
  geom_smooth(model = lm)

ggplot(rocket1h_df, mapping = aes(Budget, Clicks)) +
  geom_point() +
  geom_smooth(model = lm)

ggplot(rocket1h_df, mapping = aes(Budget, Sessions)) +
  geom_point() +
  geom_smooth(model = lm)

label_list <- c("0-1000000", "1000000-2000000",
                "2000000-3000000", "3000000-4000000",
                "4000000-5000000",
                "5000000-6000000", "6000000-7000000",
                "7000000-8000000", ">8000000")

rocket1h_df$bins <- cut(rocket1h_df$Budget,
                        breaks = c(seq(0, 9000000, by = 1000000)),
                        labels = label_list,
                        include.lowest = TRUE)

rocket1h_df %>% 
  group_by(bins) %>% 
  summarize(mean_impressions = mean(Impressions),
             mean_clicks = mean(Clicks),
             mean_sessions = mean(Sessions),
             mean_conversions = mean(Conversions))

ggplot(rocket1h_df_binned, mapping = aes(x = bins, y = mean_impressions)) +
  geom_point() +
  geom_smooth()
