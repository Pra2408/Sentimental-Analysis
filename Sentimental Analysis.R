# Install required packages
install.packages(c("quantmod", "tidytext", "dplyr", "ggplot2", "randomForest", 
                   "forecast", "prophet", "caret", "tidyr", "corrplot", "sentimentr"))

# Load libraries
library(quantmod)
library(tidytext)
library(dplyr)
library(ggplot2)
library(randomForest)
library(forecast)
library(prophet)
library(caret)
library(tidyr)
library(corrplot)
library(sentimentr)

# Download stock data using quantmod (Example: Apple stock)
getSymbols("AAPL", src = "yahoo", from = "2017-01-01", to = "2021-12-31")
stock_data <- data.frame(Date = index(AAPL), coredata(AAPL))

# Preview stock data
head(stock_data)

# Create a sample dataset with dates and news headlines
set.seed(123)  # For reproducibility
n <- nrow(stock_data)  # Number of days in stock data

# Generate simulated news headlines for each day
news_headlines <- data.frame(
  Date = stock_data$Date,
  Headlines = sample(c(
    "Apple shares rise after new iPhone launch",
    "Apple faces lawsuit for slowing down phones",
    "Apple announces record revenue in Q1",
    "Market expects growth as Apple expands into new markets",
    "Apple stock plummets due to pandemic fears",
    "Analysts predict a bright future for Apple",
    "Apple's innovative products drive customer satisfaction",
    "Supply chain issues impact Apple sales",
    "Apple's sustainability efforts receive praise",
    "New software update leads to mixed reactions"
  ), n, replace = TRUE)
)

# Perform sentiment analysis using sentimentr
news_headlines$Sentiment <- sentiment_by(news_headlines$Headlines)$ave_sentiment

# Preview the news headlines dataset
head(news_headlines)

# Merge stock data with sentiment scores by date
merged_data <- merge(stock_data, news_headlines, by = "Date", all.x = TRUE)
merged_data <- merged_data %>% fill(Sentiment, .direction = "down")

# Inspect the merged dataset
head(merged_data)

# Correlation Matrix for EDA
cor_matrix <- cor(merged_data[, c("AAPL.Adjusted", "Sentiment", "AAPL.Volume")], use = "complete.obs")
corrplot(cor_matrix, method = "circle")

# Plot stock prices and sentiment over time
ggplot(merged_data, aes(x = Date)) +
  geom_line(aes(y = AAPL.Adjusted, color = "Stock Price")) +
  geom_line(aes(y = Sentiment * 100, color = "Sentiment (scaled)")) +
  labs(title = "Stock Prices and Sentiment Over Time", y = "Value") +
  scale_color_manual("", breaks = c("Stock Price", "Sentiment (scaled)"), 
                     values = c("Stock Price" = "blue", "Sentiment (scaled)" = "red"))
# Build regression model: Stock Price ~ Sentiment + Volume
model <- lm(AAPL.Adjusted ~ Sentiment + AAPL.Volume, data = merged_data)

# Model summary
summary(model)

# Residual diagnostics
par(mfrow = c(2, 2))
plot(model)

# Variance Inflation Factor (VIF) to check multicollinearity
library(car)
vif(model)

# Convert stock prices to time series format
stock_ts <- ts(merged_data$AAPL.Adjusted, frequency = 252)  # 252 trading days in a year

# Fit ARIMA model
arima_model <- auto.arima(stock_ts)

# Forecast for the next 100 days
arima_forecast <- forecast(arima_model, h = 100)

# Plot the forecast
plot(arima_forecast)

# Prepare data for Prophet model
prophet_data <- merged_data %>% select(Date, AAPL.Adjusted) %>%
  rename(ds = Date, y = AAPL.Adjusted)

# Fit Prophet model
prophet_model <- prophet(prophet_data)

# Make future predictions (next 100 days)
future <- make_future_dataframe(prophet_model, periods = 100)
prophet_forecast <- predict(prophet_model, future)

# Plot Prophet forecast
plot(prophet_model, prophet_forecast)

# Prepare data for Prophet model
prophet_data <- merged_data %>% select(Date, AAPL.Adjusted) %>%
  rename(ds = Date, y = AAPL.Adjusted)

# Fit Prophet model
prophet_model <- prophet(prophet_data)

# Make future predictions (next 100 days)
future <- make_future_dataframe(prophet_model, periods = 100)
prophet_forecast <- predict(prophet_model, future)

# Plot Prophet forecast
plot(prophet_model, prophet_forecast)

# Convert stock price movement to binary classification (1 for increase, 0 for decrease)
merged_data$PriceDirection <- c(NA, ifelse(diff(merged_data$AAPL.Adjusted) > 0, 1, 0))

# Remove the first row with NA in PriceDirection
merged_data <- merged_data[-1, ]

# Inspect the merged dataset to confirm changes
head(merged_data)

# Prepare the data for modeling
model_data <- merged_data %>%
  select(Sentiment, PriceDirection) %>%
  na.omit()  # Remove rows with NA values

# Load necessary libraries
library(randomForest)

# Assuming that we  have already trained your Random Forest model and made predictions
# Here is an example of how you would calculate the confusion matrix manually:

# Example: Actual and predicted values (replace these with your actual variables)
rf_predictions <- factor(rf_predictions, levels = c("0", "1"))  # Predicted values
actual_values <- factor(test_data$PriceDirection, levels = c("0", "1"))  # Actual values

# Create the confusion matrix
conf_matrix <- table(Predicted = rf_predictions, Actual = actual_values)

# Print the confusion matrix
print("Confusion Matrix:")
print(conf_matrix)

# Calculate performance metrics
TP <- conf_matrix["1", "1"]  # True Positives
TN <- conf_matrix["0", "0"]  # True Negatives
FP <- conf_matrix["1", "0"]  # False Positives
FN <- conf_matrix["0", "1"]  # False Negatives

# Calculate accuracy
accuracy <- (TP + TN) / sum(conf_matrix)

# Calculate precision
precision <- TP / (TP + FP)

# Calculate recall (sensitivity)
recall <- TP / (TP + FN)

# Calculate F1 Score
f1_score <- 2 * (precision * recall) / (precision + recall)

# Print metrics
cat("Confusion Matrix:\n")
print(conf_matrix)
cat("\nPerformance Metrics:\n")
cat("Accuracy:", accuracy, "\n")
cat("Precision:", precision, "\n")
cat("Recall:", recall, "\n")
cat("F1 Score:", f1_score, "\n")
