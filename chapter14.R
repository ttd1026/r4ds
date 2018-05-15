#Chapter 14 Strings
library(tidyverse)
library(stringr)

x <- c("\"", "\\")

writeLines(x)

str_length(c("a", "R for data science", NA))

str_c("x", "y")
str_c("x", "y", sep = ", ")

str_c("prefix-", c("a", "b", "c"), "-suffix", collapse = "")

x <- c("apple", "eggplant", "banana")

str_sort(x, locale = "haw")

#Exercises
#3
test_string <- "abcde" 
str_sub(test_string,
        str_length(test_string) / 2 + 1, str_length(test_string) / 2 + 1)

#6
str_sep <- function(x, sep = ", ", last = ", and ") {
  if(length(x) > 1) {
    str_c(str_c(x[-length(x)], collapse = sep),
          x[length(x)],
          sep = last)
  }
  else {
    x
  }
}

#Matching pattern with regular expressions
#2
str_view("\"'\\", "\"'\\\\")

#Anchor
#Exercise
str_view(c("$^$", "abc$^$abc"), 
         "$\\^\\$")

#Exercises
#words starting with vowel
str_view(words, "^[aeiou].", match = TRUE)
#fruits starting with consonants
str_view(fruit, "^[^aeiou].", match = TRUE)
# ending with "ed" not "eed"
str_view(c(words, "ed"), "^ed$|[^e]ed$", match = TRUE)

str_view(words, ".q.|q.", match = TRUE)

#Repitition
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")

#Grouping and backreference
str_view(fruit, "(..)\\1", match = TRUE)

no_vowels_1 <- !str_detect(words, "[aeiou]")
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels_1, no_vowels_2)

words[str_detect(words, "x$")]
str_subset(words, "x$")

df <- tibble(
  word = words,
  i = seq_along(word)
)

df %>% 
  filter(str_detect(words, "x$"))

words[str_detect(words, "^x|x$")]
words[str_detect(words, "^[aeiou].*[^aeiou]$")] %>% head()

prop_vowels <- str_count(words, "[aeiou]") / str_length(words)
max(prop_vowels)

# Extract matches
colors <- c("red", "orange", "yellow", "green", "blue", "purple")
color_match <- str_c(colors, collapse = "|") #create color vector

has_color <- str_subset(sentences, color_match)
head(has_color)
matches <- str_extract(has_color, color_match)
head(matches)

more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, color_match)
str_extract_all(more, color_match)

str_extract_all(more, color_match, simplify = TRUE)
