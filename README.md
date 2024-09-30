# Sentimental-Analysis
Financial Sentiment Analysis: News Articles' Influence on Apple Stock Trends.

# Introduction
The financial markets are heavily influenced by various factors, among which news sentiment plays a crucial role. This project focuses on examining the relationship between news sentiment surrounding Apple Inc. and its stock prices from January 2017 to December 2021. By leveraging sentiment analysis techniques on simulated news headlines, the objective is to understand how positive or negative sentiments correlate with stock price movements. Given Apple's significant presence in the technology sector and its frequent media coverage, this analysis seeks to provide insights that could benefit investors, analysts, and policymakers.

# Objective
The primary objectives of this project are:

1.] To analyze the sentiment of news headlines related to Apple Inc. over the specified period.
2.] To investigate the relationship between news sentiment and the adjusted stock prices of Apple Inc.
3.] To develop predictive models using linear regression and time series forecasting methods to understand and predict stock price movements based on sentiment and trading volume.
4.] To explore potential future trends in Apple’s stock price based on sentiment and volume analysis.

# Methodology
The methodology involves several steps:

1.] Data Collection:
Stock price data for Apple Inc. was obtained from Yahoo Finance using the quantmod package in R.
Simulated news headlines relevant to Apple were created to represent various sentiment scenarios for each trading day during the study period.

2.] Sentiment Analysis:
Sentiment scores were calculated for the news headlines using the sentimentr package. This included preprocessing the headlines and applying sentiment analysis techniques.

3.] Data Merging:
The stock price data and sentiment scores were merged into a single dataset based on the date, ensuring that each entry contained relevant stock price and sentiment information.

4.] Exploratory Data Analysis (EDA):
A correlation matrix was computed to explore relationships between stock prices, sentiment, and trading volume.
Visualization techniques were applied to understand the trends and patterns in the data.

5.] Modeling:
A linear regression model was developed to examine the effect of sentiment and trading volume on the stock price.
Time series models, including ARIMA and Prophet, were employed to forecast future stock price movements based on historical data.

6.] Binary Classification:
A binary classification approach was taken to classify stock price movements (increase or decrease) based on sentiment and trading volume.
Analysis and Interpretation

The analysis revealed the following insights:

1.] Sentiment Scores: The sentiment analysis provided varying sentiment scores, reflecting the market's perception of Apple Inc. based on news headlines.
2.] Regression Results: The linear regression model indicated that while trading volume significantly affects stock prices, sentiment did not show a statistically significant relationship in this context. The multiple R-squared value was relatively low, suggesting that other factors may influence stock prices.
3.] Time Series Forecasting: The ARIMA and Prophet models produced forecasts indicating potential future price movements, which can be further refined with more comprehensive sentiment data and real-world events.
4.] The correlation matrix indicated a weak positive correlation between sentiment and adjusted stock prices, while a stronger negative correlation was observed between trading volume and price.

# Conclusion
This project highlights the complexity of financial markets and the interplay between news sentiment and stock prices. Although the sentiment analysis provided interesting insights, the impact of sentiment on Apple’s stock prices was not as pronounced as expected. Future research could benefit from integrating actual news data, enhancing sentiment analysis techniques, and considering external economic factors that may influence stock prices.


# Future Scope
Future research avenues may include:

1.] Real-time Data Integration: Utilizing real-time news data instead of simulated headlines to obtain more accurate sentiment analysis.
2.] Advanced Machine Learning Techniques: Applying machine learning algorithms such as Random Forest or XGBoost for better predictive modeling of stock prices.
3.] Incorporating Additional Variables: Including macroeconomic indicators and social media sentiment analysis to understand broader market dynamics.
4.] Longitudinal Studies: Conducting longitudinal studies across different time frames and comparing results with other technology companies to derive more generalized insights.
