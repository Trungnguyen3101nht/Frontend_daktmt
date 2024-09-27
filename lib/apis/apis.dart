import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

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
      Navigator.pushReplacementNamed(context, '/login');
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

Future<bool> fetchSendcode(String email) async {
  final url = Uri.parse('http://localhost:8080/email/send-code');
  try {
    String convertEmail = email.toLowerCase(); // Chuyển email về chữ thường
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
