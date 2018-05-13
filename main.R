library(tidytext)
library(tidyr)
library(twitteR)
library(ROAuth)
library(httr)
# nrc AFINN bing 


api_key <- "xLnIkXdVdculEncJKPTQwGXJj"
api_secret <- "qVe9ymKAifat3bk7ihjPhHlQk8zLOpp2osz7AlSh4IYGQ8vrJD"
access_token <- "199222737-TyRFq7APfrNJ3kNIPfh1V01HlzcC19SBfzKuPF0w"
access_token_secret <- "IITXogcbjANDtaURLALEabwMgy2xNNFbYhUKmsB8cHVOc"
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

C = c("red","lightblueset","yellow","orange","darkcyan") 
data = readline(cat("What's on your mind?\n"))
data = strsplit(data,split = " ")[[1]]
sent = sentiments
sent$sentiment = factor(sent$sentiment)
sent$lexicon = factor(sent$lexicon)
sent$score = factor(sent$score)
sent = sent[sent$lexicon=='nrc',]
moods = sent$sentiment[which(sent$word %in% data)]
#sent_int = sent[sent$lexicon=='AFINN',]
#scores = as.numeric(as.character(sent_int$score[which(sent_int$word %in% data)]))


#ss = sum(scores)
#cat("\nSentiment Score : ",ss)
print(as.character(na.omit(moods)))
