// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

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
  final bool state;   // Trạng thái On/Off

  const OnOffSwitch({super.key, required this.label, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 253, 253, 254).withOpacity(0.3),
          width: 2.0,
        ), 
        color: const Color.fromARGB(255, 252, 251, 251).withOpacity(0.6),
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
            style:TextStyle(
              color: state ? const Color.fromARGB(255, 0, 94, 245) : const Color.fromARGB(255, 254, 2, 2) , // Màu cho On/Off
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
