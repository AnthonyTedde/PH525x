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
    f.name <- f.name[length(f.name) - 1]
    if(grepl('[_]', f.name)){
        tmp <- unlist(strsplit(x = f.name,
                               split = '[_]'))
        for(i in 2:length(tmp)){
            tmp[i] <- paste(toupper(substring(text = tmp[i],
                                              first = 1,
                                              last = 1)),
                            substring(text = tmp[i],
                                      first =2),
                            sep = '')
        }
        f.name <- paste(tmp, collapse = '')
    } 
    print(f.name)
    assign(x = f.name[1],
           read.csv(f))
} 
setwd(dir)
