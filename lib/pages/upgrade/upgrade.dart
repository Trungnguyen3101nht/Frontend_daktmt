import 'package:flutter/material.dart';

class UpgradePage extends StatelessWidget {
  const UpgradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upgrade Account'),
      ),
      body: const Center(
        child: Text('Upgrade account page content here'),
      ),
    );
  }
}
