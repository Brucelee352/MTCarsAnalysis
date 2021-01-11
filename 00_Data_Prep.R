mtcars <- mtcars

# Get Data ---- 
#View(mtcars)

# Transform ----
# data.frame(mtcars) # already is a dataframe. 

# Make the Row Names into a new column called "Model"
mtcars$Model <- row.names(mtcars)

# Make a binary column of MPG: High > 20, Low <= 20 
mtcars$mpgb <- mtcars$mpg > 20

# Save to Data folder ---- 
# Write a CSV into your data folder named "custom_cars.csv"
write.csv(mtcars, file = "Data/custom_cars.csv", row.names = FALSE)

