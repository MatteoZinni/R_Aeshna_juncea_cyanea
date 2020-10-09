# Hawkers classification: 

## Table of contents
<!--ts-->
- [1.0.0 Project overview](#Project-overview)
- [1.1.0 Introduction](#Introduction)
- [2.0.0 Material and methods](#Material-and-methods)
- [3.0.0 The dataset](#The-dataset)
- [3.1.0 Data cleaning](#Data-cleaning)
- [3.1.1 Coordinates](#Coordinates)
- [3.1.2 Geographical region](#Geographical-region)
- [3.1.2 Selecting variables](#Selecting-variables)
- [4.1.0 Data extraction](#Data-extraction)
- [4.1.0 Feature engineering and data editing](#Feature-engineering-and-data-editing) 
- [5.1.0 Exploratory data analysis](#Exploratory-data-analysis) 
<!--te-->




## Project overview
* Classify two dragonfly species (Aeshna cyanea, Aeshna juncea) using three supervised learning strategies and a set of environmental feaures used as predictors.
* Verify if the two species distribution overlaps or can potentially share the same habitats.
* Scraped over 1000 occurrences data from  GBIF and using python and spocc.
* Clean data removing occurrences with wrong coordinates using clean_coordinates
* Subsetting only european countries which host - even partially - the alpine region
* Extracting climatic and environmental data from [Worldclim Bioclim](https://www.worldclim.org/data/bioclim.html) and [Corine Land Cover](https://land.copernicus.eu/pan-european/corine-land-cover) rasters, 
* Summary statistics to descibe Hawkers ecological conditions
* Linear discriminant analysis, logistic regression and random forest algorhytm to look for the best classification algorhytm

## Introduction
The southern hawker or blue hawker (Aeshna cyanea) is a species of hawker dragonfly. The species is one of the most common and most widespread dragonflies in Europe. The total range is West Palearctic and covers a large part of Europe (to Scotland and southern Scandinavia in the North to Italy (without the Southwest) and the northern Balkans to the South); the Eastern boundary is formed by the Ural and the West by Ireland. It is also found in Northwest Africa (Algeria). In Central Europe the species is very common
(since the alogtyhtm peromofrs weel they can be tested on more species to asses also conservations status and potential risk and addressing to cinservation soultion)

## Material and methods
* R Studio verion: 3.6.3
* Packages: 
    * occurences download: [```spocc```](https://cran.r-project.org/web/packages/spocc/spocc.pdf)
    * data cleaning: [```CoordinateCleaner```](https://cran.r-project.org/web/packages/CoordinateCleaner/CoordinateCleaner.pdf)
    * data extraction: [```rgdal```](https://cran.r-project.org/web/packages/rgdal/rgdal.pdf), [```raster```](https://cran.r-project.org/web/packages/raster/raster.pdf),
    [```sp```](https://cran.r-project.org/web/packages/sp/sp.pdf)
    * summary statistics: [```ggplot2```](https://cran.r-project.org/web/packages/ggplot2/ggplot2.pdf), 
    [```corrplot```](https://cran.r-project.org/web/packages/corrplot/corrplot.pdf)
    * modeling: [```MASS```](https://cran.r-project.org/web/packages/MASS/MASS.pdf), [```randomForest```](https://cran.r-project.org/web/packages/randomForest/randomForest.pdf)
* [GBIF](https://www.gbif.org/)
* [worldclim bioclim](https://www.worldclim.org/data/bioclim.html)
* [corine land cover IV level](https://land.copernicus.eu/pan-european/corine-land-cover)
  
## The dataset
The function ```occ``` within the ```spocc``` package has been used to retrieve 5000 occurrences for Aeshna cyanea and 5000 entryes for Aeshna juncea from the European contintent. A. cyanea dataset feature 112 variables while A. juncea 140. Both dataset follow [The Darwin Core](https://dwc.tdwg.org/) standard as required by GBIF. 

## Data cleaning
### Coordinates
Since occurences coordinates will be used to extract environmental and climatic data from raster our priority is to check the reliability of registered positions. The function 
```clean_coordinates``` has been used to flagging of common spatial and temporal errors. The function flag and exclude records assigned to country or province centroid, the open ocean, the headquarters of the Global Biodiversity Information Facility, urban areas or the location of biodiversity institutions. To furtherly increase data quality observations with more than 1000 m of coordinate uncertainty have been discarded. 

### Geographical region
The project is focused to discriminate species across the alpine region. Thus only occurrences falling into boundaries of Austria, Belgium, France, Germany, Italy , Luxembourg, Netherlands, Slovenia and Switzerland have been retained.

### Selecting variables
Only the following variable of the original [Darwin Core](https://dwc.tdwg.org/) format have been considered usefull for the project goal. At the end of the data cleaning process data size has been reduced to 1640 entries.
  
| Variable      | Description   |
| ------------- | ------------- |
| ```species```       | The name ccording which the occurence has been recorded into GBIF databse  |
| ```scientificName```| The full scientific name, with authorship and date information if known  | 
| ```longitude```    | The geographic longitude expressed in decimal degrees (WGS84)  | 
| ```latitude```      | The geographic latitude expressed in decimal degrees (WGS84)   | 
| ```elevation```       | Elevation (altitude) in meters above sea level  | 
| ```countryCode```  | The standard code for the country in which the Location occurs | 
| ```stateProvince``` | The name of the next smaller administrative region than country in which the Location occurs | 
| ```day```  | The integer day of the month on which the Event occurred.  | 
| ```month```  | The integer month in which the Event occurred | 
| ```year```  | The four-digit year in which the Event occurred, according to the Common Era Calendar  | 
| ```eventDate```  | The date-time or interval during which an Event occurred. For occurrences, this is the date-time when the event was recorded. Not suitable for a time in a geological context. | 
| ```endDayOfYear```  | The latest integer day of the year on which the Event occurred  | 

## Data extraction
Data extraction from rasters has been carryed over using the ```raster``` function on previously loaded data. Bioclimatic variables are derived from the monthly temperature and rainfall values in order to generate more biologically meaningful variables (30 arc-seconds spatial resolution - Km<sup>2</sup>). Land cover (100 m spatial resolution  comes from the 2018 Corine Land Cover. CLC is referring to a European programme establishing a computerised inventory on land cover of the 27 EC member states and other European countries.

## Feature engineering and data editing
To better describe the ecology of the two species some variables have been edite/engineered 
* **Aridity index** (```ai```): the aridity index has been calculated using the formula proposed by De Martonne. The index values have been splitted according climate type (```ai_climate```).
* **CLC value**: the value of the Corine Land Cover habitat has been converted according land cover type (```CLC_hab```).
* **Flight season**: to describe occurrences along months days (```day```) have been grouped accoridng different levels frome the ealiest to the laste week of the month.
* **Month**: this variable (```month```) has been converted from numerical to factor (```Month```) to look at frequency of occurrences along time.

## Exploratory data analysis
