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
