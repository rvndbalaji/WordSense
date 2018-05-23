library(tidytext)
library(tidyr)
library(twitteR)
library(ROAuth)
library(httr)
# nrc AFINN bing 

size = 3
par(mfrow=c(1,1))
#par(mfrow=c(size,size))

#lim =size^2
lim = 200
clear = function() cat("\014")

C = c("red","lightblue","yellow","orange","darkcyan") 


prep = function()
{
  sent = tidytext::sentiments
  sent$sentiment = factor(sent$sentiment)
  sent$lexicon = factor(sent$lexicon)
  sent$score = factor(sent$score)
  return(sent)
}

getMood = function(text)
{
  text = strsplit(text,split = " ")[[1]]
  sent = prep()
  sent = sent[sent$lexicon=='nrc',]
  moods = sent$sentiment[which(sent$word %in% text)]  
  return(as.character(na.omit(moods)))
}

getScore = function(text)
{ 
  text = strsplit(text,split = " ")[[1]]
  sent = prep()
  sent = sent[sent$lexicon=='AFINN',]
  moods = sent$score[which(sent$word %in% text)]  
  return(as.character(na.omit(moods)))
}

senseScore =function(posts)
{
  moods = list()
  for(pos in 1:lim)
  {
    text = posts[[pos]]$text
    cur =  getMood(text)
    if(length(cur)!=0)
    {
      moods[[pos]] = as.character(getScore(text))
      barplot(as.numeric(getScore(text)),col=C)
    } else
    {
      moods[[pos]] = "0"
    }
  }
  
  return(moods)
}
senseMood =function(posts)
{
  moods = list()
  for(pos in 1:lim)
  {
    text = posts[[pos]]$text
    cur =  getMood(text)
    if(length(cur)!=0)
    {
      moods[[pos]] = as.character(getMood(text))
    } else
    {
      moods[[pos]] = "Neutral"
    }
  }
  
  return(moods)
}

setupTwitter = function()
{
  clear()
  cat("Connecting to Twitter...")
  api_key <- "xLnIkXdVdculEncJKPTQwGXJj"
  api_secret <- "qVe9ymKAifat3bk7ihjPhHlQk8zLOpp2osz7AlSh4IYGQ8vrJD"
  access_token <- "199222737-TyRFq7APfrNJ3kNIPfh1V01HlzcC19SBfzKuPF0w"
  access_token_secret <- "IITXogcbjANDtaURLALEabwMgy2xNNFbYhUKmsB8cHVOc"
  setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)
  clear()  
}

setupTwitter()
data = readline(cat("Search : "))


posts = searchTwitter(data,lang='en',n=lim)
#moods = senseScore(posts)
#print(moods)
words = character(0)
for(p in posts)
{
  words = c(words,strsplit(p$text,split = " ")[[1]])
}
sent = prep()
sent = sent[sent$lexicon=='nrc',]
moods = sent$sentiment[which(sent$word %in% words)]  

#Collective mood



