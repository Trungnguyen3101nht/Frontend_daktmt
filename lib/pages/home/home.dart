import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('This is home page'),
      ),
    );
  }
}
