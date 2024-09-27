// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class toggle extends StatelessWidget {
  const toggle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4, // 4 cột cho trạng thái On/Off
      crossAxisSpacing: 10.0,
      mainAxisSpacing: 5.0,
      children: const [
        OnOffSwitch(label: 'Relay 1', state: true), // Hiển thị Relay 1 On
        OnOffSwitch(label: 'Relay 2', state: false), // Hiển thị Relay 2 Off
        OnOffSwitch(label: 'Relay 3', state: true), // Hiển thị Relay 3 On
        OnOffSwitch(label: 'Relay 4', state: false), // Hiển thị Relay 4 Off
      ],
    );
  }
}

// Custom On/Off Switch Widget
class OnOffSwitch extends StatelessWidget {
  final String label; // Nhãn cho mỗi relay
  final bool state;   // Trạng thái On/Off

  const OnOffSwitch({super.key, required this.label, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Đường viền khung
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
          const SizedBox(height: 5),
          Text(
            state ? 'On' : 'Off', // Hiển thị trạng thái On/Off
            style: TextStyle(
              color: state ? Colors.green : Colors.red, // Màu cho On/Off
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
