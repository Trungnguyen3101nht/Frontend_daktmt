import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final token = data['token']; // Lấy token từ phản hồi của backend
      await storage.write(key: 'token', value: token); // Lưu token vào bộ nhớ
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

Future<bool> fetchSignIn(TextEditingController emailController,
    TextEditingController passwordController, BuildContext context) async {
  final url = Uri.parse('http://localhost:8080/login');
  try {
    String convertEmail = emailController.text.toLowerCase();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'emailOrusername': convertEmail,
        'password': passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('accessToken', jsonData['accessToken']);
      await prefs.setString('refreshToken', jsonData['refreshToken']);
      Navigator.pushReplacementNamed(context, '/home');
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> fetchRegister(
    TextEditingController username,
    TextEditingController emailController,
    TextEditingController passwordController,
    TextEditingController aiouser,
    TextEditingController aiokey,
    TextEditingController phone,
    BuildContext context) async {
  final url = Uri.parse('http://localhost:8080/register');
  try {
    String convertUsername = username.text.toLowerCase();
    String convertEmail = emailController.text.toLowerCase();

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': convertUsername,
        'email': convertEmail,
        'password': passwordController.text,
        'aioUser': aiouser.text,
        'aioKey': aiokey.text,
        'phone': phone.text,
      }),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng kí tài khoản thành công')),
      );
      Navigator.pushReplacementNamed(context, '/signin');
      return true;
    } else {
      final errorMessage =
          json.decode(response.body)['message'] ?? 'Tài khoản này đã tồn tại';

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      return false;
    }
  } catch (e) {
    // Handle any exceptions
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Lỗi kết nối với server')));
    return false;
  }
}

Future<bool> fetchForgetPassword(TextEditingController emailController,
    TextEditingController passwordController, BuildContext context) async {
  final url = Uri.parse('http://localhost:8080/forgot-password');
  try {
    String convertEmail = emailController.text.toLowerCase();
    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'emailOrusername': convertEmail,
        'newPassword': passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đổi mật khẩu thành công')),
      );
      Navigator.pushReplacementNamed(context, '/signin');
      return true;
    } else {
      final errorMessage =
          json.decode(response.body)['message'] ?? 'Tài khoản không tồn tại';

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
      return false;
    }
  } catch (e) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Lỗi kết nối với server')));
    return false;
  }
}

Future<bool> fetchSendcode(String email) async {
  final url = Uri.parse('http://localhost:8080/email/send-code');
  try {
    String convertEmail = email.toLowerCase();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': convertEmail,
      }),
    );

    if (response.statusCode == 200) {
      print("Success");
      return true;
    } else {
      print("Failed to send verification code");
      return false;
    }
  } catch (error) {
    print("Error: $error");
    return false;
  }
}

Future<bool> fetchConfirmcode(String email, String code) async {
  final url = Uri.parse('http://localhost:8080/email/confirm-code');
  try {
    String convertEmail = email.toLowerCase();
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': convertEmail,
        'verificationCode': code,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    return false;
  }
}
