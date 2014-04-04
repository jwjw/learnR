# Essential statistics
## Hypothesis testing

# Comparing means
library(nutshell)
data(tires.sus)
times.to.failure.h <- subset(tires.sus,
  Tire_Type == "H" & Speed_At_Failure_km_h ==  160)$Time_To_Failure
times.to.failure.b <- subset(tires.sus,
  Tire_Type == "B" & Speed_At_Failure_km_h == 180)$Time_To_Failure
times.to.failure.e <- subset(tires.sus,
  Tire_Type == "E" & Speed_At_Failure_km_h == 180)$Time_To_Failure
times.to.failure.d <- subset(tires.sus,
  Tire_Type == "D" & Speed_At_Failure_km_h == 180)$Time_To_Failure
times.to.failure.h
mean(times.to.failure.h)
t.test(times.to.failure.h, mu = 9)
lapply(list(times.to.failure.h, times.to.failure.b), mean)
t.test(times.to.failure.h, times.to.failure.b)
t.test(times.to.failure.e, times.to.failure.d)
t.test(times.to.failure.e, times.to.failure.b)

# formula t test test within data set groups
library(nutshell)
data(field.goals)
good <- transform(field.goals[field.goals$play.type == "FG good", c("yards", "stadium.type")], outside = (stadium.type == "Out"))
bad <- transform(field.goals[field.goals$play.type == "FG no", c("yards", "stadium.type")], outside = (stadium.type == "Out"))
t.test(yards ~ outside, data = good)
t.test(yards ~ outside, data = bad)
field.goals.inout <- transform(field.goals, outside = (stadium.type == "Out"))
t.test(yards ~ outside, data = field.goals.inout)

# Comparing paired data
library(nutshell)
data(SPECint2006)
t.test(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline,
  subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Result, paired = T)
plot(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline,
  subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Result)

# Comparing variances of two populations
var.test(yards ~ outside, data = field.goals.inout)
bartlett.test(yards ~ outside, data = field.goals.inout)

# ANOVA
library(nutshell)
data(mort06.smpl)
tapply(mort06.smpl$age, INDEX = list(mort06.smpl$Cause), FUN = summary)
barplot(tapply(mort06.smpl$age, INDEX = list(mort06.smpl$Cause),
  FUN = function(x) {
    median(x, na.rm = T)
}))
aov(age ~ Cause, data = mort06.smpl)
model.tables(aov(age ~ Cause, data = mort06.smpl))

data(births2006.smpl)
births2006.cln <- births2006.smpl[births2006.smpl$WTGAIN < 99 & !is.na(births2006.smpl$WTGAIN),]
tapply(X = births2006.cln$WTGAIN, INDEX = births2006.cln$DOB_MM, FUN = mean)
barplot(tapply(X = births2006.cln$WTGAIN, INDEX = births2006.cln$DOB_MM, FUN = mean))
aov(WTGAIN ~ DOB_MM, births2006.cln)
mort06.smpl.lm <- lm(age ~ Cause, data = mort06.smpl)
anova(mort06.smpl.lm)
oneway.test(age ~ Cause, mort06.smpl)

pairwise.t.test(tires.sus$Time_To_Failure, tires.sus$Tire_Type)

# Testing for normality
par(mfcol = c(1, 2), ps = 6.5)
hist(mort06.smpl$age)
qqnorm(mort06.smpl$age)
shapiro.test(good$yards)
# Testing if a data vector came from an arbitrary distribution
ks.test(field.goals$yards, pnorm)
# Testing if two data vectors came from the same distribution
ks.test(jitter(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline), jitter(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Result))
ks.test(jitter(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline), jitter(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline))

# Testing correlation
cor.test(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline, subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Result)
cor.test(rnorm(10000), rnorm(10000))

# Non-parametric tests Comparing two means
wilcox.test(times.to.failure.e, times.to.failure.d)
wilcox.test(yards ~ outside, data = good)
# Compaing more than two means
kruskal.test(age ~ Cause, data = mort06.smpl)
# Comparing variances
fligner.test(age ~ Cause, data = mort06.smpl)
# Difference in scale parameters
ansari.test(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline,
  subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Result)
mood.test(subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Baseline,
  subset(SPECint2006, Num.Chips == 1 & Num.Cores == 2)$Result)

# Discrete Data
library(nutshell)
data(field.goals)
field.goals.goodbad <- field.goals[field.goals$play.type %in% c("FG good","FG no"), ]
field.goals.table <- table(field.goals.goodbad$play.type, field.goals.goodbad$stadium.type)
field.goals.table
field.goals.table.t <- t(field.goals.table[3:4, ])
field.goals.table.t
prop.test(field.goals.table.t)

# Binomial test
binom.test(x = 110, n = 416, p = 0.3, alternative = "less")

data(births2006.smpl)
births.july.2006 <- births2006.smpl[births2006.smpl$DMETH_REC != "Unknown" & births2006.smpl$DOB_MM == 7, ]
nrow(births2006.smpl)
nrow(births.july.2006)
method.and.sex <- table(births.july.2006$SEX, as.factor(as.character(births.july.2006$DMETH_REC)))
method.and.sex
fisher.test(method.and.sex)

twins.2006 <- births2006.smpl[births2006.smpl$DPLURAL == "2 Twin" & births2006.smpl$DMETH_REC != "Unknown", ]
method.and.sex.twins <- table(twins.2006$SEX, as.factor(as.character(twins.2006$DMETH_REC)))
method.and.sex.twins
fisher.test(method.and.sex.twins)
chisq.test(method.and.sex.twins)
chisq.test(twins.2006$DMETH_REC, twins.2006$SEX)

births2006.byday <- table(births2006.smpl$DOB_WK)
births2006.byday
chisq.test(births2006.byday)
births2006.bydayandmonth <- table(births2006.smpl$DOB_WK, births2006.smpl$DOB_MM)
births2006.bydayandmonth
chisq.test(births2006.bydayandmonth)
friedman.test(method.and.sex.twins)

# Power test
power.t.test(power = 0.95, sig.level = 0.05, sd = 8.9, n = 25)
power.t.test(power = 0.95, sig.level = 0.05, sd = 8.9, n = 50)
power.prop.test(p1 = 0.26, p2 = 0.3, sig.level = 0.05, power = 0.95, alternative = "one.sided")
