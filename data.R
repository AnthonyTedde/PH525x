source('download.R')
## get initial directory
dir <- getwd()
setwd('~/data/')
url <- paste('https://raw.githubusercontent.com',
             'genomicsclass',
             'dagdata',
             'master',
             'inst',
             'extdata',
             sep = '/')
## list containing all files to be download
files <- c('femaleControlsPopulation.csv',
           'femaleMiceWeights.csv',
           'mice_pheno.csv')
downloadAndSet(url, files)
setwd(dir)
