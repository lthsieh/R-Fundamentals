# "control + l" to clear the console window
# "command + return" to run the line of code
# "+" in the console means still waiting for the remaining codes. to quit, press "escape"
# error messages in R is not so good!
2 + "Evan"

# 3 piece recipe for variable assignment
# variables is synonymous with object!
# 1) unique name
# 2) the assignemnt operator
# 3) some sort of definition
X <- 5 # equivalent to "x = 5". "<-" and "=" are both assignment operators. Spacing is not so stringent here, unlike Python

# call/retrieve what is stored in an object/variable
X

ls() # will return objects stored in your global environment
ls # returns source code, not objects in glocal environment!

# VOCAB: Function versus argument
ls # is the function
() # arguments go inside parenthesis

mean()
anova()
lm()
summary()

Y <- 12
Y


Z.updated <- X*Y
rm(Y)

# data types in R (R defult variables to numeric type)
# 1 numeric (decimals, fractions; even integers default to numeric type)
X <- 5
class(X)
# 2 integer

# 3 character (aka "text" or "string")
my_name <- "Evan"
my_dogs_name <- "Aoki"
my_dogs_name

# 4 logical
# are TRUE and FALSE only
# TRUE is stored internally as 1; FALSE is stored internally as 0
TRUE
FALSE
T
F

TRUE + TRUE
FALSE - TRUE
# 5 factor (categorized variables)


# data type "coersion" (changing data types)
X
class(X)
class(as.integer(X)) # nesting
class(X)

# remember to save your change to a variable!
X_int <- as.integer(X) # if see GLoval variable environment, you'll find the value of X_int is appended with L, which is a relic from C, standing for long
class(X_int)

# convert to character type
X_char <- as.character(X_int)
X_char
class(X_char)


# Challenge 1
# convert "my_name" to numeric value
my_name_num <- as.numeric(my_name)
my_name_num
class(my_name_num)

test <- "i'm hungry"


# data structure
# 1) sentence = paste()
# 2) vector = c()
# 3) list = list()
# 4) matrix = matrix()
# 5) data frame = data.frame()
# to get help, put a question mark before the name of the function
# 1) sentence
?paste
paste("Wow!","I","am","progamming R!")
paste0("Wow!","I","am","progamming R!")

# 2) vector: an organized group of the SAME type of data
?c
my_vector <- c(1,3,4,5,6,8,8,9)
my_vector
my_vector*5

class(my_vector)
plot(my_vector, col = "blue")
hist(my_vector, col = "blue")

vec2 <- c("Evan","Joe","Barak","Susan","Patty")
vec2
class(vec2)

vec3 <- c(TRUE,FALSE,TRUE,TRUE)
class(vec3)


# 3) list - an organized group of DIFFERENT types of data
?list
my_list <- list("Evan", TRUE, 5+2)
my_list
my_list[1]
my_list[[1]]


# 4) matrix - is an organized group of the SAME type of data, but organized into rows and columns
?matrix
my_matrix <- matrix(1:20, nrow = 5, ncol = 4)
my_matrix
my_matrix <- matrix(1:20, nrow = 5, ncol = 4, byrow = TRUE)
my_matrix


# prep for data frame
seq(from = 0, to = 8, by = 1) # this is equivalent to 0:8
0:8 # caveat is that "by" always equals one!

?runif
set.seed(1) # to constrain that the same set of random numbers are generated
# after seed is set, the same set of random numbers will be recycled
uniform <- runif(20, min = 3, max = 7)
uniform
hist(uniform)

?rnorm
normal <- rnorm(20, mean = 0, sd = 1)
hist(normal)

?sample
character <- sample(c("Cat","Dog","Pig"),
                  size = 20,
                  replace = TRUE) # is replace is set to FALSE, then error message, because the population is not big enough
character

# sample 20 random draws from the vector 5:10
integer <- sample(seq(from = 5, to = 10, by = 1),size = 20, replace = TRUE)
integer

# sample 20 random draw from a vector of TRUE and FALSE
boolean1 <- sample(c(TRUE,FALSE),size = 20, replace = TRUE)
boolean1

# 5) data frame
# a data frame is an organized group of equal length vectors
?data.frame

animals <- data.frame(uniform,normal,character,integer,boolean1)
animals
View(animals)


# my new best friend
?str
str(animals)
class(animals)
nrow(animals)
ncol(animals)
dim(animals)
head(animals,n=2) # return the "n" top rows (original row numbers are retained)
tail(animals,n=2) # return the "n" bottom rows (original row numbers are retained)
colnames(animals)
colnames(animals) <- c("Weight","Progress","Tyoe","Height","Healthy")
animals
head(animals)
str(animals)
# obs = observations or rows
# variables = columns or vectors
summary(animals) # in general, one'd use str() more often than summary()

# the dollar sign operator
# what if i just want to see the "Progress" vector/column/variable?
animals$Progress
hist(animals$Progress,col = "lightblue",main="A histogram")
plot(x=animals$Progress,y=animals$Weight)

# what if wanna change order of columns
# (preview of two-dimentional subsetting)
# bracket notation [ , ]
# [rows,columns]
animals2 <- animals

colnames(animals2)
animals2 <- animals2[,c("Tyoe","Healthy","Weight","Height","Progress")]
colnames(animals2)
animals2

animals[1:10,] #rows 1 through 10
animals[c(1:5,12),] # rows 1 through 5 AND 12
animals[c(1:5,12),c(1,2)] 
animasl[c(1:5,12),c("Weight","Progress")] # this line does same thing as above line

# save your data frame
?write.csv
write.csv(x=animals,file="02052018DataFrameF.csv",row.names = F) #F or T determines whether to print row names/numbers

# to find out where you're
getwd()
setwd("/Users/frankhsieh/Desktop/")
