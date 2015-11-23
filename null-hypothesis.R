## Load library ------------------------------
library(dplyr)
library(ggplot2)

setwd(file.path('~/workspace/edx/HarvardX1/'))
## Data loaded by file are:
## femaleControlsPopulation,
## femaleMiceWeights

## Load Data ------------------------------
source(normalizePath('./PH525x/data.R'))

## Create Group ------------------------------
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

## mean ------------------------------
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

## Treatment and control are made from the same population for controlling
## the fat diet effect.
for(i in 1:n){
    for(s in sample)
        assign(s ,sample(x = unlist(femaleControlsPopulation),
                         size = 12))
    nil[i] <- mean(sampleTreatmentFake) - mean(sampleControl)
}

## p-value calculus:
## mean is used to give the frequency of occurence of TRUE values
##  from the statement given into parenthesis
mean(abs(nil) >= mean.diff)

## Distribution ------------------------------
bottom <- floor(min(nil))
top <- ceiling(max(nil))
values <- seq(bottom, top, len = 300)

pdf('PH525x/ecdf-with-plot.pdf')
plot(values,
     ecdf(nil)(values),
     typ = 'l')
dev.off()

## Same distribution curve with ggplot

nil_df <- as.data.frame(nil)            #  transform nil from vector to df
                                        # to be used into ggplot
names(nil_df) <- 'avg'

pdf('PH525x/ecdf-with-ggplot2.pdf')
ggplot(nil_df,
       aes(x = avg)) +
    stat_ecdf()
dev.off()

## probality distribution
## with histogram representation

pdf('PH525x/probability-distribution.pdf')
ggplot(nil_df,
       aes(x = avg)) +
    geom_histogram(binwidth = 1,
                   fill = '#22AA22',
                   colour = '#222222') +
    geom_vline(aes(xintercept = mean.diff),
               colour = '#AA2222',
               size = 1)
dev.off()
