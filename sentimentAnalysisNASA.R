# Get the sentiment analysis package
install.packages("syuzhet")
library(syuzhet)

# Import from the csv
nasaData <- read.csv("C:/Users/mattl/RIT/BANA-255/twitter-sentiment-analysis/all NASA data.csv", comment.char="#")
View(nasaData)

# Get sentiments of each text with given  method
sent1 <- get_sentiment(nasaData$text, method = 'syuzhet')
sent1[1:3]
nasaData$text[1:4]

# Do the same but with different method
sent2 <- get_sentiment(nasaData$text, method = 'afinn')
View(get_sentiment_dictionary()) # View the dictionary of words and their correlation
View(get_sentiment_dictionary("afinn"))
sent1[1:5]
sent2[1:5]

# Try third method
sent3 <- get_sentiment(nasaData$text, method = "nrc")
View(get_sentiment_dictionary("nrc"))

# Try fourth method
sent4 <- get_sentiment(nasaData$text, method = "bing")
View(get_sentiment_dictionary("bing"))

# Lets you attach to a database
attach(nasaData)
# Now all operations will be on this data set
# Can complete the following query without the nasaData$ specifier
attachEx <- get_sentiment(text, method = "bing")


# Merge the data set to include the sentiment analysis







