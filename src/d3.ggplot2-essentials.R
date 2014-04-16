# {ggplot2} package
# http://ggplot2.org/
# http://blog.echen.me/2012/01/17/quick-introduction-to-ggplot2/
# http://www.statmethods.net/advgraphs/ggplot2.html

## Essentials
library(ggplot2)
df <- data.frame(x=rnorm(100))
df <- transform(df,y=2*x+rnorm(100))
qplot(1:100,df$x,data=df,geom="line")
qplot(df$x,data=df,binwidth=0.5)

data(diamonds)
qplot(x*y*z,data=diamonds)
qplot(carat,fill=cut,data=diamonds)

## ggplot2
library(ggplot2)
head(diamonds)
head(mtcars)
qplot(clarity, data = diamonds, fill = cut, geom = "bar")
ggplot(diamonds, aes(clarity, fill = cut)) + geom_bar()
qplot(wt, mpg, data = mtcars)
qplot(log(wt), mpg - 10, data = mtcars)
qplot(wt, mpg, data = mtcars, color = qsec)
qplot(wt, mpg, data = mtcars, color = qsec, size = 3)
qplot(wt, mpg, data = mtcars, color = qsec, size = I(3))
qplot(wt, mpg, data = mtcars, alpha = qsec)
qplot(wt, mpg, data = mtcars, color = cyl)
qplot(wt, mpg, data = mtcars, color = factor(cyl))
qplot(wt, mpg, data = mtcars, shape = factor(cyl))
qplot(wt, mpg, data = mtcars, size = qsec)
qplot(wt, mpg, data = mtcars, size = qsec, color = factor(carb))
qplot(wt, mpg, data = mtcars, size = qsec, color = factor(carb), shape = I(1))
qplot(wt, mpg, data = mtcars, size = qsec, shape = factor(cyl), geom = "point")
qplot(factor(cyl), data = mtcars, geom = "bar")
qplot(factor(cyl), data = mtcars, geom = "bar") + coord_flip()
qplot(factor(cyl), data = mtcars, geom = "bar", fill = factor(cyl))
qplot(factor(cyl), data = mtcars, geom = "bar", color = factor(cyl))
qplot(factor(cyl), data = mtcars, geom = "bar", fill = factor(gear))
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "stack")
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "dodge")
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "fill")
qplot(clarity, data = diamonds, geom = "bar", fill = cut, position = "identity")
qplot(clarity, data = diamonds, geom = "freqpoly", group = cut, color = cut, position = "identity")
qplot(clarity, data = diamonds, geom = "freqpoly", group = cut, color = cut, position = "stack")

require(plyr)
table(diamonds$cut)
t.table <- ddply(diamonds, c("clarity", "cut"), "nrow")
t.table
qplot(cut, nrow, data = t.table, geom = "bar", stat = "identity")
qplot(cut, nrow, data = t.table, geom = "bar", stat = "identity", fill = clarity)
qplot(cut, data = diamonds, geom = "bar", weight = carat)
qplot(cut, data = diamonds, geom = "bar", weight = carat, ylab = "carat")

qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.1)
qplot(carat, data = diamonds, geom = "histogram", binwidth = 0.01)
qplot(wt, mpg, data = mtcars, geom = c("point", "smooth"))
qplot(wt, mpg, data = mtcars, geom = c("smooth", "point"))
qplot(wt, mpg, data = mtcars, color = factor(cyl), geom = c("point", "smooth"))
qplot(wt, mpg, data = mtcars, geom = c("smooth", "point"), se = F)
qplot(wt, mpg, data = mtcars, geom = c("smooth", "point"), span = 0.6)
qplot(wt, mpg, data = mtcars, geom = c("smooth", "point"), span = 1)
qplot(wt, mpg, data = mtcars, geom = c("smooth", "point"), method = "lm")

library(splines)
qplot(wt, mpg, data = mtcars, geom = c("point", "smooth"), method = "lm", formula = y ~ ns(x, 5))
qplot(wt, mpg, data = mtcars, facets = cyl ~ ., geom = c("point", "smooth"))
p.tmp <- qplot(factor(cyl), wt, data = mtcars, geom = "boxplot")
p.tmp
p.tmp %+% transform(mtcars, wt = log(wt))
summary(p.tmp)
save(p.tmp, file = "output/temp.local.Rdata")
ggsave("output/test.local.pdf", p.tmp)
ggsave("output/test.local.pdf", p.tmp, width = 10, height = 5)
ggsave("output/test.local.jpg", dpi = 300)
ggsave("output/test.local.svg", p.tmp, width = 10, height = 5)

p.tmp <- ggplot(mtcars, aes(mpg, wt, color = factor(cyl)))
p.tmp
p.tmp + layer(geom = "point")
p.tmp + layer(geom = "point") + layer(geom = "line")
p.tmp + geom_point()
qplot(mpg, wt, data = mtcars, color = factor(cyl), geom = "point") + geom_line()
p.tmp + geom_point()
p.tmp + geom_point() + geom_point(aes(y = disp))
p.tmp + geom_point(color = "darkblue")
p.tmp + geom_point(aes(color = "darkblue"))
t.df <- data.frame(x = rnorm(2000), y = rnorm(2000))
p.norm <- ggplot(t.df, aes(x, y))
p.norm + geom_point()
p.norm + geom_point(shape = 1)
p.norm + geom_point(shape = ".")
p.norm + geom_point(color = "black", alpha = 0.5)
p.norm + geom_point(color = "blue", alpha = 0.1)
p.norm + geom_point(color = "red", alpha = 0.2)
qplot(mpg, wt, data = mtcars, facets = ~cyl, geom = "point")
p.tmp <- ggplot(mtcars, aes(mpg, wt)) + geom_point()
p.tmp + facet_wrap(~cyl)
p.tmp + facet_wrap(~cyl, ncol = 3)
p.tmp + facet_grid(gear ~ cyl)
p.tmp + facet_wrap(~cyl + gear)
p.tmp + facet_wrap(~cyl, scales = "free")
p.tmp + facet_wrap(~cyl, scales = "free_x")
p.tmp + facet_wrap(~cyl, scales = "fixed")
p.tmp + facet_grid(gear ~ cyl, scales = "free_x")
p.tmp + facet_grid(gear ~ cyl, scales = "free", space = "free")

p.tmp <- qplot(cut, data = diamonds, geom = "bar", fill = cut)
p.tmp
p.tmp + scale_fill_brewer(palette = "Paired")
RColorBrewer::display.brewer.all()
p.tmp + scale_fill_manual(values = c("#7fc6bc", "#083642", "#b1df01", "#cdef9c", "#466b5d"))
qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point",
  xlab = "Descr. of x-axis", ylab = "Descr. of y-axis",
  main = "our sample plot")
qplot(mpg, wt, data = mtcars,
  color = factor(cyl),geom = "point") + xlab("x-axis")
qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point") + labs(color = "Legend-Name")
qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point") + theme(legend.position = "left")
qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point") +
  scale_color_discrete(name = "Legend of cyl",
    breaks = c(4, 6, 8), labels = c("four", "six", "eight"))
qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point") +
  scale_color_discrete(name = "Legend of cyl", breaks = c(8, 4, 6))
qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point") +
  scale_color_discrete(name = "Legend of cyl", breaks = c(4, 8))

p.tmp <- qplot(wt, mpg, data = mtcars,
  geom = c("point", "smooth"), method = "lm")
p.tmp
p.tmp + scale_x_continuous(limits = c(15, 30))
p.tmp + coord_cartesian(xlim = c(15, 30))
p.tmp
p.tmp + scale_x_continuous(breaks = c(15, 18, 27))
p.tmp + scale_x_continuous(breaks = c(15, 18, 27), labels = c("low", "medium", "high"))

qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point")
qplot(mpg, wt, data = mtcars,
  color = factor(cyl), geom = "point") +
  scale_y_continuous(trans = "log2") +
  scale_x_log10()
qplot(mpg, wt, data = mtcars, geom = "point") + theme_bw()
qplot(mpg, wt, data = mtcars, geom = "point") + theme_bw(18)

theme_set(theme_bw(18))
theme_get()
qplot(mpg, wt, data = mtcars,
  geom = "point", main = "Test Plot")
qplot(mpg, wt, data = mtcars,
  geom = "point", main = "Title of Plot") +
  theme(axis.line = element_line(),
    plot.title = element_text(size = 20, face = "bold", color = "steelblue"),
    panel.grid.minor = element_blank(),
    panel.background = element_blank(),
    panel.grid.major = element_line(linetype = "dotted",
      color = "lightgrey", size = 0.5),
    panel.grid.major = element_blank())

qplot(x = factor(gear),
  ymax = ..count.., ymin = 0, ymax = ..count.., label = ..count..,
  data = mtcars, geom = c("pointrange", "text"),
  stat = "bin", vjust = -0.5, color = I("blue")) +
    coord_flip()

p.tmp <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1)
p.tmp
p.tmp + coord_polar(theta = "y")
p.tmp + coord_polar()
ggplot(mtcars, aes(factor(cyl), fill = factor(cyl))) + geom_bar(width = 1) + coord_polar()

library(survival)
head(lung)
t.surv <- Surv(lung$time, lung$status)
t.survfit <- survfit(t.surv ~ 1, data = lung)
plot(t.survfit, mark.time = T)

p.a <- qplot(mpg, wt, data = mtcars, geom = "point")
p.b <- qplot(mpg, wt, data = mtcars, geom = "bar", stat = "identity")
p.c <- qplot(mpg, wt, data = mtcars, geom = "step")
