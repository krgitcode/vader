# calculate sentiment score for each word

#return list of scores for each word in text
polarity_scores <- function(text){
  #split text into  vector of single words
  wpe <- wordsPlusEmo(text)
  sentiments <- NULL
  for(i in seq_along(wpe)) {
    valence <- 0
    item <- tolower(wpe[i])
    #check if item is in booster diction (single words)
    if(item %in% names(BOOSTER_DICT)){
      sentiments[i] <- valence
      # sentiments <- c(sentiments, valence)
    }
    #check if item is in booster diction (compound words)
    else if(i < length(wpe) && item == "kind" && tolower(wpe[i+1]) == "of"){
      sentiments[i] <- valence
    }
    #check if item is in Vader dictionary
    else if(item %in% vaderLexicon$V1){
      sentiments[i] <-senti_valence(wpe, i, item)                                                ### leaves NA for scoreless words
    }
    #check if item is in idiom diction (non-vader section)
    else if(item %in% unlist(strsplit(tm::removeWords(names(IDIOMS), stopwords("en")), " "))){
      valence <- idioms_check(wpe, i, valence, non_dic = T)
      sentiments[i] <- valence
    }
    else {
      ############ ADDED THIS LINE TO COUNT NEUTRAL WORDS (WHICH DON'T EXIST IN VADER LEXICON)
      if(neu_set == T) {sentiments[i] <- 0}
      else {sentiments[i] <- NA}
    }
  }

  # modify results if "but" appears in text
  but_results <- but_check(wpe, sentiments)
  sentiments <- unlist(but_results[1])
  names(sentiments) <- NULL
  but_count <- unlist(but_results[2])

  # send sentiment vector and text to function to analyze compound and individual affect (positive, negative, and neutral) scores
  valence_dict <- score_val(sentiments, text)
  results <- c(sentiments, valence_dict, but_count)
  return(results)
}
