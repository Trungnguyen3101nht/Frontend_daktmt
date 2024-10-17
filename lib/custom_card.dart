import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const CustomCard({super.key, this.color, this.padding, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
          color: color ?? const Color.fromARGB(255, 255, 255, 255),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(12.0),
          child: child,
        ));
  }
}

// ignore: non_constant_identifier_names
BoxDecoration backgound_Color() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromARGB(255, 0, 94, 255),
        Color.fromARGB(255, 38, 255, 0),
        Color.fromARGB(255, 255, 187, 0),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
