# Simple Linear Regression with R
> Exercise from course "R Programming for Statistics and Data Science" on Udemy
###### *Note: I used the RStudio IDE when completing this exercise.*

### Loading the necessary packages
```R
library(tidyverse)
library(psych)
```
The .R file utilizes functions in packages such as ```readr, ggplot2, forcats``` within the **```tidyverse```** collection. Also, performing the correlation test and fitting the linear model required functions from the R ```stats``` package.


### Importing the CSV file
To run the code below, first verify that the file is located in your current working directory. 
```R
housing <- read_csv("real_estate_price_size_year_view.csv")
```

Here are the first couple rows of the data:

![firstrows](https://user-images.githubusercontent.com/96803412/148123597-87661ece-08b9-4c21-b05c-3858812851c4.PNG)


### Exploring the data to find trends

#### Kendall correlation test (nonparametric)

![Hypothesis](https://user-images.githubusercontent.com/96803412/148128025-21ec95ef-b7ae-41cc-85d7-67f2284fa17d.png)
```R  
cor.test(housing$size, housing$price, method = "kendall") 
```

##### Output of the test

![KendallCorTest](https://user-images.githubusercontent.com/96803412/148124315-b8cf79fb-ee7e-43c4-92a6-3550c0b05377.PNG)
- Positive correlation coefficient of **0.6115972**. As house size increases, price increases.
- With a relatively small p-value, we **reject the null** at 0.05 significance level. We conclude that size and price are **correlated**.

![Scatterplot1](https://user-images.githubusercontent.com/96803412/148126168-25d903e2-b8c8-4481-a8f1-b6ee322c2772.PNG)


#### Faceting the above plot by year
```R
ggplot(housing, aes(size, price)) +
  geom_point(color = "blue") +
  facet_wrap(.~year) +
  labs(title = "Relationship between size of house and price, by year",
       x = "\nsize (sq. ft)", 
       y = "price ($)\n")
```

![Scatterplot3](https://user-images.githubusercontent.com/96803412/148127175-41f43e1c-c783-4750-8e28-346ce0e690e6.PNG)
- Positive correlation between size (x) and price (y) is present among the four years.

#### We will use simple linear regression for modeling the relationship between these two continuous variables (size and price).


### Defining the linear regression model
```R
housing.linmod <- lm(price~size, data = housing)
```
#### Regression equation associated with the model:
![eq](https://user-images.githubusercontent.com/96803412/148127943-27eb36c5-68fa-43cd-b80d-41437c973a19.png)
- Slope interpretation: For every 1 square foot increase in size, the house price increases by $223.20

### Plotting regression line with ```geom_smooth```
```R
ggplot(housing, aes(size, price)) +
  geom_point(color = "blue") +
  labs(x = "\nsize (sq. ft)",
       y = "price ($)\n",
       title = "Relationship between size of house and price") +
  geom_smooth(method = "lm", se = F, col = "black") +
  theme_gray() 
```
![RegLine](https://user-images.githubusercontent.com/96803412/148138589-b675f726-11d2-493b-ac7c-5c9e2e537781.png)

### Viewing the results of the regression model
```R
summary(housing.linmod)
```
#### Output
![LinRegOutput](https://user-images.githubusercontent.com/96803412/148132705-7ba0d4b9-98d0-4cec-8c75-a3151db8537b.PNG)


### Highlights of the model output
**1.** &nbsp; ![Highlight1](https://user-images.githubusercontent.com/96803412/148133534-f289bedb-9f06-4830-9e70-fd47986505dd.png)
  - 74.47% of the variation in house prices is explained by size (in sq. ft)
 
**2.** &nbsp; ![Highlight2](https://user-images.githubusercontent.com/96803412/148135045-23b3d0c6-9cd6-4500-be25-20c712aa58e7.PNG)
   - For simple linear regression, we have the following hypotheses: 
     
      ![image](https://user-images.githubusercontent.com/96803412/148135107-d17d660b-4f1e-4bea-953a-234b04c6b562.png)
   - Since the p-value is very small, we reject the null at 0.05 significance level. We conclude that the slope coefficient is nonzero, which means that size is a **statistically significant predictor** for the regression model. *Changes in size are associated with changes in price.* 

### Model validation
```R
plot(housing.linmod$residuals, col = "blue", 
     pch = 16, ylab = "Residuals", main = "Residual Plot") 
```
![ResidPlot](https://user-images.githubusercontent.com/96803412/148136817-d94bae9c-e252-4368-8509-87c8f502901d.png)
- The residuals are randomly scattered. There are no evident non-random patterns.
- Based on that, **the model fits the data well**.
