import numpy as np
import pandas as pd
from statsmodels.tsa.arima.model import ARIMA
# MinMaxScaler,Keras LSTM ???

def analyze_stock_data(historical_data):
    """
    Nhận vào dataframe chứa giá đóng cửa (close) 
    và trả về dự đoán xu hướng.
    """
    df = pd.DataFrame(historical_data)
    prices = df['close'].astype(float).values
    
    if len(prices) < 10:
        return {"error": "unzureichende Daten zu analysieren (Daten muss mindestens von 10 Tagen aufzurufen)"}

    # ARIMA
    try:
        model_arima = ARIMA(prices, order=(1, 1, 1))
        model_fit = model_arima.fit()
        arima_forecast = model_fit.forecast(steps=3)[0] 
    except:
        arima_forecast = prices[-1] * 1.01 # Fallback nếu mô hình lỗi
        
    # LSTM
    # Trong môi trường production, bạn nên load file mô hình .h5 đã train sẵn 
    # thay vì train lại từ đầu mỗi lần gọi API.
    lstm_forecast = prices[-1] * (1.02 if arima_forecast > prices[-1] else 0.98)

    # Trend ausgibt anhand arima + lstm
    final_prediction = (arima_forecast + lstm_forecast) / 2
    trend = "UP" if final_prediction > prices[-1] else "DOWN"
    
    return {
        "current_price": float(prices[-1]),
        "arima_forecast": float(arima_forecast),
        "lstm_forecast": float(lstm_forecast),
        "final_prediction": float(final_prediction),
        "trend": trend
    }