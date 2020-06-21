####Learning R-language from dataprofessor Utube####
library(datasets)
data(iris)
view(iris)

###Retrieve data from http or ftp####
##using library Rcurl
install.packages("RCurl")
library(RCurl)##loading the tool
iris <- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/iris.csv"))
iris$Sepal.Length

#to visualize head and tail in data
head(iris,5)
tail(iris,5)

#to see the simple statistic information
summary(iris)
#to see whether there is any missing data
sum(is.na(iris))#na meaning missing value in data set

#provide more parameter on statistic with a nice platform in console (command execute window)
install.packages("skimr")
library("skimr")
skim(iris)

iris %>%
  dplyr::group_by(Species) %>%
  skim()

#data visualization
#to see the panel plot
plot(iris)
plot(iris, col ='red')##col is color

#scatter plot
plot(iris$Sepal.Width, iris$Sepal.Length) #plot scatter with x,y axis
plot(iris$Sepal.Width, iris$Sepal.Length, col = 'red')

plot(iris$Sepal.Width, iris$Sepal.Length, col = 'green',
xlab = "sepal width", ylab = "sepal length") ##xlab,ylab --> labeling x and y axis

#histogram
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, col = "blue")

#Feature plots
install.packages("caret")
library("caret")
install.packages("lattice")
install.packages("ggplot2")
library("lattice")
library('ggplot2')
featurePlot(x = iris[, 1:4],
            y = iris$Species,
            plot = "box",
            strip=strip.custom(par.strip.text=list(cex=.7)),##labeling box plot
            scales = list(x = list(relation="free"),
                          y = list(relation="free")))

featurePlot(x = iris[, 1:4], 
            y = iris$Species, 
            plot = "pairs",
            ## Add a key at the top
            auto.key = list(columns = 3))

library("readxl")
infographic <- read.csv(text = getURL("https://raw.githubusercontent.com/tlerksuthirat/sample-dataset/master/json_infographics_csv"),
                     header = TRUE)
View(infographic)
getwd() ##know wing the current working directory
setwd("drive:/location") ##file will be exported to working directory
export(infographic, "infographic.xlsx")
