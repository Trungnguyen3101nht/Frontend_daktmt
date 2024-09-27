import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';
import 'package:frontend_daktmt/pages/history/history.dart';
import 'package:frontend_daktmt/pages/home/home.dart';
import 'package:frontend_daktmt/pages/profile/profile.dart';
import 'package:frontend_daktmt/pages/relay/relay.dart';
import 'package:frontend_daktmt/pages/schedule/schedule.dart';
import 'package:frontend_daktmt/pages/setting/setting.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_right.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const HistoryScreen(),
        '/relay': (context) => const RelayScreen(),
        '/schedule': (context) => const ScheduleScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/setting': (context) => const SettingsScreen(),
      },
    );
  }
}

class SearchScreen {
  const SearchScreen();
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: const Navbar_left(),
      endDrawer: const Navbar_right(),
      
      appBar: AppBar(
        title: const Text('Navigation drawer'),
        backgroundColor: const Color.fromARGB(255, 1, 253, 10),
      ),
      body: const Center(
        child: Text(
          'Main page',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
