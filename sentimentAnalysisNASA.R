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

# Make a plot
plot(sent1, type = "p")

# View NRC dictionary
View(get_sentiment_dictionary("nrc"))

# Will ge the nrc analysis that will show many different features of sentiments
nrc_data <- get_nrc_sentiment(noDupSentiNASA$text)

# Get five number summary
summary(nrc_data)

# Create a barplot and save as png
png("NASA_nrc_senti_graph.png", width = 12, height = 8, units = "in", res = 300)
barplot(sort(colSums(prop.table(nrc_data))),
        horiz = FALSE,
        cex.names = 0.7,
        las = 1,
        main = "Emotions in NASA tweets",
        ylab = "Percentage",
        xlab = "Emotion")
dev.off()

# Look for certain words in each item
mars <- grepl("Mars", noDupSentiNASA$text, ignore.case = FALSE)
table(mars) # Gives sum of values

# Install ggplot
install.packages("ggplot2")
library("ggplot2")

