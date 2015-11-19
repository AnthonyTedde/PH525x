library(dplyr)

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

mean.difference <- treatment.mean - control.mean


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

## variable name
sample <- c('sampleControl'
          , 'sampleTreatmentFake' )
## nil: random variable for testing the null hypothesis
nil <- vector(mode = "numeric", length = 12)

for(i in 1:1000){
    sample.control <- sample(x = unlist(femaleControlsPopulation),
                             size = 12)
    sample.treatment.fake <- sample(x = unlist(female.control.population),
                                    size = 12)
    ## abs is not yet used because as the two groups are alway the same
    ## the sign has a great importance.
    nil[i] <- mean(sample.treatment.fake) - mean(sample.control)
}
mean(nil) ## [1] 1.037894
mean(nil >= mean.difference)
