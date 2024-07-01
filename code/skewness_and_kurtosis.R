d = c(12,83,50,35,55,50,72,40,85,29,65,75)

mean(d)
median(d)
modeest::mfv(d)

g = \(x){
  xbar = mean(x)
  kexi = sqrt(sum((x - xbar)^2/length(x)))
  g = sum(((x - xbar)/kexi)^3) / length(x)
  return(g)
}

moments::skewness(d)
moments::kurtosis(d)

library(tidyverse)

d1 = tibble(d = d)

ggplot(data = d1,aes(x = d)) +
  # geom_histogram(aes(x = d, y = after_stat(density))) +
  geom_density() + 
  geom_vline(xintercept = modeest::mfv(d),color = 'red') +
  geom_vline(xintercept = mean(d),color = 'blue')