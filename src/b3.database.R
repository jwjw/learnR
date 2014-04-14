# Database

## SQL
# http://www.w3schools.com/sql/
# http://www.w3schools.com/sql/sql_quickref.asp


## Open Database Connectivity (ODBC)

### Excel Worksheet

library(RODBC)
conn <- odbcConnectExcel2007("data/namelist.xlsx",readOnly = TRUE)
sqlTables(conn)
students <- sqlFetch(conn,"Students")
grades <- sqlQuery(conn,"SELECT * FROM [Grades$]")
df <- sqlQuery(conn,"SELECT * FROM [Students$] INNER JOIN [Grades$] ON [Grades$].Name = [Students$].Name")
odbcClose(conn)

### Excel Binary Worksheet
# http://social.msdn.microsoft.com/Forums/en-US/0993e144-2e32-4915-be17-ff076902f983/excel-binary-workbook-xlsb?forum=isvvba

library(RODBC)
conn <- odbcConnectExcel2007("data/namelist.xlsb",readOnly = TRUE)
sqlTables(conn)
students <- sqlFetch(conn,"Students")
grades <- sqlQuery(conn,"SELECT * FROM [Grades$]")
df <- sqlQuery(conn,"SELECT * FROM [Students$] INNER JOIN [Grades$] ON [Grades$].Name = [Students$].Name")
odbcClose(conn)

conn <- odbcConnectExcel2007("local/data.xlsb",readOnly = F)
df <- data.frame(date=as.character(seq(from=as.Date("2010-01-01"),to=as.Date("2010-10-01"),by="day")))
df$x <- rnorm(nrow(df))
head(df)
sqlSave(conn,df,"df",rownames = FALSE,safer = T)
odbcClose(conn)


## SQLite
# http://www.sqlite.org/
require(RSQLite)

### Creating SQLite database

#### Creating file-based batabase
conn <- dbConnect(SQLite(),"data/example.local.sqlite")
n <- 1000000
products.df <- data.frame(i=1:n,type=sample(LETTERS,n,T),
  class=sample(LETTERS[1:3],n,T),x=rnorm(n,6,2),y=rbinom(n,10,0.6))
dbWriteTable(conn,"products",products.df)
dbDisconnect(conn)


### Creating memory database
conn <- dbConnect(SQLite())
n <- 20000
products.df <- data.frame(i=1:n,type=sample(LETTERS,n,T),
  class=sample(LETTERS[1:3],n,T),x=rnorm(n),y=rbinom(n,10,0.3))
dbWriteTable(conn,"products",products.df)

products.A <- dbGetQuery(conn,"SELECT * FROM products WHERE type='A'")
dbDisconnect(conn)


### Operating SQLite database
require(RSQLite)
conn <- dbConnect(SQLite(),"data/example.local.sqlite")
products.A <- dbGetQuery(conn,"SELECT * FROM products WHERE type='A'")
products.subset <- dbGetQuery(conn,"SELECT i,class,x+y AS z FROM products WHERE type='A' AND x>=8")
dbDisconnect(conn)


### Managing SQLite database
#### SQLite Manager for Firefox
# https://addons.mozilla.org/en-US/firefox/addon/sqlite-manager/

#### SQLite Expert Personal/Professional
# http://www.sqliteexpert.com/


### Querying data.frame as SQLite database
library(sqldf)
n <- 1000000
products.df <- data.frame(i=1:n,type=sample(LETTERS,n,T),
  class=sample(LETTERS[1:3],n,T),x=rnorm(n,6,2),y=rbinom(n,10,0.6))
products.A <- sqldf("SELECT * FROM [products.df] WHERE type='A'")
products.subset <- sqldf("SELECT i,class,x+y AS z FROM [products.df] WHERE type='A' AND x>=8")
products.a1 <- sqldf("SELECT type,class, COUNT(x) as n, AVG(x) AS xmean, AVG(y) AS ymean FROM [products.df] GROUP BY type,class")
