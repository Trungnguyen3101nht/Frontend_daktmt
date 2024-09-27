import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/home.dart';

class Mapdesk extends StatelessWidget {
  const Mapdesk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BorderedContainer(
      child: SizedBox(
        height: 220.0,
        width: double.infinity,
        child: Center(child: Text('Map')),
      ),
    );
  }
}



// ignore: camel_case_types
class mapmobile extends StatelessWidget {
  const mapmobile({
    super.key,
    required this.gaugeHeight,
    required this.gaugeWidth,
  });

  final double gaugeHeight;
  final double gaugeWidth;

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: SizedBox(
        height: gaugeHeight,
        width: gaugeWidth,
        child: const Center(child: Text('Map')),
      ),
    );
  }
}

