library(dplyr)

setwd(file.path('~/workspace/edx/HarvardX1/'))
## Data loaded by file are:
## femaleControlsPopulation,
## femaleMiceWeights
source(normalizePath('./PH525x/data.R'))

## Constitue control and treatment group
control <- filter(.data = dat, filter = (Diet == 'chow')) %>%
    dplyr::select(matches("Bodyweight")) %>%
    unlist
treatment <- filter(.data = dat, filter = (Diet == 'hf')) %>%
    dplyr::select(Bodyweight) %>%
    unlist

control.mean <- mean(control)
treatment.mean <- mean(treatment)

mean.difference <- abs(control.mean - treatment.mean)

#########################
## The null hypothesis ##
#########################
## provide the delta between control.mean and treatment.mean.
## is it significant ?

sample.control <- sample(x = unlist(female.control.population)
                       , size = 12)
sample.treatment.fake <- sample(x = unlist(female.control.population)
                              , size = 12)

## We can replicate the previous experiment to construct a random variable
## called nil.
nil <- vector(mode = "numeric", length = 12)
for(i in 1:1000){
    sample.control <- sample(x = unlist(female.control.population),
                             size = 12)
    sample.treatment.fake <- sample(x = unlist(female.control.population),
                                    size = 12)
    ## abs is not yet used because as the two groups are alway the same
    ## the sign has a great importance.
    nil[i] <- mean(sample.treatment.fake) - mean(sample.control)
}
mean(nil) ## [1] 1.037894
mean(nil >= mean.difference)

################################################
## Cumulative Distribution Fuction            ##
## or                                         ##
## Empirical cumulative distribution function ##
################################################
## concept of distribution with package UsingR
## Just for instancle.
library(UsingR)
x <- father.son$fheight
round(sample(x, 10), 1)                 # one decimal

head <- floor(min(x))
tail <- ceiling(max(x))
values <- seq(head, tail, len = 300)
heightexdf <- ecdf(x)
plot(values, heightexdf(values), type = 'l')

## ECDF of sample
## with the nil hypothesis value
smallest <- floor( min(nil) )
biggest <- ceiling( max(nil) )
values <- seq(smallest, biggest, len = 300) # values containt vector of 300 items
                                        # from -5 to 5 symetrically distributed
height.ecdf <- ecdf(nil)                # Empirical cumulative
plot(values, height.ecdf(values), type = 'l')

## 
## How does ecdf works?
## 
first <- nil[1]
## numeric subsetting
## All value less than first.
nil.subset.first = nil[nil <= first]
a <- length(nil.subset.first) / length(nil)
b <- height.ecdf(first)
a == b                                  # T
