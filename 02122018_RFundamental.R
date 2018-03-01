# variable assignment (objects?)
x <- 5

# finding where you are
getwd()

# setwd() will change working directory
setwd("/Users/frankhsieh/Desktop/R-Fundamentals-master/data")
getwd()

ls() # lists everything in global environment
dir() # lists contents of working directory

# Day 2 - fast review
# when do we combine 1 and 2D subsetting? "Logical operations"
# what is a logical operator? Flag an argument as either TRUE or FALSE; <>== ! & |
data(iris); iris_subset = iris[iris$Sepal.Width > 3.7,4:5]; iris_subset


# Day 3 
# Domain expertise/ research question/ setting up hypotheses

# Null hypothesis (Ho) = no difference/change/correlation between groups/variables

# Alternative hypothesis (Ha) = some sort of difference/change/correlation between groups/variables

# if p > 0.05, we FAIL TO REJECT THE NULL HYPOTHESIS and by default accept the conditions of the null hypothesis

# if p < 0.05, we REJECT THE NULL HYPOTHESIS and by default accept the conditions of the alternate hypothesis

# Challenge 1 - load the "animals.csv" file from the R fundamental data folder
getwd()
setwd("data/")
dir()
animals <- read.csv(file = "animals.csv", # required argument
                    header = T,           # optional/default
                    stringsAsFactors = T) # optional/default
str(animals)
View(animals)

# Summarize data
?summary
summary(animals)
summary(animals$Weight)
boxplot(animals$Weight,    # doesn't plot mean
        xlab = "Weight Variable",
        ylab = "Kilograms",
        main = "This is a boxplot",
        col = "gray",
        las = 1) # the orientation of numbers on y-axis
# to save the figure, use "Export". "pdf" recommended
# change axes are trickier in base R. ggplot is much easier.

mean(c(1,2,3,4,55))
median(c(1,2,3,4,55))

?describe  # no such function in base R
install.packages("psych") # once it's installed, it stays in base R. can also do this by manually adding "Packages" in the lower right corner
?library
library(psych)
?describe
describe(animals) # NA: missing data; NaN: not a number
# the warning messages after describe(animals) is because of some missing values for Type and Healthy, both of which are astericked

hist(animals$Height,
     col = "orange",
     xlab = "Height (cm)",
     main = "title goes here!",
     breaks = 20)

colnames(animals)
describe(animals[,3:5])
animals_summary <- describe(animals[,c("Weight","Height","Progress")])
animals_summary

# How do I subset this to only include: n, median, mean, and sd (in this order)
animals_small <- animals_summary[,c("n","median","mean","sd")]
animals_small

colnames(animals_summary)
animals_small2 <- animals_summary[,c(2,5,3,4)]
animasl_small2 # this does same things as the lines for animals_small

write.csv(animals_small, 
          file = "animals_small.csv",
          row.names = FALSE) # try TRUE
# describeBy lets you add a grouping variable!
animals_descBy <- describeBy(animals[,3:5],group = animals$Type)

# what if i just want descriptives for "Dogs"?
animals_descBy$Dog
animals_descBy$Dog[,c("mean","sd")]

# table and prop. table
?table
table(animals$Type)
table(animals$Type,animals$Healthy)  # "actionable insight"


# Plot data
# Test data

# Break/challenge time!
# 1) load the iris dataset
data(iris)
str(iris)
?(iris)
# 2) run summary, describe, describeBy, and table on these data
summary(iris)
str(iris)
describe(iris) # note there's an asterik for "Species". R stil gives you an answer, but it's a soft fail, and it computes that from a vector used/representing for "Species" (see output of str(iris))
describeBy(iris,group = iris$Species)
table(iris)
# 3) create a histogram and boxplots for these data
hist(iris$Sepal.Length,
     col = "blue")
boxplot(iris$Sepal.Length ~ iris$Species)
boxplot(iris$Sepal.Length ~ iris$Species,
        col = c("turquoise","salmon","goldenrod"))
boxplot(iris$Sepal.Length ~ iris$Species,
        col = c("grey40","grey60","grey80"))
colors() # list all the supported colors in R

# 4) how do you find out how to create a scatterplot?
?plot
str(iris)
plot(x= iris$Petal.Length,y=iris$Petal.Width)

# GGPLOT2 !
install.packages("ggplot2",dependencies = T)
?library
library(ggplot2)
?ggplot

### TIPS: if wanna plot scatterplot, use ggplot instead of R base functions. Use R base functions such as boxplot or plot for quick looks of your data only

# "GG" stands for "Grammar of Graphics" **********
# you need 3 things to make a ggplot:
# 1) a dataset
# 2) "aes"thetics: define coordinates, specify colors and shapes
# 3) "geom_"s: how do you want your data represented? Points, bars, lines, etc.

# GGPLOT WORKS IN LAYERS! Add a new layer with the plus sign +

# ggplot2 - histogram
ggplot(data = iris, aes(x = Petal.Length)) + # note that don't need $
  geom_histogram(bins = 40, color = "orange", fill = "blue") + # note the recommendations it provides after plotting (equivalent to breaks in base plot in base R)
  ggtitle("This is now a title") +
  xlab("Petal Length (centimeters)") + 
  theme(plot.title = element_text(hjust = 0.6277)) + # this adjust the position of the title to the graph
  theme_bw()  # this changes background color

# ggplot2 - boxplots
ggplot(data = iris, aes(x = Species, y = Petal.Length, fill = Species)) + # note that if put color = Species in geom_boxplot, it won't work, as they're different layers
  geom_boxplot(color = "black") + # try playing supplying color, fill here vs. above
  geom_point() + # if geom_point() is moved before geom_boxplot, then points will be eclipsed by boxes
  theme_minimal() +
  guides("full")
  
# color: border color
# fill: color of bars themselves

# ggplot2 - scatterplot
ggplot(data = iris, aes(x = Petal.Length, y = Petal.Width, color = Species)) +
  geom_point() +
  theme(legend.position = "right") + 
  theme_classic()


# first, subset the three species of iris flower into their own objects: "setosa" contains only 
# setosa, "versicolor" contains only versicolor
#, and "virginica" contains only virginica flowers
setosa <- iris[iris$Species == "setosa",] 
versicolor <- iris[iris$Species == "versicolor",]
virginica <- iris[iris$Species == "virginica",]

# t-test - compare mean variation between ONE or TWO GROUPS!
?t.test
t.test(setosa$Petal.Length, versicolor$Petal.Length)
t.test(setosa$Petal.Length, virginica$Petal.Length)
t.test(versicolor$Petal.Length, virginica$Petal.Length)

# multiple comparisons fail to account for the family wise error rate!

# anova - compare mean variance of MORE THAN TWO GROUPS!
?aov
animals
aov_1 = aov(Weight ~ Type, data = animals) # ~ means by. Notice we assign an aov object here
aov_2 = aov(animals$Weight ~ animals$Type) # this line does exact the same as above
summary(aov_1)

# Tukey test for Honest Significance Differences - this corrects for "family-wise error"
?TukeyHSD
TukeyHSD(aov_1)


# Pearson correlation - are two variables linearly correlated? This is a number between -1 and 1
?cor.test
cor.test(animals$Weight,animals$Height)


# simple linear regression - can one variable be used to predict another?
?lm
# syntax = Y ~ X
# "regress Y onto X" (this sounds complicated!)
# or, "can i use X to predict Y"?
# X = independent variable; input, predictor
# Y = dependent variable; response, target, outcome
lin_model = lm(Height ~ Weight, data = animals)
names(lin_model)
lin_model$coefficients
summary(lin_model)

# check out this blog (http://blog.yhat.com/posts/r-lm-summary.html) USEFUL!!

# all the test includes here are based on Sum of Squares statistical metric


install.packages("models", type = "source")
library(models)
AIC(lin_model)

