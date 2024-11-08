import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UpdateOptionsDialog extends StatefulWidget {
  final String token;

  const UpdateOptionsDialog({super.key, required this.token});

  @override
  _UpdateOptionsDialogState createState() => _UpdateOptionsDialogState();
}

class _UpdateOptionsDialogState extends State<UpdateOptionsDialog> {
  String? selectedBoard;
  List<Map<String, String>> versions = []; // Updated to store version and size
  bool isLoading = false;

  Future<void> fetchVersionData(String board) async {
    setState(() {
      isLoading = true;
    });
    final baseUrl = dotenv.env['API_BASE_URL']!;
    print(board);
    final response = await http.post(
      Uri.parse('http://$baseUrl/firmware/get'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${widget.token}', // Use the token passed to the widget
      },
      body: json.encode({
        'board': board,
      }),
    );
    print(board);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      print(data);
    } else {
      setState(() {
        isLoading = false;
      });
      final result = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: ${result['error']}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> boardOptions = ['Yolo Uno', 'Relay 6ch'];

    return AlertDialog(
      title: const Text("Software Update"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Devices'),
              DropdownButton<String>(
                hint: const Text("Select Device",
                    style: TextStyle(color: Colors.blueAccent)),
                value: selectedBoard,
                items: boardOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBoard = newValue;
                    versions = [];
                  });
                  if (newValue != null) {
                    print(newValue);
                    fetchVersionData(newValue);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : versions.isEmpty
                  ? const Center(child: Text("No versions available"))
                  : Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: versions.length,
                        itemBuilder: (context, index) {
                          final versionInfo = versions[index];
                          return ListTile(
                            title: Text("Version: ${versionInfo['version']}"),
                            subtitle: Text("Size: ${versionInfo['size']}"),
                          );
                        },
                      ),
                    ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
