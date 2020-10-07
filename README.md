# Hawkers classification: project overview
* Classify two dragonfly species (Aeshna cyanea, Aeshna juncea) using three supervised learning strategies and a set of environmental feaures used as predictors
* Scraped over 1000 occurrences data from  GBIF and using python and spocc.
* Clean data removing occurrences with wrong coordinates using clean_coordinates
* Extracting climatic and environmental data from rasters
* Summary statistics to descibe Hawkers ecological conditions
* Linear discriminant analysis, logistic regression and random forest algorhytm to look for the best classification algorhytm

# Introduction
The southern hawker or blue hawker (Aeshna cyanea) is a species of hawker dragonfly. The species is one of the most common and most widespread dragonflies in Europe. The total range is West Palearctic and covers a large part of Europe (to Scotland and southern Scandinavia in the North to Italy (without the Southwest) and the northern Balkans to the South); the Eastern boundary is formed by the Ural and the West by Ireland. It is also found in Northwest Africa (Algeria). In Central Europe the species is very common

# Material and methods
* R Studio verion: 3.6.3
* Packages: 
    * occurences download: [```spocc```](//github.com/https://cran.r-project.org/web/packages/spocc/spocc.pdf)
    * data cleaning: [```CoordinateCleaner```](//github.com/https://cran.r-project.org/web/packages/CoordinateCleaner/CoordinateCleaner.pdf)
