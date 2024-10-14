import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// Hàm lấy độ ẩm
Future<double?> fetchHumidity(String token, BuildContext context) async {
  final url = Uri.parse('http://10.28.128.67:8080/sensor/humi');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final humidity = result['data'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Độ ẩm: $humidity")),
      );
      return humidity; // Trả về giá trị độ ẩm
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi lấy độ ẩm: ${response.statusCode}")),
      );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Lỗi kết nối khi lấy độ ẩm")),
    );
    return null;
  }
}

// Hàm lấy nhiệt độ
Future<double?> fetchTemperature(String token, BuildContext context) async {
  final url = Uri.parse('http://10.28.128.67:8080/sensor/temp');

  try {
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      final temperature = result['data'];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Nhiệt độ: $temperature")),
      );
      return temperature; // Trả về giá trị nhiệt độ
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi khi lấy nhiệt độ: ${response.statusCode}")),
      );
      return null;
    }
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Lỗi kết nối khi lấy nhiệt độ")),
    );
    return null;
  }
}
