# Protected Bike Lanes in NYC and Where They're Needed Most

![image](https://github.com/user-attachments/assets/074af809-d7c3-4380-846d-41c5a4873bdd)


Data Sources:

https://data.cityofnewyork.us/dataset/New-York-City-Bike-Routes-Map-/9e2b-mctv

https://data.cityofnewyork.us/Public-Safety/Motor-Vehicle-Collisions-Crashes/h9gi-nx95/about_data

https://data.cityofnewyork.us/City-Government/Community-Districts/yfnk-k7r4

QGIS PROCESS DESCRIPTION

To create the first map, I started by simply adding the shapefiles for bike lanes and community districts to a project and adding the positron basemap to give context for the locations of the bike lanes. I then used the filter tool to remove bike lanes that were not class I from the map, as this project is focusing on protected/separated bike lanes and many bike lanes in the dataset are nothing more than regular streets with sharrows or bikes painted on them. After this, I used the reproject tool on the bike maps layer to allow me to create a buffer in units of square miles. I then created a buffer of ¼ mile on the bike lanes layer and used dissolve to keep the buffer as easily interpretable as possible. Next, I used the intersect tool to overlay the community districts onto the bike lane buffer, allowing me to segment each portion of the buffer by the community district that portion of the buffer is in. This intersection layer kept all data from both layers so that I would be able to calculate the percentage of the CD covered by the bike lane buffer. Using the field calculator, I calculated the area in sq mi of both the CD (the dataset provided area in sq meters) and the bike lane buffer in the CD, and then calculated a third field dividing the buffer’s area by the district’s area. This percentage was then used as the variable for symbolize to create the choropleth seen in the assignment, which I then styled both in the symbology editor as well as in the print layout editor for the legend.

For the bike lane need score map, I added a delimited text layer using the Motor vehicle collisions dataset. Prior to adding this to QGIS, I used R to clean the data and remove all datapoints older than my desired cutoff date and all of the data that did not involve cyclists. I then added the community districts shapefile and used the points in polygon tool to count the number of collisions with a cyclist in each community district (using this field I created the choropleth showing number of crashes in each CD). I then found the maximum number of collisions in a community district based on the maximum value of that field in the symbology histogram, and used this to normalize the calculated score. Using the field calculator, I calculated a “Bike Lane Need Score” in order to identify the CDs low protected bike lane coverage and high numbers of cyclist collisions, calculated simply by (1 - protected_lane percentage) + (# of collisions in district / maximum number of collisions in a district). I then used this field as the variable in symbology to create the choropleth shown in the Medium post. 
