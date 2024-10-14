import 'package:flutter/material.dart';

// ignore: camel_case_types
class navbarleft_set extends StatelessWidget {
  const navbarleft_set({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      left: 16,
      child: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    );
  }
}
// ignore: camel_case_types
class Navbar_left extends StatelessWidget {
  const Navbar_left({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding( // Thêm Padding vào đây
        padding: const EdgeInsets.only(top: 20.0), // Cách lề trên 10 đơn vị
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              }),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('History'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/history');
              }),
            ListTile(
              leading: const Icon(Icons.replay),
              title: const Text('Relay'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/relay');
              }),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Schedule'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/schedule');
              }),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/profile');
              }),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/setting');
              }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              // ignore: avoid_print
              onTap: () => print('Logout tapped')),
          ],
        ),
      ),
    );
  }
}
