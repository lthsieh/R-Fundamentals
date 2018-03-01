(Y <- 12) # this will save the variable and call its value!
X <- 1

# remove variable X
rm(X)

numeric_data <- 4
integer <- as.integer(numeric_data)
class(integer)


FALSE < TRUE
FALSE == FALSE
FALSE > TRUE

# vector = an organized group of the same type of data
my_vector <- c(6,4,8,7,10)
my_vector

my_vector[2]

# data frame = an organized group of equal length vectors
my_data_frame <- data.frame(Name = c("Evan","Susan","Barack"), Age = c(30,40,50))

my_data_frame

Name2 <- c("Joe","Billy","John")
Age2 <- c(44,55,66)

my_data_frame2 <- data.frame(Name2,Age2)
my_data_frame2

str(my_data_frame2) # R automatically determines variable type

my_data_frame2$Name2
hist(my_data_frame2$Age2)
plot(my_data_frame2$Age2)

# change Name2 to character type
my_data_frame2$Name2 <- as.character(my_data_frame2$Name2)
str(my_data_frame2)
# change Age2 to integer type
my_data_frame2$Age2 <- as.integer(my_data_frame2$Age2)
str(my_data_frame2)

rm(animals)
rm(animals2)


# Day 2
# loading data from files
?write.csv
?read.csv

# finding where you are
getwd()

# setwd() will change working directory
setwd("/Users/frankhsieh/Desktop/R-Fundamentals-master/data")
getwd()

ls() # lists everything in global environment
dir() # lists contents of working directory

# load the animals data frame
animals <- read.csv(file = "animals.csv", header = FALSE)

# In data frame
# VARIABLE=VECTOR=COLUMN
# OBS=OBSERVATIONS=ROWS
# STRINGS=CHARACTERS=TEXTS

animals
animals <- read.csv(file = "animals.csv", header = T, stringsAsFactors = T)
str(animals)
head(animals)

# super fun preview of Monday - anova
aov1 <- aov(animals$Weight ~ animals$Type) # "~" means "by"
summary(aov1)


# Challenge 1 - load the "sleep_VIM.csv" file
sleep_VIM <- read.csv(file = "sleep_VIM.csv", header = T)
str(sleep_VIM)
head(sleep_VIM)


# one dimensional subsetting with the dollar sign $
# how do i extract only the "Dream" column from "sleep_VIM"
sleep_VIM$Dream

# a factor variable is defined as a compilation of organized groupings called "levels"
animals$Type
table(animals$Type)


# subsetting in two dimensions - bracket notation!
# [ , ]
# [rows , columns]

# let's start with subsetting multiple columns using their names
head(sleep_VIM, n = 3) # head() by default shows the top 6 rows
colnames(sleep_VIM)

# if i just want "Sleep", "Span", and "Gest", i can pass a vector of their names!
sleep_varnames <- sleep_VIM[ , c("Sleep","Span","Gest")]
sleep_varnames

# let's do this again using positive integers
colnames(sleep_VIM)
sleep_posint <- sleep_VIM[,c(5,6,7)]
sleep_posint

# do the same thing with negative integers - this will EXCLUDE columns
sleep_negint <- sleep_VIM[,-c(1:4,8:ncol(sleep_VIM))]
sleep_negint

# what about rows? what if i want rows 1:5 and 12, AND columns 5,6, and 7?
sleep_posint2 <- sleep_VIM[c(1:5,12),c(5:7)]
sleep_posint2

ncol(sleep_posint2)
nrow(sleep_posint2)
dim(sleep_posint2)

# switch back to animal data frame
animals

# use logical tests to extract just dogs! or cats! or pigs!
head(animals)
dogs <- animals[animals$Type == "Dog", c("Type","Height")]
dogs

cats <- animals[animals$Type == "Cat",]
cats

pigs <- animals[animals$Type == "Pig",]
pigs

# order data
pigs2 <- pigs[order(pigs$Height),]
pigs2
str(pigs2)

dogs_healthy <- animals[animals$Type == "Dog" & animals$Healthy | animals$Height > 9, ]
dogs_healthy

dogs_or_healthy <- animals[animals$Type == "Dog" | animals$Healthy, ]
dogs_or_healthy


# Challenge 2
# load the iris dataset
  # what is it? how do you find out?
# to find out all R datasets data()
data()
data(iris)
str(iris)
iris$Species
?iris
# subset multiple columns using their variable names
iris_varnames <- iris[,c("Petal.Length","Sepal.Width")]
head(iris_varnames)
# subset multiple columns using positive integers
iris_posint <- iris[,c(1,3,5)]
head(iris_posint)
# subset multiple columns using negative integers
iris_negint <- iris[,-5]
head(iris_negint)
# subset all the versicolor Species into a new variable named "versicolor" using logical tests
versicolor <- iris[iris$Species == "versicolor",]
versicolor


# missing (NA) data 
# R identifies missing as NA, and only NA!
?NA
# if leave spread sheet blank, R will recognize as NA automatically

sleep_VIM$Dream

mean(sleep_VIM$Dream)
mean(sleep_VIM$Dream, na.rm = T)
# less than 20% missing data? i like "column median imputation"
# Bayesian/Expectation Maximization (multiple) imputation - the Amelia 2 package (see Gary King's Amelia 2 website)

# identify missing data
?is.na
is.na(sleep_VIM)
is.na(sleep_VIM$Dream)

# how many cells contan missing data
sum(is.na(sleep_VIM))

# 38 cases are missing - what proportion of the dataset is this?
sum(is.na(sleep_VIM))/(nrow(sleep_VIM)*ncol(sleep_VIM))

# let's recode NA data to say "PIZZA"
sVIM <- sleep_VIM

sVIM

sVIM[is.na(sVIM)] <- "PIZZA"
sVIM
str(sVIM)

sVIM[sVIM == "PIZZA"] <- NA # don't name a variable NA
sVIM # <*>, the brackets tell you that something is manually changed here
str(sVIM)
sVIM$NonD <- as.numeric(sVIM$NonD)
sVIM$Dream <- as.numeric(sVIM$Dream)

# NA only equals NA; NA means "missing"
# NULL means "mothing"; no place holder
# NaN means "not a number"
# Inf/-Inf means "infinity"

# listwise deletion - if any row contains at least one missign cell, the entire row is deleted
?complete.cases
s_complete <- sVIM[complete.cases(sVIM),]
sum(is.na(s_complete))

# what if we want ONLY rows that contain MISSING DATA?
s_NA <- sVIM[!complete.cases(sVIM),]
s_NA

sum(is.na(sVIM))
sum(is.na(s_NA))

sum(is.na(sVIM)) == sum(is.na(s_NA))


# merging data
# merge, cbind, and rbind

# merge - is useful when we want to combine two data frames that share a unique identifier

df1 <- data.frame(Name = c("Joe","Susan","Jack","Kelly"),
                  City = c("Berkeley","Berkele","Oakland","Oakland"),
                  Math = c(42,48,50,46),
                  Reading = c(8,10,10,10))
df1

df2 <- data.frame(Name = c("Joe","Susan","Jack","Kelly"),
                  Science = c(99,100,99,100),
                  Music = c(19,18,20,20),
                  Art = c(20,20,19,28))
df2

# we can merge two data frames together by a unique identifier
merge_df <- merge(df1,df2,by = "Name") # merge_df <- merge(df1,df2,by = c("Name","col2",...))
merge_df

# cbind combines data frame by columns
cbind_df <- cbind(df1,df2)
cbind_df # not ideal bc it doesn't do name matching!

dfB <- data.frame(Name = c("James","Cher","Elizabeth","Barack"),
                  City = c("Cleveland","Memphis","Detroit","Chicago"),
                  Math = c(44,49,50,49),
                  Reading = c(9,9,9,10))
dfB

# rbind combines data frame by rows
rbind_df <- rbind(df1,dfB)
rbind_df






