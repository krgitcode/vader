vader 0.1.0:
Contains a new function that calls getVader() on multiple text documents and returns a dataframe of results.

vader 0.0.2: 
Minor bug fixes have been completed:

1.) The previous version crashed when emoticons started with open parentheses/brackets, such as :(
2.) The Vader lexicon had a handful of duplicate entries. The sentiment scores will return the average of any duplicate lexicon entries.