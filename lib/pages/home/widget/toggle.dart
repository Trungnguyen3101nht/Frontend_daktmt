// ignore_for_file: camel_case_types

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_daktmt/pages/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Relay {
  String id;
  String name;
  bool isOn;

  Relay({required this.id, required this.name, this.isOn = false});
}

List<Relay> relays = [];
List<Relay> homeRelays = [];

// Future<List<String>> fetchHomeRelays() async {
//   final prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString('accessToken')!;
//   final baseUrl = dotenv.env['API_BASE_URL']!;
//   final url = Uri.parse('http://$baseUrl/relay/get-home');
//   try {
//     var response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);

//       if (responseData is List) {
//         List<Relay> fetchedSchedules = responseData
//             .map<Relay>((scheduleJson) => Relay.fromJson(scheduleJson))
//             .toList();

//         setState(() {
//           todaySchedules = fetchedSchedules;
//           // filterTodaySchedules(); // Filter today's schedules after updating the list
//         });
//         print("Success to fetch schedules");
//       } else {
//         print("Unexpected response format: ${response.body}");
//       }
//       List<Relay> data = jsonDecode(response.body);
//       return data.map<Relay>((relay) => relay.toString()).toList();
//     } else {
//       logger.w("Failed to fetch home relays: ${response.body}");
//       return [];
//     }
//   } catch (e) {
//     logger.e("Error occurred: $e");
//     return [];
//   }
// }

// void _relayHomeCheck() async {
//   homeRelays = await fetchHomeRelays();
// }

class toggle extends StatelessWidget {
  const toggle({
    super.key,
    required this.toggleHeight,
    required this.toggleWidth,
    required this.numOfRelay,
  });

  final double toggleHeight;
  final double toggleWidth;
  final int numOfRelay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: toggleWidth,
      height: toggleHeight,
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: numOfRelay,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 5.0,
        children: const [
          OnOffSwitch(label: 'Relay 1', state: true),
          OnOffSwitch(label: 'Relay 2', state: false),
          OnOffSwitch(label: 'Relay 3', state: true),
          OnOffSwitch(label: 'Relay 4', state: false),
          OnOffSwitch(label: 'Relay 5', state: true),
          OnOffSwitch(label: 'Relay 6', state: false),
        ],
      ),
    );
  }
}

// Custom On/Off Switch Widget
class OnOffSwitch extends StatelessWidget {
  final String label; // Nhãn cho mỗi relay
  final bool state; // Trạng thái On/Off

  const OnOffSwitch({super.key, required this.label, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
          width: 2.0,
        ),
        color: const Color.fromARGB(255, 252, 251, 251),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label, // Hiển thị nhãn "Relay :"
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            state ? 'On' : 'Off', // Hiển thị trạng thái On/Off
            style: TextStyle(
              color: state
                  ? const Color.fromARGB(255, 46, 163, 0)
                  : const Color.fromARGB(255, 254, 2, 2), // Màu cho On/Off
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
