import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: const Center(
        child: Text('This is setting page'),
      ),
    );
  }
}
