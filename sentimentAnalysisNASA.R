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
nasaData <- read.csv("all NASA data.csv", comment.char="#")
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
# cbind adds new columns to a data frame
sentiNASA <- cbind(nasaData, sent1, sent2, sent3, sent4)

# Attach to the new dataset
attach(sentiNASA)

# Look for duplicated cases
dup <- duplicated(status_id)
# Will set dup[i] to true if it is a duplicated case

# Will display the items and the counts
table(dup)

# To remove duplicates, use comma to say you want them all
noDupSentiNASA <-sentiNASA[!duplicated(sentiNASA), ]

# Export it as a csv
write_as_csv(noDupSentiNASA, "sentiNASA.csv")
# write.csv(noDupSentiNASA, "sentiNASA.csv")

# Can also write it as an excel document
write_xlsx(noDupSentiNASA, "sentiNASA.xlsx")
