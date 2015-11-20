library(dplyr)
library(ggplot2)

setwd(file.path('~/workspace/edx/HarvardX1/'))
## Data loaded by file are:
## femaleControlsPopulation,
## femaleMiceWeights
source(normalizePath('./PH525x/data.R'))

## Create control and treatment group
data <- cbind(c('control', 'treatment'),
              c('chow', 'hf'))
colnames(data) <- c('variable.name', 'factor')
## Browse data to dynamically create
## dataframe variables:
##   *  control
##   *  treatment.
for(i in 1:length(data[, 'variable.name'])){
    tmp <-  filter(.data = femaleMiceWeights, filter = (Diet == data[i, 'factor'])) %>%
        dplyr::select(matches("Bodyweight")) %>%
        unlist 
    assign(data[i, 'variable.name'], tmp)
}

## First: calculate the mean
control.mean <- mean(control)
treatment.mean <- mean(treatment)

mean.diff <- treatment.mean - control.mean


#########################
## The null hypothesis ##
#########################
## provide the delta between control.mean and treatment.mean.
## is it significant ?

## Create two variable
##   * sample.control which contains 12 values from control population
##   * sample.treatment.fake which contain also 12 value from control population

## We can replicate the previous experiment to construct a random variable
## called nil.

## variables name
sample <- c('sampleControl'
          , 'sampleTreatmentFake' )
## length of the nil random variable
n <- 1000
## nil: random variable for testing the null hypothesis
nil <- vector(mode = "numeric", length = n)

## Treatment and control are made from the same population to controle
## the fat diet effect.
for(i in 1:n){
    for(s in sample)
        assign(s ,sample(x = unlist(femaleControlsPopulation),
                         size = 12))
    ## abs is not yet used because as the two groups are alway the same
    ## the sign has a great importance.
    nil[i] <- mean(sampleTreatmentFake) - mean(sampleControl)
}

## p-value calculus:
## mean is used to give the frequency of occurence of TRUE values
##  from the statement given into parenthesis
mean(abs(nil) >= mean.diff)

###############
## exercices ##
###############
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
