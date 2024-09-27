import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

Future<bool> fetchSignIn(TextEditingController emailController,
    TextEditingController passwordController, BuildContext context) async {
  final url = Uri.parse('http://localhost:8080/login');
  try {
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
