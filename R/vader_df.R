#' Get a dataframe of vader results for multiple text documents
#'
#' Use vader_df() to calculate the valence of multiple texts contained within a vector or column in a dataframe.
#'
#' @param text to be analyzed; for vader_df(), the text should be a single vector (e.g. 1 column)
#' @param incl_nt defaults to T, indicates whether you wish to incl n't contractions (e.g., can't) in negation analysis
#' @param neu_set defaults to T, indicates whether you wish to count neutral words in calculations
#' @importFrom tm stopwords
#' @return A dataframe containing the valence score for each word; an overall, compound valence score for the text; the weighted percentage of positive, negative, and neutral words in the text; and the frequency of the word "but".
#' @examples
#' vader_df(c("I'm happy", "I'm yesn't happy"))
#' vader_df(c("I'm happy", "I'm yesn't happy"), incl_nt = FALSE)
#' vader_df(c("I'm happy", "I'm yesn't happy"), neu_set = FALSE)
#'
#' @export
#'
#' @section N.B.:
#' In the examples below, "yesn't" is an internet neologism meaning "no", "maybe yes, maybe no", "didn't", etc.
#'
#' @seealso \code{\link{get_vader}} to get vader results for a single text document

vader_df <- function(text, incl_nt = T, neu_set = T){
  df <- as.data.frame(text)
  colnames(df) <- "text"
  df$word_scores <- NA
  df$compound <- NA
  df$pos <- NA
  df$neu <- NA
  df$neg <- NA
  df$but_count <- NA

  for(i in 1:nrow(df)){
    results <- get_vader(df$text[[i]], incl_nt, neu_set)

    df$compound[[i]] <- getElement(results, "compound")
    df$pos[[i]] <- getElement(results, "pos")
    df$neu[[i]] <- getElement(results, "neu")
    df$neg[[i]] <- getElement(results, "neg")
    df$but_count[[i]] <- getElement(results, "but_count")

    words <- list()
    for(j in 1:length(results)){
      if(names(results)[[j]] == ""){words[[j]] <- results[[j]]}}
    df$word_scores[[i]] <- paste0("{",paste(words,collapse = ", "), "}")
  }
  return(df)
}
