# Task 1

# part (a)

# Read in the data

# Note the sports data file column name %BFat was changed to BFat as it would not 
# read it correctly otherwise

Athletes<- read.csv(header = TRUE, file = "Sports Data CW 2019.csv")
attach(Athletes)

# check data has been read in correctly
View(Athletes)

summary(Athletes)
summary(Athletes$Sport)


# Standard deviation needs to be found separately for each variable
sd(Ferr)
sd(LBM) 
sd(RCC)
sd(WCC)  
sd(Hc) 
sd(Hg) 
sd(BMI) 
sd(SSF) 
sd(Bfat)

# Visual investigation of variables

par(mar = c(6, 6, 2.1, 2.1),mfrow = c(1,2),lwd = 2, pch = 19
, cex = 0.7, cex.lab = 2, cex.axis = 1.5,mgp = c(3,1,0))


plot(BMI,Ferr,xlab = 'Body Mass Index (kg/m^2)', ylab = 'Ferritin (µmol/L)')
plot(Hg,Ferr,xlab = 'Hemoglobin (g/dl)', ylab = 'Ferritin (µmol/L)')



boxplot(Ferr~Sport, axes = FALSE, ylab = 'Ferritin (µmol/L)',xlab='Sport Type')
axis(1, at = c(1,2,3,4,5,6,7,8,9,10) ,labels=c('BBall', 'Field',' Gym', 'Netball','Row','Swim',
'T400m','Tennis','TSprnt',' WPolo '))
axis(2)
title(main='Box Plot Of Ferrtitn Against Type Of Sport')
box()

# part (b)

# Histogram of logged Ferritn

par(mar = c(6, 6, 2.1, 2.1),lwd = 2, pch = 19
, cex = 0.7, cex.lab = 2, cex.axis =1.5,mgp = c(3,1,0),cex.main=2)

hist(log(Ferr),xlab = 'log(Ferritin (µmol/L))',main = 'Histogram of log(Ferr)', freq = FALSE,
ylim=c(0,1))
lines(density(log(Ferr)), col = 2)
lines(seq(-6,8,length = 100),dnorm(seq(-6,8,length = 100),
mean(log(Ferr[Ferr>0])),sd(log(Ferr[Ferr>0]))), col = 4)
legend("topright", legend = c('Observed density','Normal density')
, col= c(2,4),lty = 1,cex = 2)

qqnorm(Ferr,main='Normal Q-Q Plot for Ferr')

# Task 2

# set seed to always produce same random data 
set.seed(1234)

n1<- sample(1:nrow(Athletes), 141,replace=FALSE)
# randomly divide the dataset into samples of size n1 = 141
training <- Athletes [n1,]
# and n2 = 61
testing<- Athletes [-n1,]

#check data is the same when running multiple times
View(training)
View(testing)

# (b)

# Fit the regression equation in part(a) 

InitialTraining.model<- lm(Ferr~Sex+Sport+LBM+RCC+WCC+Hc+Hg+BMI+SSF+Bfat,
data=training)
summary(InitialTraining.model)

# We see that only Sex and one Sport type is significant ,
# we can tidy this up by looking at insignificant sports and
# grouping them together. 

# Test to see which sport types are insignificant

example<-lm(Ferr~Sport,data=training)
summary(example)

# Merge insignificant sport types together

training$Sport2<- as.character(training$Sport)

training$Sport2[training$Sport2=="Gym"|training$Sport2=="Netball"
|training$Sport2=="Tennis"
|training$Sport2=="Row"
|training$Sport2=="T400m"
|training$Sport2=="BBall"] <- "Others"


training$Sport2<-factor(training$Sport2)


# Refit the model to give 3 significant variables

Training.model<- lm(Ferr~Sex+training$Sport2+LBM+RCC+WCC+Hc+Hg+BMI+SSF+Bfat,
data=training)
summary(Training.model)

# Remove insignificant variables from model

BetterTraining.model<- lm(Ferr~Sex+LBM+BMI,data=training)
summary(BetterTraining.model)


# F-test for joint significance 

anova(BetterTraining.model,Training.model)

# AIC/BIC tests 

AIC(Training.model)
AIC(BetterTraining.model)

BIC(Training.model)
BIC(BetterTraining.model)


# (c) 
# i and ii

# Plots of residuals to examine

par(mar = c(6, 6, 2.1, 2.1),mfrow = c(1,2),lwd = 2, pch = 19
, cex = 0.7, cex.lab = 2, cex.axis = 1.5,mgp = c(3,1,0))




# Shapiro-Wilk normality test

shapiro.test(residuals(BetterTraining.model))

# Transform the model 

TransformTraining.model<- lm(log(Ferr)~Sex+LBM+BMI,data=training)
summary(TransformTraining.model)

shapiro.test(residuals(TransformTraining.model))


par(mar = c(6, 6, 2.1, 2.1),mfrow = c(1,1),lwd = 2, pch = 19
, cex = 0.7, cex.lab = 2, cex.axis = 1.5,mgp = c(3,1,0))

plot(TransformTraining.model)



#Task 3

# log the Ferr values in the testing dataset to compare against prediction

testing$"ln(Ferr)"<-log(testing$Ferr)


View(testing)

# predict Ferr values

p<-predict(TransformTraining.model, newdata = testing, interval = "prediction")

# Finding the Root Mean Square Error (RMSE)

error<- p - testing[["ln(Ferr)"]]

sqrt(mean(error^2))


# Part 2

# (b)

x<- seq(0, 25, by = .1)

prior<- dnorm(x, mean = 12, sd = 3)
likelihood<-dnorm(x,mean = 13.25,sd = 2)
posterior<- dnorm(x, mean = 12.865, sd = 1.664)


plot(x,posterior,type="l",main="Probability Density Curves",xlab="µ",
ylab="f (x)", col="green")
lines(x,likelihood,type="l", col="red")
lines(x,prior,type="l", col="blue")

legend("topright",legend=c("Prior", "Likelihood","Posterior"),
       col=c("blue", "red","green"),lty=1,text.font=2, cex=0.8)

# (d)

newposterior<- dnorm(x, mean = 11.853, sd = 0.442)
newlikelihood<-dnorm(x,mean = 13.25,sd = 0.447)


plot(x,newposterior,type="l",main="Updated Probability Density Curves",xlab="µ",
ylab="f (x)", col="green")
lines(x,newlikelihood,type="l", col="red")
lines(x,prior,type="l", col="blue")

legend("topright",legend=c("Prior", "Likelihood","Posterior"),
       col=c("blue", "red","green"),lty=1,text.font=2, cex=0.8)


