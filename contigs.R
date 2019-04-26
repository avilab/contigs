library(tidyverse)
con <- read_tsv("SRR5580016_coverage.txt")

con %>% 
  ggplot() +
  geom_histogram(aes(Length), bins = 30) +
  scale_x_log10()

con %>% 
  ggplot() +
  geom_histogram(aes(Avg_fold), bins = 30) +
  scale_x_log10()

con %>% 
  mutate(fold = ceiling(log2(1 + con$Median_fold))) %>% 
  ggplot() +
  geom_histogram(aes(Length), bins = 30) +
  facet_wrap(~ fold, scales = "free_y") +
  geom_vline(xintercept = 1000, linetype = "dashed") +
  scale_x_log10() +
  labs(caption = "Facet labels show log2 median fold coverage.")

con %>% 
  ggplot() +
  geom_point(aes(Avg_fold, Length)) +
  scale_y_log10() +
  scale_x_log10()

