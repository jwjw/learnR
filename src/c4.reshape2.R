# {reshape2} package

require(reshape2)
data(airquality)
names(airquality) <- tolower(names(airquality))

## Short-format table

head(airquality)

## Long-format table

aql <- melt(airquality)
head(aql)

tail(aql)

aql <- melt(airquality, id.vars = c("month", "day"))
head(aql)

aql <- melt(airquality, id.vars = c("month", "day"),
  variable.name = "climate_variable",
  value.name = "climate_value")
head(aql)

## Transformation between long- and -short format

aql <- melt(airquality, id.vars = c("month", "day"))
aqw <- dcast(aql, month + day ~ variable)
head(aqw)
head(airquality)

dcast(aql, month ~ variable)

dcast(aql, month ~ variable, fun.aggregate = mean, na.rm = TRUE)

## Example: Converting long-format stacked stock data to wide format
require("RSQLite")
conn <- dbConnect(SQLite(), "d:/data/fmarket.sqlite")
table.tick <- dbGetQuery(conn, sprintf("SELECT t.Stkcd AS code,t.Trddt AS date,t.Clsprc AS price FROM Tick t,SH000010 c WHERE t.Stkcd=c.Stkcd AND t.Trddt BETWEEN %d AND %d", 20100101, 20130731))
dbDisconnect(conn)

require("reshape2")
tick <- dcast(table.tick, date ~ code, value.var = "price")
