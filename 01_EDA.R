# Exploratory Data Analysis for MT Cars in base R 


# Load Data ---- 
 # Read Data/custom_cars.csv 

custom_mtcars <- read.csv(file = 
      "Data/custom_cars.csv")


# It's always helps to view the data and its structure to observe the data 
# itself and its classes

View(custom_mtcars)
str(custom_mtcars)

# Check the column classes

lapply(custom_mtcars, class)

# Re-code variables into factors, it helps with making charts with 
# certain libraries (*cough* ggplot2 *cough*) 

custom_mtcars$cyl <- factor(custom_mtcars$cyl,
                            levels = c(4, 6, 8)) 
custom_mtcars$vs <- factor(custom_mtcars$vs, levels = c(0, 1)) 
custom_mtcars$am <- factor(custom_mtcars$am, levels = c(0, 1))

custom_mtcars$gear <- factor(custom_mtcars$gear, levels = 3:5)
custom_mtcars$carb <- factor(custom_mtcars$carb, levels = 1:8)

# I have to make NUMERIC version of mtcars for use with a correlation matrix 

numeric_custom_mt <- custom_mtcars
numeric_custom_mt[] <- lapply(custom_mtcars, as.numeric)

mt_corr <- cor(numeric_custom_mt)
plot(mt_corr)

# Predict MPG ----

# Create a linear model that predicts what MPG is 

lm(mpg ~ . , data = custom_mtcars)
cars_model <- lm(custom_mtcars$mpg ~ custom_mtcars$cyl + 
                    custom_mtcars$vs + 
     custom_mtcars$am + custom_mtcars$gear + custom_mtcars$carb, 
   data = custom_mtcars)

summary(cars_model)

##Heatmap can be used with this data as well for correlation 

# Create a logistic regression model that predicts if MPG is high or low.. 

mpg_binarymodel <- glm(custom_mtcars$mpgb ~ custom_mtcars$hp + 
                         custom_mtcars$disp + custom_mtcars$cyl, 
                       family = binomial(link = "logit"), data = custom_mtcars)

# Assign data frame for MPG to make it a predictor variable for the model 

milespergallon <- data.frame(MPG = numeric_custom_mt$mpg)
predicted <- plogis(predict(model, milespergallon)) 

summary(model)
summary(predicted)

# Make plots of linear model, can be used with ggplot2 for further 
# customization of plots — but using base R for now as the script example. 
plot(mpg_binarymodel)
plot(cars_model) 
plot(predicted)



