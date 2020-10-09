# Hawkers classification: project overview
* Classify two dragonfly species (Aeshna cyanea, Aeshna juncea) using three supervised learning strategies and a set of environmental feaures used as predictors.
* Verify if the two species distribution overlaps or can potentially share the same habitats.
* Scraped over 1000 occurrences data from  GBIF and using python and spocc.
* Clean data removing occurrences with wrong coordinates using clean_coordinates
* Subsetting only european countries which host - even partially - the alpine region
* Extracting climatic and environmental data from [worldclim bioclim](https://www.worldclim.org/data/bioclim.html) and [corine land cover](https://land.copernicus.eu/pan-european/corine-land-cover) rasters, 
* Summary statistics to descibe Hawkers ecological conditions
* Linear discriminant analysis, logistic regression and random forest algorhytm to look for the best classification algorhytm

# Material and methods
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


# Introduction
The southern hawker or blue hawker (Aeshna cyanea) is a species of hawker dragonfly. The species is one of the most common and most widespread dragonflies in Europe. The total range is West Palearctic and covers a large part of Europe (to Scotland and southern Scandinavia in the North to Italy (without the Southwest) and the northern Balkans to the South); the Eastern boundary is formed by the Ural and the West by Ireland. It is also found in Northwest Africa (Algeria). In Central Europe the species is very common
(since the alogtyhtm peromofrs weel they can be tested on more species to asses also conservations status and potential risk and addressing to cinservation soultion)
  
# The dataset
The function ```occ``` within the ```spocc``` package has been used to retrieve 5000 occurrences for Aeshna cyanea and 5000 entryes for Aeshna juncea from the European contintent. A. cyanea dataset feature 112 variables while A. juncea 140. Both dataset follow [The Darwin Core](https://dwc.tdwg.org/) standard as required by GBIF. 

# Data cleaning
### Coordinates
Since occurences coordinates will be used to extract environmental and climatic data from raster our priority is to check the reliability of registered positions. The function 
```clean_coordinates``` has been used to flagging of common spatial and temporal errors. The function flag and exclude records assigned to country or province centroid, the open ocean, the headquarters of the Global Biodiversity Information Facility, urban areas or the location of biodiversity institutions. To furtherly increase data quality observations with more than 1000 m of coordinate uncertainty have been discarded. 

### Geographical region
The project is focused to discriminate species across the alpine region. Thus only occurrences falling into boundaries of Austria, Belgium, France, Germany, Italy , Luxembourg, Netherlands, Slovenia and Switzerland have been retained.

### Selecting variables
Only the following variable of the original [Darwin Core](https://dwc.tdwg.org/) format have been considered usefull for the project goal. At the end of the data cleaning process data size has been reduced to 1640 entries.
  
| Variable      | Description   |
| ------------- | ------------- |
| species       | The name ccording which the occurence has been recorded into GBIF databse  |
| scientificName| The full scientific name, with authorship and date information if known  | 
| longitude     | The geographic longitude expressed in decimal degrees (WGS84)  | 
| latitude      | The geographic latitude expressed in decimal degrees (WGS84)   | 
| elevation       | Elevation (altitude) in meters above sea level  | 
| countryCode  | The standard code for the country in which the Location occurs | 
| stateProvince | The name of the next smaller administrative region than country in which the Location occurs | 
| day  | The integer day of the month on which the Event occurred.  | 
| month  | The integer month in which the Event occurred | 
| year  | The four-digit year in which the Event occurred, according to the Common Era Calendar  | 
| eventDate  | The date-time or interval during which an Event occurred. For occurrences, this is the date-time when the event was recorded. Not suitable for a time in a geological context. | 
| endDayOfYear  | The latest integer day of the year on which the Event occurred  | 

# Data extraction
Data extraction from rasters has been carryed over using the ```raster``` function on previously loaded data.

### Wordclim Bioclim data 
Bioclimatic variables are derived from the monthly temperature and rainfall values in order to generate more biologically meaningful variables. The bioclimatic variables represent annual trends (e.g., mean annual temperature, annual precipitation) seasonality (e.g., annual range in temperature and precipitation) and extreme or limiting environmental factors (e.g., temperature of the coldest and warmest month, and precipitation of the wet and dry quarters). A quarter is a period of three months (1/4 of the year). The resolution chosen for this prject is 30 arc-seconds (Km<sup>2</sup>).

### 2018 Corine Land Cover IV levels
The Corine Land Cover (Coordination of Information on the Environment Land Cover, CLC) is referring to a European programme establishing a computerised inventory on land cover of the 27 EC member states and other European countries. The CLC raster used in this project provides a 100 m spatial resolution.




# Feature enginering
