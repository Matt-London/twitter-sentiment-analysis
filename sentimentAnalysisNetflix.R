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
plot(sentAfinn, type = "p")
View(sentAfinn)
sentAfinn[1:5]

# Try third method
sentNrc <- get_sentiment(netflixData$text, method = "nrc")

# Try fourth method
sentBing <- get_sentiment(netflixData$text, method = "bing")
get_sentiment_dictionary("bing")
plot(sentBing, type = "p")

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

# Make a plot
plot(sentSyuzhet, type = "p")
mean(sentSyuzhet)

# View NRC dictionary
View(get_sentiment_dictionary("nrc"))

# Will get the nrc analysis that will show many different features of sentiments
nrc_data <- get_nrc_sentiment(noDupSentiNetflix$text)

# Get five number summary
summary(nrc_data)

# Create a barplot and save as png
png("netflix_nrc_senti_graph.png", width = 12, height = 8, units = "in", res = 300)
barplot(sort(colSums(prop.table(nrc_data))),
        horiz = FALSE,
        cex.names = 0.7,
        las = 1,
        main = "Emotions in Netflix tweets",
        ylab = "Percentage",
        xlab = "Emotion")
dev.off()

# Export tweets as txt to be sent through word cloud
write.table(noDupSentiNetflix$text, file = "netflixTweets.txt", row.names = FALSE,
            col.names = FALSE)

# Look for certain words in each item
stock <- grepl("stock", noDupSentiNetflix$text, ignore.case = FALSE)
table(stock) # Gives sum of values

# Grab all the values that reference the stock
netflixStock <- sentiNetflix[stock, ]
stock_nrc <- get_nrc_sentiment(netflixStock$text)
View(netflixStock)

# Build a plot of the stock referenced tweets
png("netflixStock_nrc_senti_graph.png", width = 12, height = 8, units = "in", res = 300)
barplot(sort(colSums(prop.table(stock_nrc))),
        horiz = FALSE,
        cex.names = 0.7,
        las = 1,
        main = "Emotions in Netflix stock tweets",
        ylab = "Percentage",
        xlab = "Emotion")
dev.off()

# Install ggplot
install.packages("ggplot2")
library("ggplot2")


# Grab tweets about specifically Netflix's stock symbol
nflxStockData <- search_tweets("nflx",n=2000,include_rts = FALSE,lang="en")

# Run NRC sentiment analysis on those tweets
nrc_stock_data <- get_nrc_sentiment(nflxStockData$text)

# Build the plot
png("nflx_nrc_senti_graph.png", width = 12, height = 8, units = "in", res = 300)
barplot(sort(colSums(prop.table(stock_nrc))),
        horiz = FALSE,
        cex.names = 0.7,
        las = 1,
        main = "Emotions in NFLX stock tweets",
        ylab = "Percentage",
        xlab = "Emotion")
dev.off()


# Get NFLX syuzhet analtsis
nflxSyuzhet <- get_sentiment(nflxStockData$text, method = 'syuzhet')
nflxAfinn <- get_sentiment(nflxStockData$text, method = 'afinn')
nflxBing <- get_sentiment(nflxStockData$text, method = 'bing')

sentiNflx <- cbind(nflxStockData, nflxSyuzhet, nflxAfinn, nflxBing)

write_xlsx(sentiNflx, "nflxSenti.xlsx")

# Plot syuzhet for NFLX
plot(nflxSyuzhet, type = "p")
mean(nflxSyuzhet)
summary(nflxSyuzhet)
