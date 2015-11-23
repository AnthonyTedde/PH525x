###############
## exercices ##
###############

## exercice Random variables PH525.1x week 2 ------------------------------

## set.Set the seed at 1, then using a for-loop take a random sample of 5 mice 1,000 times.
## Save these averages. What proportion of these 1,000 averages are
## more than 1 gram away from the average of x ?
set.seed(1)
n <- 1000
v <- vector(mode = 'numeric', length = n)
for(i in 1:n){
    tmp <- sample(x = unlist(femaleControlsPopulation), size = 50)
    v[i] <- mean(tmp)
}

mean(abs(v - mean(x))  > 1)

## Gapminder package exercices
library(gapminder)
data(gapminder)
head(gapminder)

x <- gapminder[gapminder$year == 1952, ]
## ggplot
ggplot(data = x, aes(x = lifeExp)) +
    geom_histogram() 

## ecdf. proportion of countries in 1952 that have a life expectancy
## less or equal to 40
mean(x$lifeExp <= 40)
## proportion of countries in 1052 that have a life expectancy
## in between 40 and 60
mean(x$lifeExp <= 60) - mean(x$lifeExp <= 40)
