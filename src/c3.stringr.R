# {stringr} package
library(stringr)

## String transformation

## Regular expressions

### Pattern matching

#### Example 1: fruits
fruits <- readLines("data/fruits.txt")
str_match(fruits,"\\w+:\\s\\d+")

matches <- str_match(fruits,"(\\w+):\\s(\\d+)")
fruits.df <- data.frame(na.omit(matches[,-1]),stringsAsFactors=FALSE)
colnames(fruits.df) <- c("fruit","quantity")
fruits.df$quantity <- as.integer(fruits.df$quantity)
fruits.df

#### Example 2: messages
msgs <- readLines("data/messages.txt")
pattern <- "(\\d+-\\d+-\\d+),(\\d+:\\d+:\\d+),(\\w+),(\\w+),\\s*(.+)"
matches <- str_match(msgs,pattern)
msgs.df <- data.frame(matches[,-1],stringsAsFactors = FALSE)
colnames(msgs.df) <- c("Date","Time","Sender","Receiver","Message")
msgs.df

#### Example 3: personal statements
ps <- readLines("data/personal-statement.txt")
pattern <- ".+name is\\s+(\\w+).* (\\d+) .*years.+working for (\\w+) company.*"
matches <- str_match(ps,pattern)
ps.df <- data.frame(matches[,-1], stringsAsFactors = FALSE)
colnames(ps.df) <- c("Name","Age","Company")
ps.df


### String replacing

#### Example 1: personal statements
ps <- readLines("data/personal-statement.txt")
pattern <- ".+name is\\s+(\\w+).* (\\d+) .*years.+working for (\\w+) company.*"
str_replace_all(ps,pattern,"Name: \\1, Age: \\2, Company: \\3")

