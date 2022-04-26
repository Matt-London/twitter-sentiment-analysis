# Get the sentiment analysis package
install.packages("syuzhet")
install.packages("rtweet")
install.packages("writexl")
library(writexl)
library(rtweet)
library(syuzhet)

# Set directory
setwd("C:/Users/mattl/RIT/BANA-255/twitter-sentiment-analysis")

# Import from the csv
netflixData <- search_tweets("netflix",n=2000,include_rts = FALSE,lang="en")
View(netflixData)

# Get sentiments of each text with given  method
sentSyuzhet <- get_sentiment(netflixData$text, method = 'syuzhet')
View(sentSyuzhet)
sentSyuzhet[1:3]
netflixData$text[1:4]

# Do the same but with different method
sentAfinn <- get_sentiment(netflixData$text, method = 'afinn')
sentAfinn[1:5]

# Try third method
sentNrc <- get_sentiment(netflixData$text, method = "nrc")

# Try fourth method
sentBing <- get_sentiment(netflixData$text, method = "bing")

# Merge the data set to include the sentiment analysis
# cbind adds new columns to a data frame
sentiNetflix <- cbind(netflixData, sentSyuzhet, sentAfinn, sentNrc, sentBing)

# Attach to the new dataset
attach(sentiNetflix)

# Look for duplicated cases
dup <- duplicated(status_id)
# Will set dup[i] to true if it is a duplicated case

# Will display the items and the counts
table(dup)

# To remove duplicates, use comma to say you want them all
noDupSentiNetflix <-sentiNetflix[!duplicated(sentiNetflix), ]

# Export it as a csv
write_as_csv(noDupSentiNetflix, "sentiNetflix.csv")

# Can also write it as an excel document
write_xlsx(noDupSentiNetflix, "sentiNetflix.xlsx")