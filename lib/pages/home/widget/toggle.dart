import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Relay {
  final int id;
  final String name;
  final bool isOn;

  Relay({required this.id, required this.name, this.isOn = false});

  factory Relay.fromJson(Map<String, dynamic> json) {
    return Relay(
      id: json['relay_id'] ?? 0,
      name: json['relay_name'] ?? 'Unnamed Relay',
      isOn: json['state'] ?? false,
    );
  }
}

class toggle extends StatefulWidget {
  final double toggleHeight;
  final double toggleWidth;
  final int numOfRelay;

  const toggle({
    super.key,
    required this.toggleHeight,
    required this.toggleWidth,
    required this.numOfRelay,
  });

  @override
  _ToggleState createState() => _ToggleState();
}

class _ToggleState extends State<toggle> {
  List<Relay> homeRelays = [];

  @override
  void initState() {
    super.initState();
    fetchHomeRelays();
  }

  Future<void> fetchHomeRelays() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken') ?? '';

    // Check if environment variable is loaded properly
    final baseUrl = dotenv.env['API_BASE_URL'];
    print(homeRelays);
    if (baseUrl == null) {
      print("Error: API_BASE_URL is not set in .env");
      return;
    }

    final url = Uri.parse('http://$baseUrl/relay/get-home');

    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData is List) {
          setState(() {
            homeRelays = responseData
                .map<Relay>((relayJson) => Relay.fromJson(relayJson))
                .toList();
          });
          print(homeRelays);
          print("Successfully fetched home relays.");
        } else {
          print("Unexpected response format: ${response.body}");
        }
      } else {
        print("Failed to fetch home relays: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (homeRelays.isEmpty) {
      return const Center(child: Text("No relays available"));
    }

    return Center(
      child: SizedBox(
        width: widget.toggleWidth,
        height: widget.toggleHeight,
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.0, // Horizontal spacing between widgets
          runSpacing: 10.0, // Vertical spacing between widgets
          children: List.generate(homeRelays.length, (index) {
            return SizedBox(
              width: widget.toggleWidth / widget.numOfRelay - 10,
              height: 100.0,
              child: OnOffSwitch(
                label: homeRelays[index].name,
                state: homeRelays[index].isOn,
              ),
            );
          }),
        ),
      ),
    );
  }
}

class OnOffSwitch extends StatelessWidget {
  final String label;
  final bool state;

  const OnOffSwitch({super.key, required this.label, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 214, 220, 231),
            Color.fromARGB(255, 165, 164, 234),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(
          color: const Color.fromARGB(255, 49, 60, 178).withOpacity(0.5),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Color.fromARGB(255, 42, 5, 113),
            ),
            overflow:
                TextOverflow.ellipsis, // Adds "..." if the text is too long
            maxLines: 1, // Limits to a single line
            softWrap: false, // Prevents wrapping to a new line
          ),
          const SizedBox(height: 2),
          Text(
            state ? 'On' : 'Off',
            style: TextStyle(
              color: state ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
