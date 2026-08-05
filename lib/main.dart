import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/stock_model.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const StockAnalyzerApp());
}

class StockAnalyzerApp extends StatelessWidget {
  const StockAnalyzerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Giao diện tối chuyên nghiệp cho app tài chính
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController(text: "AAPL");
  final ApiService _apiService = ApiService();
  StockData? _stockData;
  bool _isLoading = false;

  void _searchStock() async {
    setState(() { _isLoading = true; });
    try {
      final data = await _apiService.fetchStockAnalysis(_controller.text.trim());
      setState(() { _stockData = data; });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: ${e.toString()}")),
      );
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Stock Analyzer AI (LSTM & ARIMA)")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Thanh tìm kiếm mã cổ phiếu
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Mã cổ phiếu (Ví dụ: AAPL, TSLA)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _searchStock,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
                  child: const Icon(Icons.search),
                )
              ],
            ),
            const SizedBox(height: 20),
            
            // Trạng thái Loading / Hiển thị dữ liệu
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            
            if (!_isLoading && _stockData != null) ...[
              // Thẻ hiển thị giá hiện tại và dự đoán từ ML
              Card(
                color: Colors.grey[900],
                child: ListTile(
                  title: Text("Cổ phiếu: ${_stockData!.symbol}", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  subtitle: Text("Giá hiện tại: \$${_stockData!.currentPrice.toStringAsFixed(2)}"),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dự đoán: ${_stockData!.trend}",
                        style: TextStyle(
                          color: _stockData!.trend == "UP" ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                      Text("AI: \$${_stockData!.finalPrediction.toStringAsFixed(2)}")
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Biểu đồ xu hướng (30 ngày gần nhất)", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              
              // Khối vẽ biểu đồ trực quan (Trendvisualisierungen)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 10),
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: true),
                      titlesData: const FlTitlesData(show: false), // Ẩn bớt text để tinh gọn
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _stockData!.history.asMap().entries.map((e) {
                            return FlSpot(e.key.toDouble(), e.value['close']);
                          }).toList(),
                          isCurved: true,
                          barWidth: 3,
                          color: Colors.blue,
                        )
                      ]
                    )
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
