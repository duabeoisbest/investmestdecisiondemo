import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_model.dart';

class ApiService {
  // Nếu test trên máy ảo Android, hãy đổi 'localhost' thành '10.0.2.2'
  final String baseUrl = "http://localhost:8000/api/stock";

  Future<StockData> fetchStockAnalysis(String symbol) async {
    final response = await http.get(Uri.parse('$baseUrl/$symbol'));

    if (response.statusCode == 200) {
      return StockData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Lỗi khi tải phân tích cổ phiếu");
    }
  }
}
