import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/stock_model.dart';

class ApiService {
  // nếu test trên máy ảo Android, sử dụng '10.0.2.2' thay vì 'localhost'
  String get baseUrl {
    final host = kIsWeb
        ? 'localhost'
        : (Platform.isAndroid ? '10.0.2.2' : 'localhost');
    return 'http://$host:8000/api/stock';
  }

  Future<StockData> fetchStockAnalysis(String symbol) async {
    final response = await http.get(Uri.parse('$baseUrl/$symbol'));

    if (response.statusCode == 200) {
      return StockData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Lỗi khi tải phân tích cổ phiếu");
    }
  }
}
