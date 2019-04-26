#'---
#' title: "Metagenomic contigs coverage"
#' author: Taavi Päll 
#' date: "2019-04-26" 
#'---

#' - Can we filter contigs based on coverage?
#' 
#' 
#' Load libraries.
library(tidyverse)

#' Importing test data.
con <- read_csv("SRR5580016_coverage.csv")

#' Contigs length distribution.
con %>% 
  ggplot() +
  geom_histogram(aes(Length), bins = 30) +
  scale_x_log10()

#' Contigs Avg_fold distribution.
con %>% 
  ggplot() +
  geom_histogram(aes(Avg_fold), bins = 30) +
  scale_x_log10()

#' Contigs length distribution in Median_fold log2 bins. 
#' Threshold could be set between 4+ (2^2) and 8 (2^3) fold coverage.
con_cov <- con %>% 
  mutate(fold = ceiling(log2(1 + con$Median_fold)))

ggplot(data = con_cov) +
  geom_histogram(aes(Length), bins = 30) +
  facet_wrap(~ fold, scales = "free_y") +
  geom_vline(xintercept = 1000, linetype = "dashed") +
  scale_x_log10() +
  labs(caption = "Facet labels show log2 median fold coverage.")

#' Retention of contigs when filtered by coverage.
con_cov %>% 
  count(fold) %>% 
  mutate(cum_n = cumsum(n),
         remain = sum(n) - cum_n)

#' Contig length versus Avg_fold coverage.
con %>% 
  ggplot() +
  geom_point(aes(Avg_fold, Length)) +
  scale_y_log10() +
  scale_x_log10()
