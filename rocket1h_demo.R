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

#Adding trendline, non-linear model
ggplot(df, mapping = aes(Budget, Impressions)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_continuous(labels = comma) +
  scale_y_continuous(labels = comma) +
  theme_minimal() +
  ggtitle("Budget x Impressions with trendline")


# With trendline, linear model

ln_df <- df %>% 
  mutate(lnBudget = log(Budget),
         lnImpressions = log(Impressions)) %>% 
  filter(lnImpressions != -Inf)
  

lmodel <- lm(lnImpressions ~ lnBudget,
                           data = ln_df)

summary(lmodel)

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
  scale_y_continuous(labels = comma) +
  ggtitle("Budget range x Impressions")

#Displaying
grid.arrange(p1, p3, p2, nrow = 2)

new_df <- df %>% 
  mutate(ctr = Clicks / Impressions)

ggplot(new_df, mapping = aes(Budget, ctr)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_continuous(labels = comma) +
  scale_y_continuous(labels = comma) +
  theme_minimal() +
  ggtitle("Budget x Impressions with trendline")

ggplot(new_df, aes(Budget, ctr)) +
  geom_point() +
  scale_x_continuous(labels = comma)

df_binned <- new_df %>% 
  group_by(bins) %>% 
  summarize(mean_ctr = mean(ctr))

ggplot(df_binned, mapping = aes(x = bins, y = mean_ctr)) +
  geom_point(size = 3) +
  geom_path(group = 1, size = 0.8) +
  theme_minimal() +
  xlab("Budget range") +
  ylab("Avg. ctr") +
  scale_y_continuous(labels = comma) +
  ggtitle("Budget range x ctr")
