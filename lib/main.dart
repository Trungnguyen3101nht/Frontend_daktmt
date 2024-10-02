import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';
import 'package:frontend_daktmt/pages/history/history.dart';
import 'package:frontend_daktmt/pages/home/home.dart';
import 'package:frontend_daktmt/pages/login/forget_pass.dart';
import 'package:frontend_daktmt/pages/login/register.dart';
import 'package:frontend_daktmt/pages/login/sign_in.dart';
import 'package:frontend_daktmt/pages/profile/profile.dart';
import 'package:frontend_daktmt/pages/relay/relay.dart';
import 'package:frontend_daktmt/pages/schedule/schedule.dart';
import 'package:frontend_daktmt/pages/setting/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthenticated = false; // Variable to hold authentication state

  @override
  void initState() {
    super.initState();
    _checkLoginStatus(); // Check login status when the app starts
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isAuthenticated =
          prefs.getBool('isLoggedIn') ?? false; // Get login status
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: _isAuthenticated ? '/main' : '/',
      routes: {
        '/': (context) => const SignIn(),
        '/signin': (context) => const SignIn(),
        '/register': (context) => const Register(),
        '/forget-password': (context) => const Forget(),
        '/main': (context) =>
            const MainPage(), // Navigate to MainPage for authenticated users
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

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),
      appBar: AppBar(
        title: const Text('Navigation Drawer'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'Main Page',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
