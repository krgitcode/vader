#' Get a named vector of vader results for a single text document
#'
#' Use get_vader() to calculate the valence of a single text document.
#'
#' @param text to be analyzed; for get_vader(), the text should be a character string
#' @param incl_nt defaults to T, indicates whether you wish to incl n't contractions (e.g., can't) in negation analysis
#' @param neu_set defaults to T, indicates whether you wish to count neutral words in calculations
#' @importFrom tm stopwords
#' @return A named vector containing the valence score for each word; an overall, compound valence score for the text; the weighted percentage of positive, negative, and neutral words in the text; and the frequency of the word "but".
#' @examples
#' get_vader("I yesn't like it")
#' get_vader("I yesn't like it", incl_nt = FALSE)
#' get_vader("I yesn't like it", neu_set = FALSE)
#'
#' @export
#'
#' @seealso \code{\link{vader_df}} to get vader results for multiple text documents
#'
#' @section References:
#'
#' For the original Python Code, please see:
#' \itemize{
#'   \item https://github.com/cjhutto/vaderSentiment
#'   \item https://github.com/cjhutto/vaderSentiment/blob/master/vaderSentiment/vaderSentiment.py
#'   }
#'
#' For the original R Code, please see:
#' \itemize{
#'   \item https://github.com/nrguimaraes/sentimentSetsR/blob/master/R/ruleBasedSentimentFunctions.R
#'   }
#'
#' Modifications to the above scripts include, but are not limited to:
#'
#' \itemize{
#'   \item ALL CAPS fx: updated to account for non-alpha words; i.e. "I'M 100 PERCENT SURE" would previously have been counted as mixed case due to the use of numbers
#'   \item IDIOMS fx: added capacity to check for idioms that do not contain any words found in the Vader Lexicon
#'   \item WORDS+EMOT: strip punctuation while preserving ALL emoticons found in dictionary
#'   \item Option to turn on/off neutral count
#' }
#'
#' @section N.B.:
#' In the examples below, "yesn't" is an internet neologism meaning "no", "maybe yes, maybe no", "didn't", etc.

get_vader <- function(text, incl_nt = T, neu_set = T){
  # are 'nt contractions included in negation calculation (if not in negation constants)
  incl_nt <<- incl_nt
  # are neutral words counted
  neu_set <<- neu_set
  # converts text to UTF-8 encoding
  text <- iconv(text, to="UTF-8")
  # checks if supplied text is empty
  if(!grepl("[[:graph:]]", text)) {return(NA)}
  #returns score to user
  return(polarity_scores(text))
}
