# dependencies helps the package runs better
# it's recommended, but not necessary
# almost all packages have dependencies
install.packages("rmarkdown", dependencies = T) 
install.packages("knitr", dependencies = T)
library(rmarkdown)
library(knitr)
# after these four lines, open "R Fundamentals Part 4 For-loops and functions.Rmd", then "knitr" should appear in the tab in "R Fundamentals Part 4 For-loops and functions.Rmd"

# Today we will be working directly from the R markdown file named
# "R Fundamentals Part4 For-loops and functions.Rmd"
# located within your workshop materials folder. Double click it and if you see a button at the top of your RStudio with a blue ball of yarn and knitting needle, everything is working correctly!

# difference between .R and .Rmd. .Rmd enables HTML, PDF, etc. capacities
# also look up YAML
# recommended to check out what HTML is

# LATEX, .Rmd, MSWord, Plain Text