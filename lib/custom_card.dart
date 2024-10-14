import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const CustomCard({super.key, this.color,this.padding, required this.child});
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
          padding:padding?? const EdgeInsets.all(12.0),
          child: child,
        ));
  }
}
