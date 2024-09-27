import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),

      appBar: AppBar(
        title: const Text('History'),
      ),
      body: const Center(
        child: Text('This is history page'),
      ),
    );
  }
}
