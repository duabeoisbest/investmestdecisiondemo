from fastapi import FastAPI, HTTPException
import requests
from analyzer import analyze_stock_data

app = FastAPI(title="Stock Analyzer Hybrid API")

ALPHA_VANTAGE_KEY = "YOUR_ALPHA_VANTAGE_KEY" 
BASE_URL = "https://www.alphavantage.co/query"

@app.get("/api/stock/{symbol}")
def get_stock_analysis(symbol: str):
    
    params = {
        "function": "TIME_SERIES_DAILY",
        "symbol": symbol,
        "apikey": ALPHA_VANTAGE_KEY
    }
    
    response = requests.get(BASE_URL, params=params)
    data = response.json()
    
    if "Time Series (Daily)" not in data:
        raise HTTPException(status_code=400, detail="Kursdaten nicht gefunden oder Error in API Key.")
        
    
    time_series = data["Time Series (Daily)"]
    raw_list = []
    for date, metrics in sorted(time_series.items()):
        raw_list.append({
            "date": date,
            "close": float(metrics["4. close"])
        })
    
    
    recent_data = raw_list[-30:]
    
    
    analysis_result = analyze_stock_data(recent_data)
    
    
    return {
        "symbol": symbol.upper(),
        "history": recent_data,
        "analysis": analysis_result
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(main:app, host="0.0.0.0", port=8000, reload=True)