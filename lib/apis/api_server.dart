import 'dart:convert'; // Import for JSON encoding/decoding
import 'package:http/http.dart'
    as http; // Import HTTP package for making requests
import 'package:shared_preferences/shared_preferences.dart'; // Import for storing data
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<double> fetchHumidityData(String token) async {
  try {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final response = await http.get(
      Uri.parse('http://$baseUrl/sensor/get/humi'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(json.encode(result));

      double humidity = result['data']; // Lấy giá trị độ ẩm (double)

      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('humidity', humidity); // Lưu độ ẩm dưới dạng double

      return humidity; // Trả về giá trị độ ẩm dạng double
    } else {
      final result = json.decode(response.body);
      print('Error: ${result['error']}');
    }
  } catch (error) {
    print('Error fetching humidity data: $error');
  }
  return 0.0; // Trả về giá trị mặc định nếu có lỗi
}

Future<double> fetchTemperatureData(String token) async {
  try {
    final baseUrl = dotenv.env['API_BASE_URL']!;
    final response = await http.get(
      Uri.parse('http://$baseUrl/sensor/get/temp'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(json.encode(result));

      double temperature = result['data']; // Lấy giá trị nhiệt độ (double)

      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(
          'temperature', temperature); // Lưu nhiệt độ dưới dạng double

      return temperature; // Trả về giá trị nhiệt độ dạng double
    } else {
      final result = json.decode(response.body);
      print('Error: ${result['error']}');
    }
  } catch (error) {
    print('Error fetching temperature data: $error');
  }
  return 0.0; // Trả về giá trị mặc định nếu có lỗi
}
