library(farff)

setwd("C:/Users/lanxin/Desktop/2018Spring/S&DS563/Chronic_Kidney_Disease")
CKD<-readARFF("chronic_kidney_disease.arff")

CKD2 <- as.numeric(CKD[complete.cases(CKD[,c(1:2,10:18)]),c(1:2,10:18)])

#1).  First, discuss whether your data seems to have a multivariate normal
#distribution.  Make univariate plots (boxplots, normal quantile plots as appropriate).  
#Then make transformations as appropriate.  
#You do NOT need to turn all this in, but describe what you did.  
#THEN  make a chi-square quantile plot of the data.  
#Turn in your chi-square quantile plot as appropriate and comment on what you see.
#NOTE that multivariate normality is NOT a requirement for PCA to work!
 
#get online function
source("http://www.reuningscherer.net/STAT660/R/CSQPlot.r.txt")
#run the function
CSQPlot(CKD2,label="Chronic Kidney Disease")
CSQPlot(log(CKD2),label="Chronic Kidney Disease")
##no multinormality

#2).  Compute the correlation matrix between all variables 
#Comment on relationships you do/do not observe.  
#Do you think PCA will work well?
#make correlation matrix to see if PCA will work well
round(cor(CKD2),2)
#make matrix plot to check for linearity
library('corrplot') # visualisation
library('dplyr') # data manipulation
CKD2 %>%
  cor(use="complete.obs", method = "spearman") %>%
  corrplot(type="lower", tl.col = "black",  diag=FALSE,method = "number")
#3).  Perform Principle components analysis using the Correlation matrix (standardized variables).  
#Think about how many principle components to retain.  To make this decision look at
#.	Total variance explained by a given number of principle components
#.	The 'eigenvalue > 1' criteria
#.	The 'scree plot elbow' method  (turn in the scree plot)
#.	Parallel Analysis : think about whether this is appropriate based on what you discover in number 1.

pc1=princomp(CKD2[,-1], cor=TRUE)

#print results
print(summary(pc1),digits=2,loadings=pc1$loadings,cutoff=0)
#view eigenvalues (note that R gives square-root of eigenvalues
#which is why I square them)
pc1$sdev^2
#Comp1 and Comp2 larger than 1

#view eigenvectors
pc1$loadings

#make a screeplot  
screeplot(pc1,type="lines",col="red",lwd=2,pch=19,cex=1.2,main="Scree Plot")

#perform parallel analysis
#get the function online
source("http://www.reuningscherer.net/STAT660/R/parallel.r.txt")
#make the parallel analysis plot
parallelplot(pc1)
#this plot is not appropriate here because unnormality

#4).  For principle components you decide to retain, examine the loadings (principle components) 
#and think about an interpretation for each retained component if possible.

#5)  Make a score plot of the scores for at least two pairs of component scores 
#(one and two, one and three, two and three, etc).  Discuss any trends/groupings you observe.  
#As a bonus, try to make a 95% Confidence Ellipse for two of your components. 
#You might want to also try making a bi-plot if you're using R.

#make scoreplot with confidence ellipse : 
#  c(1,2) specifies to use components 1 and 2
#get function from online
source("http://reuningscherer.net/stat660/r/ciscoreplot.R.txt")

#run the function
ciscoreplot(pc1,c(1,2),CKD2[,1])


#make a biplot for first two components
biplot(pc1,choices=c(1,2),pc.biplot=T)

#6).  Write a paragraph summarizing your findings, 
#and your opinions about the effectiveness of using principle components on this data.  
#Include evidence based on scatterplots of linearity in higher dimensional space, 
#note any multivariate outliers in your score plot, comment on sample size relative to number of variables, etc.





#################################
#SECOND, use transformed data





