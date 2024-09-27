
import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/home.dart';

// ignore: camel_case_types
class tempchartmobile extends StatelessWidget {
  const tempchartmobile({
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
        child: const Center(child: Text('Temperature chart')),
      ),
    );
  }
}

// ignore: camel_case_types
class humichartmobile extends StatelessWidget {
  const humichartmobile({
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
        child: const Center(child: Text('Humidity chart')),
      ),
    );
  }
}

// ignore: camel_case_types
class humichartdesk extends StatelessWidget {
  const humichartdesk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BorderedContainer(
      child: SizedBox(
        height: 200.0,
        width: double.infinity,
        child: Center(child: Text('Humidity Chart')),
      ),
    );
  }
}

// ignore: camel_case_types
class tempchartdesk extends StatelessWidget {
  const tempchartdesk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BorderedContainer(
      child: SizedBox(
        height: 200.0,
        width: double.infinity,
        child: Center(child: Text('Temperature Chart')),
      ),
    );
  }
}

