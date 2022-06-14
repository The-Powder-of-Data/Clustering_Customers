# **Clustering Bank Customers**

- **What**: Identify customer groups & demographics from banking behaviour data
- **How**: Through EDA, feature engineering, PCA and K-means clustering 
- **Why**: Better understand different types of customers and how bestto serve their needs on our service. This will enable better customer engagement and satisfaction with our serivice offerings, ultimatly creating increased brand equity. 


## **Process**
![Process Flow](output/content/clustering_flow.jpg)

## **Data**
Account and transaction data from customers in 1995 has been used for this project. Connecting to an externally hosted databse I explores the structure and relationships between tables using SQL. Inital EDA was then done server side and only when needed data was extracted to be using in a jupyter notebook. 

![DB Tables](output/content/db_map.png)

I have included a SQLite file in this repo to show the data being worked with if you would like to explore. There is also a 'sql_scrap' file which I used as a rough doc to do a few basic querries. 

## **Results**
The aim was to keep our clusters to a maximum of 5. 

- Approach 1: Using only demographic data from accounts
- Approach 2: Using transactional data to cluster

### **Approach 1:** Demographic Data
Cleaning and transforming the data features used were: 
![A1 Features](output/content/1_feat_eng.png)

PCA was then used to allow visulizations in lower dimensions. As a rule of thumb the aim was to have 85% of variance explained in the reduced dimensions. 

![A1 Radial Chart](output/content/1_radial.jpg)

### **Approach 2: **Transactional Data
For this apporach I explored engineering a variety of features. The final two I landed on that had benificial impact in segtmenting customers was: 
- Credit to Income Ratio
- Avg spend per transaction

As seen in the Cumulative Explained Variance and Scree plots bellow, 6 dimnesions was the sweet spot for explaining 85% of the variance. This however does make it more dificult to visulize the total relationships as we really only have 2/3/4 dimensions that we can percieve. 
![PCA](output/content/2_PCA.jpg)


![A2 Radial Chart](output/content/2_radar_combo_resize.jpg)