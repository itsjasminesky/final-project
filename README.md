---
title: "INFO201 Project Proposal"
author: "Jian Che, Erin Morales, Jasmine Y"
date: "7/22/2022"
output:
  html_document: default
  pdf_document: default
---


## Domain of interest
### 1. Why are you interested in this field/domain? 

We believe happiness and health go hand in hand. The range of personal, social, economic, and environmental factors that influence health status are known as determinants of health but can also account for a population's happiness. We believe an intersectional lens is vital in identifying key factors that play into an individual's happiness. In turn, using multidimensional data could be crucial in implementing evidence-based policies to serve the public through an intersectional lens better. 

### 2. What other examples of the data-driven project have you found related to this domain (share at least 3)?

- Project1:

[Implementation of economic policies based on each country's Hofstede cultural dimensions and why it can bring long-lasting impacts](https://dataverse.nl/dataset.xhtml?persistentId=doi:10.34894/IBMS29)

- Project 2: 

[Influence of cultural factors on Trust in automation](https://search.gesis.org/research_data/datasearch-httpwww-da-ra-deoaip--oaioai-da-ra-de570443)



- Project 3: 

[Worldwide Happiness analysis](https://github.com/anishsingh20/World-Happiness-analysis)


- Project 4: 

[App for using world happiness level as a factor to consider retirement immigration](https://github.com/UBC-MDS/DSCI_532_Group18_Allstars-R)


### 3. What data-driven questions do you hope to answer about this domain (share at least 3)?

- 1. Do cultural values increase or decrease the happiness of a population?

- 2. How is GDP or economic status linked to the world happiness index? 

- 3. What policies can be implemented to help preserve or increase the health and happiness of a population? 

- 4. Can a multidimensional data perspective help narrow down key factors in determinants of health? 




## Finding Data

**Dataset 1**

1. Where did you download the data (e.g., a web URL)?

World Happiness Report: 
https://www.kaggle.com/datasets/mathurinache/world-happiness-report

2. How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data) and who or what the data is about?

It’s a set of data on World Happiness from 2015 to 2022, so it contains a total of 8 csv files within the set. The joy scores and rankings utilize information from the Gallup World Survey. The scores are based on answers to the most life evaluation address inquired within the survey. This file contains the Happiness Score for 153 countries and the factors used to explain the score.

*Helliwell, John F., Richard Layard, Jeffrey Sachs, and Jan-Emmanuel De Neve, eds. 2020. World Happiness Report 2020. New York: Sustainable Development Solutions Network*

3. How many observations (rows) are in your data?

For the 2015.csv file, there are 158 rows. And the row number varies for the other years. 

4. How many features (columns) are in the data?

For the 2015.csv file, there are 12 columns, with features: Country, region, happiness rank, happiness score, standard error, economy (GDP per Capita), family, health (life expectancy), freedom, trust (Government Corruption). 

5. What questions (from above) can be answered using the data in this dataset?

What is the average happiness score for each region? What is the maximum happiness score in 2015? Which country’s happiness score increased the most from 2015 to 2022? Which country’s happiness score dropped the most from 2015 to 2022? 
 

**Dataset 2**

1. Where did you download the data (e.g., a web URL)?

GeertHofstedeCulturalDimension: 
https://data.world/adamhelsinger/geerthofstedeculturaldimension
 
2. How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?

The data was collected by Adam Helsinger five years ago, and the data set on data.world was also hosted by him. The Geert Hofstede's cultural dimensions theory proposes a method of analyzing cultures based on a handful of continuums. Power distance index (PDI), Individualism vs. collectivism (IDV), Uncertainty avoidance index (UAI), Masculinity vs. femininity (MAS), Long-term orientation vs. short-term orientation (LTO), Indulgence vs. restraint (IND). More information about the Hofstede's cultural dimensions can be found at: https://en.wikipedia.org/wiki/Hofstede's_cultural_dimensions_theory. 

*Helsinger, A. (2017, March 5). GeertHofstedeCulturalDimension. Data.world; data.world. https://data.world/adamhelsinger/geerthofstedeculturaldimension*

3. How many observations (rows) are in your data?

There are 111 rows in my data file. 

4. How many features (columns) are in the data?

There are 8 columns in my data file containing: country short-code, country name, PDI, IDV, UAI, MAS, LTO, IND. 

5. What questions (from above) can be answered using the data in this dataset?

Which country has the highest PDI score? Rank the countries’ IDV score; what trend do you see? What’s the average UAI score for Europe? Do you see any particular cases that stood out? 
 

 
**Dataset 3**

1. Where did you download the data (e.g., a web URL)?

World Bank GDP Ranking: 
https://www.kaggle.com/datasets/theworldbank/world-bank-gdp-ranking

2. How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or what the data is about?

This dataset is hosted and owned by the World Bank. The World Bank GDP ranking has information on each country’s GDP rankings and GDP in dollars in the year 2019. 
*World Bank. (2019). World Bank GDP ranking. Kaggle.com. https://www.kaggle.com/datasets/theworldbank/world-bank-gdp-ranking?select=gdp-csv-.csv*

3. How many observations (rows) are in your data?

There are 191 rows of useful information in my data. 

4. How many features (columns) are in the data?

There are 4 useful columns (no NULL!) containing: country name, ranking, economy, and others.

5. What questions (from above) can be answered using the data in this dataset?

Which country has the highest GDP in 2019? Is GDP a useful measurement without the consideration of population? How is GDP or economic status linked to the world happiness index? 

