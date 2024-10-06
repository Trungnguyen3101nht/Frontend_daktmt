import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8080';
  final storage = const FlutterSecureStorage();

  // Lấy dữ liệu độ ẩm từ API
  Future<double?> getHumidity(String token) async {
    final url = Uri.parse('$baseUrl/sensor/humi');
    
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
        print("Độ ẩm: $humidity");
        return humidity.toDouble(); // Trả về giá trị độ ẩm
      } else {
        print("Lỗi khi lấy độ ẩm: ${response.statusCode}");
        return null; // Trả về null nếu có lỗi
      }
    } catch (error) {
      print("Lỗi kết nối khi lấy độ ẩm: $error");
      return null; // Trả về null nếu có lỗi kết nối
    }
  }

  // Lấy dữ liệu nhiệt độ từ API
  Future<double?> getTemperature(String token) async {
    final url = Uri.parse('$baseUrl/sensor/temp');

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
        print("Nhiệt độ: $temperature");
        return temperature.toDouble(); // Trả về giá trị nhiệt độ
      } else {
        print("Lỗi khi lấy nhiệt độ: ${response.statusCode}");
        return null; // Trả về null nếu có lỗi
      }
    } catch (error) {
      print("Lỗi kết nối khi lấy nhiệt độ: $error");
      return null; // Trả về null nếu có lỗi kết nối
    }
  }

  // Hàm này dùng để đăng nhập và lưu token nhận được
  Future<void> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['token'];  // Lấy token từ phản hồi của backend
      await storage.write(key: 'token', value: token);  // Lưu token vào bộ nhớ
      print("Đăng nhập thành công. Token đã được lưu.");
    } else {
      print("Lỗi đăng nhập: ${response.statusCode}");
    }
  }

  // Hàm lấy token từ bộ nhớ
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
