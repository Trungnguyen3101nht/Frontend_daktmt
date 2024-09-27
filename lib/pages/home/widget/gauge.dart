import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/home.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  final String label;
  final double value;

  const GaugeWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        SizedBox(
          height: 150,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 20, color: Colors.green),
                  GaugeRange(startValue: 20, endValue: 40, color: const Color.fromARGB(255, 179, 255, 0)),
                  GaugeRange(startValue: 40, endValue: 60, color: const Color.fromARGB(255, 217, 255, 0)),
                  GaugeRange(startValue: 60, endValue: 80, color: const Color.fromARGB(255, 255, 187, 0)),
                  GaugeRange(startValue: 80, endValue: 100, color: const Color.fromARGB(255, 255, 94, 0)),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(value: value),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}




// ignore: camel_case_types
class humigaugemobile extends StatelessWidget {
  const humigaugemobile({
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
        child: const GaugeWidget(label: 'Humidity', value: 60.0),
      ),
    );
  }
}

// ignore: camel_case_types
class tempgaugemobile extends StatelessWidget {
  const tempgaugemobile({
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
        child: const GaugeWidget(label: 'Temperature', value: 25.0),
      ),
    );
  }
}

// ignore: camel_case_types
class humigaugedesk extends StatelessWidget {
  const humigaugedesk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BorderedContainer(
      child: SizedBox(
        height: 180.0,
        width: double.infinity,
        child: GaugeWidget(label: 'Humidity', value: 60.0),
      ),
    );
  }
}

// ignore: camel_case_types
class tempgaugedesk extends StatelessWidget {
  const tempgaugedesk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BorderedContainer(
      child: SizedBox(
        height: 180.0,
        width: double.infinity,
        child: GaugeWidget(label: 'Temperature', value: 25.0),
      ),
    );
  }
}


