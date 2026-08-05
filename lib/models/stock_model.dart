class StockData {
  final String symbol;
  final List<Map<String, dynamic>> history;
  final double currentPrice;
  final double finalPrediction;
  final String trend;

  StockData({
    required this.symbol,
    required this.history,
    required this.currentPrice,
    required this.finalPrediction,
    required this.trend,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockData(
      symbol: json['symbol'],
      history: List<Map<String, dynamic>>.from(json['history']),
      currentPrice: json['analysis']['current_price'],
      finalPrediction: json['analysis']['final_prediction'],
      trend: json['analysis']['trend'],
    );
  }
}
