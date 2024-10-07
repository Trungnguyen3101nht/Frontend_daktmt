import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:frontend_daktmt/pages/home/home.dart';

class GaugeWidget extends StatelessWidget {
  final String label;
  final double value;

  const GaugeWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    String unit = label == 'Humidity' ? '%' : '°C';

    // Xác định màu sắc ghi chú dựa trên giá trị
    Color annotationColor;
    if (value < 20) {
      annotationColor = Colors.green; // Giá trị thấp
    } else if (value < 40) {
      annotationColor = Colors.yellow; // Giá trị trung bình thấp
    } else if (value < 60) {
      annotationColor = Colors.orange; // Giá trị trung bình
    } else {
      annotationColor = Colors.red; // Giá trị cao
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Phần Gauge được bọc bởi Expanded
        Expanded(
          child: SizedBox(
            height: 170,
            child: SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0,
                        endValue: 20,
                        color: const Color.fromARGB(255, 1, 254, 10)),
                    GaugeRange(
                        startValue: 20,
                        endValue: 40,
                        color: const Color.fromARGB(255, 179, 255, 0)),
                    GaugeRange(
                        startValue: 40,
                        endValue: 60,
                        color: const Color.fromARGB(255, 255, 242, 0)),
                    GaugeRange(
                        startValue: 60,
                        endValue: 80,
                        color: const Color.fromARGB(255, 255, 187, 0)),
                    GaugeRange(
                        startValue: 80,
                        endValue: 100,
                        color: const Color.fromARGB(255, 255, 94, 0)),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: value,
                      needleLength: 0.6,
                      needleStartWidth: 1,
                      needleEndWidth: 2,
                      needleColor: Colors.red,
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                        decoration: BoxDecoration(
                          color: annotationColor, // Màu sắc ghi chú
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            '${value.toStringAsFixed(1)} $unit',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Màu chữ
                            ),
                          ),
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
        ),
        // Ghi chú màu bên phải với dấu chấm
        Container(
          margin: const EdgeInsets.only(
              left: 5, top: 20), // Khoảng cách giữa gauge và ghi chú màu
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              // Dấu chấm và ghi chú cho 'Low'
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Low'),
                ],
              ),
              const SizedBox(height: 5),
              // Dấu chấm và ghi chú cho 'Medium Low'
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Medium Low'),
                ],
              ),
              const SizedBox(height: 5),
              // Dấu chấm và ghi chú cho 'Medium'
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Medium'),
                ],
              ),
              const SizedBox(height: 5),
              // Dấu chấm và ghi chú cho 'High'
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('High'),
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
        child: GaugeWidget(
            label: 'Humidity', value: value), 
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
        child: GaugeWidget(
            label: 'Temperature', value: value), 
      ),
    );
  }
}
