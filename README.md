# vader

Vader is a lexicon and rule-based sentiment analysis tool that is specifically attuned to sentiments expressed in social media.

## Installation

You can install the released version of vader from [CRAN](https://CRAN.R-project.org) with:

install.packages("vader")

## Example

N.B. "Yesn't" is an internet neologism meaning "no", "maybe yes, maybe no", "didn't", etc.

library(vader)
getVader("I yesn't like it")

###doesn't include non-dictionary contractions when calculating negations
getVader("I yesn't like it", incl_nt = F) 

###doesn't include neutral words in calculations
getVader("I yesn't like it", neu_set = F) 