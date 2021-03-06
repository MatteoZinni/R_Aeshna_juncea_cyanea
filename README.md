# Hawkers classification: 
<p float="center">
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_images/aeshnid_a_cyanea.JPG" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_images/aeshnid_a_cyanea.JPG" width="250" height="250" />
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_images/aeshnid_a_juncea.JPG" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_images/aeshnid_a_juncea.JPG" width="400" height="250" />
</p>

## Table of contents
<!--ts-->
- [1.0.0 Project overview](#Project-overview)
- [1.1.0 Findings](#Findings)
- [1.2.0 Introduction](#Introduction)
- [2.0.0 Material and methods](#Material-and-methods)
- [3.0.0 The dataset](#The-dataset)
- [3.1.0 Data cleaning](#Data-cleaning)
    - [3.1.1 Coordinates](#Coordinates)
    - [3.1.2 Geographical region](#Geographical-region)
    - [3.1.2 Selecting variables](#Selecting-variables)
- [4.1.0 Data extraction](#Data-extraction)
- [4.1.0 Feature engineering and data editing](#Feature-engineering-and-data-editing) 
- [5.1.0 Exploratory data analysis](#Exploratory-data-analysis) 
- [6.1.0 Model building](#Model-building) 
- [6.2.0 Model accuracy](#Model-accuracy)
<!--te-->

## Project overview
* Classify two dragonfly species (*Aeshna cyanea* and *Aeshna juncea*) using three supervised learning strategies and a set of environmental features used as predictors.
* Verify if the two species distribution overlaps or if they can potentially share the same habitats.
* Scraped over 1000 occurrences data from  GBIF and using R and spocc.
* Clean data removing occurrences with wrong coordinates using clean_coordinates.
* Subsetting only European countries which host - even partially - the Alpine region.
* Extracting climatic and environmental data from [Worldclim Bioclim](https://www.worldclim.org/data/bioclim.html) and [Corine Land Cover](https://land.copernicus.eu/pan-european/corine-land-cover) rasters.
* Summary statistics to descibe Hawkers ecological conditions.
* Linear discriminant analysis, logistic regression and random forest algorithm to look for the best classification algorithm.

## Findings
The random forest algorithm has been used to successfully discriminate the two dragonfly species according to a set of climatic variables derived from raster data. The most influent variable is ```maxtwam``` and it is quite well explanatory of the ecology of the two species. *A. cyanea* shows a more thermophilous ecology and since the ```elevation``` parameter hase been discarded, an increase of the temperature with the reduction of the thermal differences may cause the two species to compete.

<p float="center">
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_rf_important_var.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_rf_important_var.png" width="500" height="500" /> 
    
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_maxtwam_kernel.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_maxtwam_kernel.png" width="400" height="400" />        
</p>    

## Introduction
The southern hawker or blue hawker (*Aeshna cyanea*) is a large and gaudy hawker, its dark body inlaid with bright nuggets of apple-green and sky-blue. These dragonflies mainly inhabit well-vegetated small ponds and garden ponds, but they wander widely and they are often seen in gardens and open woodland. The common hawker (*Aeshna juncea*) can be considered the archetypal hawker, large and dark, marked with yellow to bluish spots and bands. Its habitat is largerly restricted to acidic heathy lakes but can be found in most  types of standing water at higher altitude. 

## Material and methods
* R Studio version: 3.6.3
* Packages: 
    * occurrences download: [```spocc```](https://cran.r-project.org/web/packages/spocc/spocc.pdf)
    * data cleaning: [```CoordinateCleaner```](https://cran.r-project.org/web/packages/CoordinateCleaner/CoordinateCleaner.pdf)
    * data extraction: [```rgdal```](https://cran.r-project.org/web/packages/rgdal/rgdal.pdf), [```raster```](https://cran.r-project.org/web/packages/raster/raster.pdf),
    [```sp```](https://cran.r-project.org/web/packages/sp/sp.pdf)
    * summary statistics: [```ggplot2```](https://cran.r-project.org/web/packages/ggplot2/ggplot2.pdf), 
    [```corrplot```](https://cran.r-project.org/web/packages/corrplot/corrplot.pdf)
    * modeling: [```MASS```](https://cran.r-project.org/web/packages/MASS/MASS.pdf), [```randomForest```](https://cran.r-project.org/web/packages/randomForest/randomForest.pdf)
* [GBIF](https://www.gbif.org/)
* [worldclim bioclim](https://www.worldclim.org/data/bioclim.html)
* [corine land cover IV level](https://land.copernicus.eu/pan-european/corine-land-cover)
  
## [The dataset](https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/01_aeshna_juncea_cyanea_occurences_download.R)
The function ```occ``` within the ```spocc``` package has been used to retrieve 5000 occurrences for *Aeshna cyanea* and 5000 entries for *Aeshna juncea* from the European continent. *A. cyanea* dataset feature 112 variables while *A. juncea* 140. Both datasets follow [The Darwin Core](https://dwc.tdwg.org/) standard as required by GBIF. 

## [Data cleaning](https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/02_aeshna_juncea_cyanea_data_cleaning.R)
### Coordinates
Since occurrences coordinates will be used to extract environmental and climatic data from raster our priority is to check the reliability of registered positions. The function 
```clean_coordinates``` has been used to flagging of common spatial and temporal errors. The function flags and excludes records assigned to country or province centroid, the open ocean, the headquarters of the Global Biodiversity Information Facility, urban areas or the location of biodiversity institutions. Records with more than 1000 m of coordinate uncertainty have been discarded to increase data qualtiy.

### Geographical region
The project is focused to discriminate species across the Alpine region. Thus only occurrences that have been retained are those falling into boundaries of Austria, Belgium, France, Germany, Italy , Luxembourg, Netherlands, Slovenia and Switzerland.

![](Aeshna_images/aeshnid_map.png)

### Selecting variables
Only the following variables of the original [Darwin Core](https://dwc.tdwg.org/) format have been considered useful for the project goal. At the end of the data cleaning process, data size has been reduced to 373 entries.
  
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

## [Data extraction](https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/03_aeshna_juncea_cyanea_data_extraction.R)
Data extraction from rasters has been carried over using the ```raster``` function on previously loaded data. Bioclimatic variables are derived from the monthly temperature and rainfall values in order to generate more biologically meaningful variables (30 arc-seconds spatial resolution - Km<sup>2</sup>). Land cover (100 m spatial resolution)  comes from the 2018 Corine Land Cover. CLC is referring to a European program establishing a computerized inventory on land cover of the 27 EC member states and other European countries.

|Variable | Wordclim name    | Description|
|---------|-----|-----|
|```amt```| BIO01    |Annual Mean Temperature  |
|```mdr```| BIO02    |Mean Diurnal Range (Mean of monthly (max temp - min temp))  |
|```ist```| BIO03  |Isothermality (BIO2/BIO7) (×100)  |
|```tse```| BIO04     |Temperature Seasonality (standard deviation ×100)  |
|```maxtwam```| BIO05 |Max Temperature of Warmest Month  |
|```mintcom```| BIO06  |Min Temperature of Coldest Month  |
|```tar```| BIO07     |Temperature Annual Range (BIO5-BIO6)  |
|```mintwq```| BIO08  |Mean Temperature of Wettest Quarter  |
|```mintdrq```| BIO09 |Mean Temperature of Driest Quarter  |
|```mtwaq```| BIO10   |Mean Temperature of Warmest Quarter  |
|```mtcoq```| BIO11   |Mean Temperature of Coldest Quarter  |
|```ara```| BIO12     |Annual Precipitation  |
|```rawen```| BIO13   |Precipitation of Wettest Month  |
|```radrm```| BIO14   |Precipitation of Driest Month  |
|```pse``` | BIO15    |Precipitation Seasonality (Coefficient of Variation)  |
|```raweq```| BIO16   |Precipitation of Wettest Quarter  |
|```radrq```| BIO17   |Precipitation of Driest Quarter  |
|```rawaq```| BIO18   |Precipitation of Warmest Quarter  |
|```racoq```|  BIO19  |Precipitation of Coldest Quarter  |
|```ai``` |    -  |Aridity index values according De Martonne  |


## Feature engineering and data editing
To better describe the ecology of the two species some variables have been edited/engineered:
* **Aridity index** (```ai```): the aridity index has been calculated using the formula proposed by De Martonne. The index values have been splitted according to climate type (```ai_climate```).
* **CLC value**: the value of the Corine Land Cover habitat has been converted according to land cover type (```CLC_hab```).
* **Flight season**(```season```): to describe occurrences within monthly observations, days (```day```) have been grouped by flight period, from the earliest to the latest week of the month.
* **Month**: this variable (```month```) has been converted from numerical to factor (```Month```) to look at frequency of occurrences.

## Exploratory data analysis
#### [Summary statistics](https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/04_aeshna_juncea_cyanea_summary_statistics.R)

Descriptive statistics have been calculated for numerical variables
|Variable |n    |min    |1st qrt.          | median|mean   |3rd qrt.          |max   |range |sd       |var     |CV       |
|---------|-----|-------|------------------|-------|-------|------------------|------|------|---------|--------|---------|
|longitude|308  |1.56   |9.84              |10.18  |10.35  |11.75             |14.65 |13.09 |2.29     |5.23    |0.22     |
|latitude |308  |42.53  |46.46             |47.4   |48.73  |51.47             |54.7  |12.17 |3.05     |9.33    |0.06     |
|elevation|308  |1      |157               |1171.5 |1119.83|1864              |2587  |2586  |820.98   |674005.39|0.73    |
|day      |308  |1      |9                 |17     |16.54  |25                |31    |30    |8.96     |80.35   |0.54     |
|month    |308  |6      |7                 |8      |7.83   |8                 |10    |4     |0.77     |0.59    |0.1      |
|amt      |308  |-1.5   |2.1               |5.2    |5.11   |8.3               |9.9   |11.4  |3.02     |9.1     |0.59     |
|mdr      |308  |5.1    |7                 |7.8    |7.78   |8.5               |10.6  |5.5   |1.13     |1.27    |0.14     |
|ist      |308  |25     |29                |31     |30.76  |33                |36    |11    |2.13     |4.53    |0.07     |
|tse      |308  |5200   |5769.75           |6151.5 |6094.26|6330.25           |7220  |2020  |425.89   |181378.6|0.07     |
|maxtwam  |308  |9.1    |15.2              |19.45  |18.44  |21.9              |24.9  |15.8  |3.68     |13.56   |0.2      |
|mintcom  |308  |-12    |-8.83             |-7.1   |-6.33  |-2.8              |-0.2  |11.8  |3.1      |9.63    |-0.49    |
|tar      |308  |19.8   |23.1              |24.7   |24.77  |26.33             |31.3  |11.5  |2.31     |5.32    |0.09     |
|mintwq   |308  |-5.6   |9.2               |12.85  |11.52  |16.2              |17.7  |23.3  |5.27     |27.73   |0.46     |
|mintdrq  |308  |-7.7   |-4.6              |-0.55  |-0.15  |3.6               |13.1  |20.8  |4.68     |21.89   |-30.92   |
|mtwaq    |308  |-0.77  |-0.46             |-0.06  |-0.02  |0.36              |1.31  |2.08  |0.47     |0.22    |-30.92   |
|mtcoq    |308  |-0.77  |-0.46             |-0.06  |-0.02  |0.36              |1.31  |2.08  |0.47     |0.22    |-30.92   |
|ara      |308  |670    |774.5             |989    |1031.32|1251              |1722  |1052  |266.04   |70776.95|0.26     |
|rawen    |308  |73     |84                |124    |120.47 |147               |182   |109   |32.57    |1060.61 |0.27     |
|radrm    |308  |27     |43                |53     |57.58  |71                |129   |102   |19.6     |384.11  |0.34     |
|pse      |308  |7      |18                |24     |24.26  |31                |43    |36    |9.07     |82.23   |0.37     |
|raweq    |308  |215    |238               |344    |342.68 |418.25            |527   |312   |93.81    |8800    |0.27     |
|radrq    |308  |82     |139               |168    |187.42 |228               |403   |321   |64.97    |4221.33 |0.35     |
|rawaq    |308  |82     |139               |168    |187.42 |228               |403   |321   |64.97    |4221.33 |0.35     |
|racoq    |308  |82     |161.75            |183.5  |207.93 |255.25            |477   |395   |76.81    |5899.91 |0.37     |
|ai       |308  |36.49  |42.91             |66.57  |73.62  |92.99             |164.71|128.22|31.47    |990.12  |0.43     |

Plot describing data distribution of the two species among months. The two species show a similar flight timespan (first plot). The violin plot describe how *A. juncea* occurrences are more related to Alpine altitude.

<p float="center">
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_month_barplot.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_month_barplot.png" width="450" height="450" />      
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_elevation_violin.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_elevation_violin.png" width="450" height="450" />    
</p>
 
The barplot show how *A. cyanea* has more clear preferences for habitat related to temperate still water or even more dry situations. On the other hand *A. juncea* prefers moors and peat bogs.
 
<p float="center">
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_clc_barplot.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_clc_barplot.png" width="470" height="470" />   
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_isothermality_kernel.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_isothermality_kernel.png" width="470" height="470" />    
</p>    

The correlogram shows both negative and positive high correlation coefficients for some couples of variables. 

<p float="center">
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_correlogram.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_correlogram.png" width="800" height="800" />    
</p>    

## Model building
Since some variables showed high correlation coefficient, models performances may be biased. Variables with  correlation coefficient higher than 0.75 have been discarded. Test data (60% of the whole dataset, 220 observations) has been fitted to three different classification algorithms:

* [Linear discriminant analyis](https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/05_aeshna_juncea_cyanea_model_building_01_lda.R)
* [Logistic ression](https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/05_aeshna_juncea_cyanea_model_building_02_logistic.R)
* [Random forest algorythm](https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/05_aeshna_juncea_cyanea_model_building_03_random_forest.R)

Models accuracy in predicting the right species have been tested on the train data and on the whole dataset. The variables used to fit the models are reported below 

|Variable | Description|
|---------|-----|
| ```longitude```    | The geographic longitude expressed in decimal degrees (WGS84)  | 
| ```latitude```     | The geographic latitude expressed in decimal degrees (WGS84)   | 
|```mdr```| Mean Diurnal Range (Mean of monthly (max temp - min temp))  |
|```ist```  |Isothermality (BIO2/BIO7) (×100)  |
|```tse```     |Temperature Seasonality (standard deviation ×100)  |
|```maxtwam``` |Max Temperature of Warmest Month  |
|```mintcom```  |Min Temperature of Coldest Month  |
|```tar```     |Temperature Annual Range (BIO5-BIO6)  |
|```mintwq```  |Mean Temperature of Wettest Quarter  |
|```mintdrq``` |Mean Temperature of Driest Quarter  |
|```rawen```   |Precipitation of Wettest Month  |
|```radrm```   |Precipitation of Driest Month  |
|```pse```     |Precipitation Seasonality (Coefficient of Variation)  |
|```radrq```   |Precipitation of Driest Quarter  |
|```ai```      |Aridity index values according De Martonne  |

## Model accuracy
Since accuracy values for all alrogrhytms are greater than 0.75, all models can be considered suitable to solve the classification problem. 

| Algorithm    | Train data | Test data | Whole data |
|--------------|------------|-----------|------------|
| LDA          |    0.85    |    0.82   |   8.82     |
| Logistic     |    0.83    |    0.83   |   0.83     |
|Random forest |    0.93    |    0.93   |   0.93     |

The logistic model provides a good overall accuracy: ```latitude```, ```maxtwam```, ```radrm``` and ```ai``` are the most relevant feature in classify the two species.

| Parameter |    Estimate | Std. Error | z value  |  Pr(> z )    |   
|-----------|-------------|------------|----------|--------------|
|(Intercept)|  91.14763   | 25.76391   |  3.538   | 0.000403 *** |
|longitude  |  0.35636    | 0.19589    | 1.819    | 0.068883 .   |
|latitude   | -1.58398    | 0.59290    | -2.672   | 0.007550 **  |
|mdr        |  -0.02154   | 0.45459    | -0.047   | 0.962209     |
|maxtwam    |  -1.14742   | 0.24660    | -4.653   | 3.27e-06 *** |
|mintdrq    |  -0.26969   | 0.13549    | -1.990   | 0.046546 *   | 
|rawem      |   -0.06010  |  0.05904   | -1.018   | 0.308752     |
|radrm      |    0.43611  |  0.16054   |  2.716   | 0.006599 **  |
|pse        |    0.18054  |  0.18223   | 0.991    | 0.321818     |
|radrq      |   -0.03940  |  0.04774   | -0.825   | 0.409229     |
|ai         |   -0.17851  |   0.05104  | -3.498   | 0.000469 *** |

The **random forest algorythm** appears to be best among the three into correctly discriminate the two species performing with an overall accuracy of 0.93 on the test data setting at 5 the ```mtry``` parameter. According to the plot the most important variable is ```maxtwam```.

<p float="center">
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_rf_nodes.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_rf_nodes.png" width="400" height="400" />  
    
<img src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_rf_important_var.png" data-canonical-src="https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_output/Aeshna_output_figs/aeshnid_rf_important_var.png" width="400" height="400" /> 
</p>    




