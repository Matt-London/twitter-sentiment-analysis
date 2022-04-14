install.packages("rtweet")
library(rtweet)
tweets <- search_tweets("#bmw",n=2000,include_rts = FALSE,lang="en")
