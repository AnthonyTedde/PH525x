library(downloader)
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
## download all files specified in files list
for(f in files){ 
    if(!file.exists(f))
        download(url = paste(url, f, sep = '/'),
                 destfile = f)
    f.name <- unlist(strsplit(x = f,
                              split = '[.]'))
    assign(x = f.name[1],
           read.csv(f))
} 
setwd(dir)
