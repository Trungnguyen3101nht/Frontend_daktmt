import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> fetchSignIn(TextEditingController emailController,
    TextEditingController passwordController, BuildContext context) async {
  final url = Uri.parse('http://localhost:8080/login');
  try {
    // Gửi yêu cầu POST
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'emailOrusername': emailController.text,
        'password': passwordController.text,
      }),
    );

    // Nếu phản hồi OK (status code 200)
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      print(jsonData);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('Lỗi ${response.statusCode}');
    }
  } catch (e) {
    print('Failed to load data: $e');
  }
}
