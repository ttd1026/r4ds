#Prerequisites-------------------------------------------------
library(tidyverse)
library(gtable)
library(grid)
library(gridExtra)
library(scales)

#Import data----------------------------------------------------
df <- read_csv("rocket1h_rawdata_thang04.csv")

colnames(df)[5] <- "Sessions"

# Transforming data--------------------------------------------
# adding ctr and cr
df <- mutate(df,
             ctr = Clicks / Impressions,
             cr = Conversions / Clicks)
#Binning
label_list <- c("0-1m", "1-2m",
                "2-3m", "3-4m",
                "4-5m", "5-6m", "6-7m",
                "7-8m", ">8m")

df$bins <- cut(df$Budget,
               breaks = c(seq(0, 9000000, by = 1000000)),
               labels = label_list,
               include.lowest = TRUE)

# Summarize based on bins
df_binned <- df %>% 
  group_by(bins) %>% 
  summarize(mean_impressions = mean(Impressions),
            mean_clicks = mean(Clicks),
            mean_sessions = mean(Sessions),
            mean_conversions = mean(Conversions),
            mean_ctr = mean(ctr),
            mean_cr = mean(cr))

#Plotting----------------------------------------------------------
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
  geom_smooth() +
  scale_x_continuous(labels = comma) +
  scale_y_continuous(labels = comma) +
  theme_minimal() +
  ggtitle("Budget x Impressions w/ trendline")

# With trendline, linear model
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

#Plotting for budget and CTR-------------------------------------
plot_budget_ctr <- 
  ggplot(df, aes(Budget, ctr)) +
  theme_minimal() +
  scale_y_continuous(labels = percent) +
  scale_x_continuous(labels = comma)

plot_budget_ctr + 
  geom_point(na.rm = TRUE) +
  geom_smooth(method = "loess", 
              na.rm = TRUE,
              span = 3)

plot_budget_ctr_binned <-  ggplot(df_binned, aes(bins, mean_ctr))
  
plot_budget_ctr_binned + 
  geom_point(na.rm = TRUE) +
  geom_line(group = 1, na.rm = TRUE)

ggplot(df, aes())
