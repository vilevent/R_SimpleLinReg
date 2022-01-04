
# Simple Linear Regression in R 

library(tidyverse)
library(psych)
library(ggpubr)

# Load the housing data as a tibble
housing <- read_csv("real_estate_price_size_year_view.csv")
housing
View(housing)


# Converting year to integer type
housing$year <- housing$year %>% as.integer
housing


# Remove duplicate rows in the data, if there are any
distinct(housing)


# Obtain descriptive statistics for the numeric data
describe(housing[1:2])
summary(housing[1:2])


# Explore the data to discover interesting trends 

  # H0: size and price are independent.
  # alpha = 0.05
  cor.test(housing$size, housing$price, method = "kendall")

    # Correlation coefficient: 0.6115972
    # As size increases, price increases. 
    # Positive relationship between size and price.
    # p-value < 2.2e-16 < 0.05, Reject H0. size and price are correlated.

options(scipen = 4)

# ggplot2 package
ggplot(housing, aes(size, price)) +
  geom_point(color = "blue") +
  labs(x = "\nsize (sq. ft)", y = "price ($)\n",
       title = "Relationship between size of house and price")


# Housing price data for only 4 years
sort(unique(housing$year))

# Factors are used to represent data with fixed number of values.

# as_factor from the forcats package
ggplot(housing, aes(size, price)) +
  geom_point(aes(color = as_factor(year))) +
  labs(x = "\nsize (sq. ft)", y = "price ($)\n", 
       title = "Relationship between size of house and price",
       color = "year")

# Facet the plot by year
ggplot(housing, aes(size, price)) +
  geom_point(color = "blue") +
  facet_wrap(.~year) +
  labs(title = "Relationship between size of house and price, by year",
       x = "\nsize (sq. ft)", 
       y = "price ($)\n")


# Create the linear regression model
housing.linmod <- lm(price~size, data = housing)
housing.linmod


# Plot the regression line
ggplot(housing, aes(size, price)) +
  geom_point(color = "blue") +
  labs(x = "\nsize (sq. ft)",
       y = "price ($)\n",
       title = "Relationship between size of house and price") +
  geom_smooth(method = "lm", se = F, col = "black") +
  theme_gray() 


# Print the results of the regression model
summary(housing.linmod)


# How many observations (n) was the regression run on?

  # n = 100
    # Simple linear regression: df = n - 2
    # 98 degrees of freedom (df)


# What is the R-squared of this regression? What does it tell you?
  # Multiple R-squared:  0.7447
  # 74.47% of the variation in house prices is explained by size (in sq. ft)

# Look at the residuals (they are randomly scattered, which is good)
plot(housing.linmod$residuals, col = "blue", 
     pch = 16, ylab = "Residuals", main = "Residual Plot") 

  # Conclusion: the model fits the data well.


# Determine if size is a statistically significant predictor of price.

  # H0: The slope coefficient equals 0.
  # alpha = 0.05

  # p-value = Pr(>|t|) < 2e-16 < 0.05, Reject H0. There is enough evidence 
  # to conclude that the coefficient for size differs from 0. So, size is 
  # a meaningful predictor for the regression model.


# What is the regression equation associated with this regression model?

  housing.linmod
  # price_hat = 101912.6 + 223.2*(size)
