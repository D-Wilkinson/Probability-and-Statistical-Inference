# Probability-and-Statistical-Inference

In this project I provide a detailed statistical analysis of plasma ferritin concentration in Australian athletes from a given dataset using R Studio. It includes regression models and Bayesian inference, with the key objectives being to identify correlations between plasma ferritin and other health indicators like BMI, hemoglobin, and lean body mass.  

## Links
- [Project Report](https://github.com/D-Wilkinson/Probability-and-Statistical-Inference/blob/71e2205fc90824593186ec28a12b0db0d733fb4d/PSI%20Report.pdf)
- [R Code](https://github.com/D-Wilkinson/Probability-and-Statistical-Inference/blob/00a17e91292ee01780633238202b7734c95e1e87/CourseWork%20Script.R)
- [Initial Dataset](https://github.com/D-Wilkinson/Probability-and-Statistical-Inference/blob/79df366eac0f31a1e3ee041cc58bc3b8127ad35c/Sports%20Data%20CW%202019.csv)

## Key Insights
- Data Analysis and Model Fitting: The report explores correlations through regression analysis, finding significant positive correlations between ferritin and BMI/hemoglobin levels. Outliers are identified and addressed to enhance model reliability.

- Regression Model Optimization: The initial model included many predictors but was refined to focus on the most impactful variables: Sex, BMI, and lean body mass; using statistical tests such as F-test and Akaike and Bayesian Information Criterion tests (AIC/BIC) to support that this model better explained ferritin variability and improved fit.
- Normality and Residual Analysis: The response variable was transformed to improve normality, which was confirmed through residual plots and the Shapiro-Wilk test. This step validated the model’s appropriateness for the data.
- Prediction Accuracy: The final model demonstrates good predictive power, with a low root mean square error, indicating suitability for use in future data predictions.
- Bayesian Inference: Bayesian methods provided a posterior distribution for ferritin levels, updating prior beliefs based on sample data. This approach offered a refined estimate of the ferritin mean, illustrating the power of Bayesian updating with more data.
## Skills demonstrated
- Statistical modelling

- Data transformation
- Predictive analytics
- Methodical approach to model optimization
- Strong analytical capabilities
- Attention to detail 
