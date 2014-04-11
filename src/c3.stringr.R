# {stringr} package
library(stringr)

## String join
str_c("Letter: ", letters)
str_c("Letter", letters, sep = ": ")
str_c(letters, " is for", "...")
str_c(letters[-26], " comes before ", letters[-1])

str_c(letters, collapse = "")
str_c(letters, collapse = ", ")

## String counting
fruit <- c("apple", "banana", "pear", "pineapple")
str_count(fruit, "a")
str_count(fruit, "p")
str_count(fruit, "e")
str_count(fruit, c("a", "b", "p", "p"))

## String duplicate
fruit <- c("apple", "pear", "banana")
str_dup(fruit, 2)
str_dup(fruit, 1:3)
str_c("ba", str_dup("na", 0:5))

## Regular expression
# http://regexone.com/lesson

## String detect
fruit <- c("apple", "banana", "pear", "pinapple")
str_detect(fruit, "a")
str_detect(fruit, "^a")
str_detect(fruit, "a$")
str_detect(fruit, "b")
str_detect(fruit, "[aeiou]")
str_detect("aecfg", letters)
str_detect("hello, world",c("l","d"))
str_detect(c("hello","world"),c("[aeiou]","[abc]"))

## String extracting (first observation)
shopping_list <- c("apples x4", "flour", "sugar", "milk x2")
str_extract(shopping_list, "\\d")
str_extract(shopping_list, "[a-z]+")
str_extract(shopping_list, "[a-z]{1,4}")
str_extract(shopping_list, "\\b[a-z]{1,4}\\b")

str_extract_all(shopping_list, "[a-z]+")
str_extract_all(shopping_list, "\\b[a-z]+\\b")
str_extract_all(shopping_list, "\\d")

## String length
nchar(c("hello, world"))
str_length("hello, world")

## String locating
fruit <- c("apple", "banana", "pear", "pinapple")
str_locate(fruit, "a")
str_locate(fruit, "e")
str_locate(fruit, c("a", "b", "p", "p"))

str_locate_all(fruit, "a")
str_locate_all(fruit, "e")
str_locate_all(fruit, c("a", "b", "p", "p"))

## String matching

strings <- c(" 219 733 8965", "329-293-8753 ", "banana", "595 794 7569",
  "387 287 6718", "apple", "233.398.9187  ", "482 952 3315",
  "239 923 8115", "842 566 4692", "Work: 579-499-7527", "$1000",
  "Home: 543.355.3679")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

str_extract(strings, phone)
str_match(strings, phone)

strings <- c("Home: 219 733 8965.  Work: 229-293-8753 ",
  "banana pear apple", "595 794 7569 / 387 287 6718")
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"

str_extract_all(strings, phone)
str_match_all(strings, phone)

## String padding
rbind(
  str_pad("hadley", 30, "left"),
  str_pad("hadley", 30, "right"),
  str_pad("hadley", 30, "both")
)

str_pad("hadley", 3)

## String replacing

fruits <- c("one apple", "two pears", "three bananas")
str_replace(fruits, "[aeiou]", "-")
str_replace_all(fruits, "[aeiou]", "-")

str_replace(fruits, "([aeiou])", "")
str_replace(fruits, "([aeiou])", "\\1\\1")
str_replace(fruits, "[aeiou]", c("1", "2", "3"))
str_replace(fruits, c("a", "e", "i"), "-")

str_replace_all(fruits, "([aeiou])", "")
str_replace_all(fruits, "([aeiou])", "\\1\\1")
str_replace_all(fruits, "[aeiou]", c("1", "2", "3"))
str_replace_all(fruits, c("a", "e", "i"), "-")

## String splitting
fruits <- c(
  "apples and oranges and pears and bananas",
  "pineapples and mangos and guavas"
)
str_split(fruits, " and ")

str_split(fruits, " and ", n = 3)
str_split(fruits, " and ", n = 2)
str_split(fruits, " and ", n = 5)

str_split_fixed(fruits, " and ", 3)
str_split_fixed(fruits, " and ", 4)

## String subsetting
hw <- "Hadley Wickham"

str_sub(hw, 1, 6)
str_sub(hw, end = 6)
str_sub(hw, 8, 14)
str_sub(hw, 8)
str_sub(hw, c(1, 8), c(6, 14))

str_sub(hw, -1)
str_sub(hw, -7)
str_sub(hw, end = -7)

str_sub(hw, seq_len(str_length(hw)))
str_sub(hw, end = seq_len(str_length(hw)))

x <- "BBCDEF"
str_sub(x, 1, 1) <- "A"; x
str_sub(x, -1, -1) <- "K"; x
str_sub(x, -2, -2) <- "GHIJ"; x
str_sub(x, 2, -2) <- ""; x

## String trimming
str_trim("  String with trailing and leading white space\t")
str_trim("\n\nString with trailing and leading white space\n\n")


## Example 1: fruits
fruits <- readLines("data/fruits.txt")
str_match(fruits,"\\w+:\\s\\d+")

matches <- str_match(fruits,"(\\w+):\\s(\\d+)")
fruits.df <- data.frame(na.omit(matches[,-1]),stringsAsFactors=FALSE)
colnames(fruits.df) <- c("fruit","quantity")
fruits.df$quantity <- as.integer(fruits.df$quantity)
fruits.df

## Example 2: messages
msgs <- readLines("data/messages.txt")
pattern <- "(\\d+-\\d+-\\d+),(\\d+:\\d+:\\d+),(\\w+),(\\w+),\\s*(.+)"
matches <- str_match(msgs,pattern)
msgs.df <- data.frame(matches[,-1],stringsAsFactors = FALSE)
colnames(msgs.df) <- c("Date","Time","Sender","Receiver","Message")
msgs.df

## Example 3: personal statements
ps <- readLines("data/personal-statement.txt")
pattern <- ".+name is\\s+(\\w+).* (\\d+) .*years.+working for (\\w+) company.*"
matches <- str_match(ps,pattern)
ps.df <- data.frame(matches[,-1], stringsAsFactors = FALSE)
colnames(ps.df) <- c("Name","Age","Company")
ps.df

## Example 4: personal statements replacing
ps <- readLines("data/personal-statement.txt")
pattern <- ".+name is\\s+(\\w+).* (\\d+) .*years.+working for (\\w+) company.*"
str_replace_all(ps,pattern,"Name: \\1, Age: \\2, Company: \\3")
