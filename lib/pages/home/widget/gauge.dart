import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/home.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GaugeWidget extends StatelessWidget {
  final String label;
  final double value;

  const GaugeWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    String unit = label == 'Humidity' ? '%' : '°C';
    return Column(
      
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
  
        SizedBox(
          height: 170,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                ranges: <GaugeRange>[
                  GaugeRange(startValue: 0, endValue: 20, color: const Color.fromARGB(255, 1, 254, 10)),
                  GaugeRange(startValue: 20, endValue: 40, color: const Color.fromARGB(255, 179, 255, 0)),
                  GaugeRange(startValue: 40, endValue: 60, color: const Color.fromARGB(255, 255, 242, 0)),
                  GaugeRange(startValue: 60, endValue: 80, color: const Color.fromARGB(255, 255, 187, 0)),
                  GaugeRange(startValue: 80, endValue: 100, color: const Color.fromARGB(255, 255, 94, 0)),
                ],
                pointers: <GaugePointer>[
                  NeedlePointer(
                    value: value,
                    needleLength: 0.6, // Chiều dài của mũi tên (0.7 có nghĩa là 70% chiều dài tối đa)
                    needleStartWidth: 1, // Chiều rộng phần đầu mũi tên
                    needleEndWidth: 2, // Chiều rộng phần cuối mũi tên
                    needleColor: Colors.red, 
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    widget: Text(
                      '${value.toStringAsFixed(1)} $unit', // Hiển thị giá trị với 1 chữ số thập phân
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.7,
                  ),
                ],

              ),
            ],
          ),
        ),

        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),],
      
    );
  }
}




// ignore: camel_case_types
class humigauge extends StatelessWidget {
  const humigauge({
    super.key,
    required this.gaugeHeight,
    required this.gaugeWidth,
    required this.value, // Thêm thuộc tính value
  });

  final double gaugeHeight;
  final double gaugeWidth;
  final double value; // Giá trị độ ẩm động

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: SizedBox(
        height: gaugeHeight,
        width: gaugeWidth,
        child: GaugeWidget(label: 'Humidity', value: value), // Truyền giá trị value động
      ),
    );
  }
}

// ignore: camel_case_types
class tempgauge extends StatelessWidget {
  const tempgauge({
    super.key,
    required this.gaugeHeight,
    required this.gaugeWidth,
    required this.value, // Thêm thuộc tính value
  });

  final double gaugeHeight;
  final double gaugeWidth;
  final double value; // Giá trị nhiệt độ động

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: SizedBox(
        height: gaugeHeight,
        width: gaugeWidth,
        child: GaugeWidget(label: 'Temperature', value: value), // Truyền giá trị value động
      ),
    );
  }
}

