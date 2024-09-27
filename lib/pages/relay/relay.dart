import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';

class RelayScreen extends StatelessWidget {
  const RelayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),

      appBar: AppBar(
        title: const Text('Relay'),
      ),
      body: const Center(
        child: Text('This is relay page'),
      ),
    );
  }
}
