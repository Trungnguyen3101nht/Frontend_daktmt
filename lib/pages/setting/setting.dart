import 'package:flutter/material.dart';
import 'dart:ui'; // Required for BackdropFilter
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';
import 'package:frontend_daktmt/pages/upgrade/upgrade.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  String selectedLanguage = 'English';
  String selectedConnection = 'MQTT';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Settings wrapped in bordered container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    value: isDarkMode,
                    onChanged: (bool value) {
                      setState(() {
                        isDarkMode = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Language'),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0), // Điều chỉnh khoảng cách ở đây
                            child: DropdownButton<String>(
                              value: selectedLanguage,
                              items: <String>['English', 'Vietnamese']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedLanguage = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Connection'),
                      DropdownButton<String>(
                        value: selectedConnection,
                        items: <String>['MQTT', 'WebSocket']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedConnection = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Save settings logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Settings saved')),
                        );
                      },
                      child: const Text('Save Settings'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Upgrade section with blurred image and rounded corners
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16), // Rounded corners for the container
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), // Ensure this also has rounded corners
                            image: const DecorationImage(
                              image: AssetImage('assets/cardOCB.png'), // Your image path here
        
                            ),
                          ),
                        ),
                      ),
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), // Blur only the background
                        child: Container(
                          color: Colors.black.withOpacity(0), // Invisible container for blur effect
                        ),
                      ),
                    ),
                    // Positioned text above the button
                    // const Positioned(
                    //   top: 50, // Adjust the position to place text above the button
                    //   left: 0,
                    //   right: 0,
                    //   child: Center(
                    //     child: Text(
                    //       'You can get a lot more by upgrading to premium. Get all features now.',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold,
                    //         color: Colors.white,
                    //         shadows: [
                    //           Shadow(
                    //             blurRadius: 10.0,
                    //             color: Colors.black,
                    //             offset: Offset(3, 3),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // // Positioned button below the text
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const UpgradePage()),
                          );
                        },
                        child: const Text('Upgrade Account'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

