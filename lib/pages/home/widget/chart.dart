
import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/home.dart';
import 'package:fl_chart/fl_chart.dart';

class TempChart extends StatelessWidget {
  const TempChart({
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
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: true, border: const Border(
                bottom: BorderSide(color: Color.fromARGB(255, 250, 1, 1), width: 1),
                left: BorderSide(color: Color.fromARGB(255, 250, 18, 1), width: 1),
              ),),
            maxY: 100,
            minY: 0,
            lineBarsData: [
              LineChartBarData(
                isCurved: false,
                color: const Color.fromARGB(255, 255, 0, 0),
                barWidth: 2,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true, 
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:  [
                    const Color.fromARGB(255, 220, 104, 104).withOpacity(0.8), // Start with opacity at the top
                    const Color.fromARGB(255, 220, 104, 104).withOpacity(0.6), 
                    const Color.fromARGB(255, 220, 104, 104).withOpacity(0.4),
                    const Color.fromARGB(255, 220, 104, 104).withOpacity(0.2),
                    ],
                  ),
                ),
                spots: const [
                  FlSpot(0, 28),
                  FlSpot(1, 26),
                  FlSpot(2, 32),
                  FlSpot(3, 28),
                  FlSpot(4, 25),
                  FlSpot(5, 21),
                  FlSpot(6, 30),
                ],
              ),
            ],
             titlesData: const FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide right Y-axis
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide top X-axis
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HumiChart extends StatelessWidget {
  const HumiChart({
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
        child: LineChart(
          LineChartData(
            borderData: FlBorderData(show: true, border: const Border(
                bottom: BorderSide(color: Color.fromARGB(255, 1, 63, 250), width: 1),
                left: BorderSide(color: Color.fromARGB(255, 1, 63, 250), width: 1),
              ),
            ),
            maxY: 100,
            minY: 0,
            lineBarsData: [
              LineChartBarData(
                isCurved: false,
                color: const Color.fromARGB(255, 2, 95, 255),
                barWidth: 2,
                dotData: const FlDotData(show: true),
                belowBarData: BarAreaData(
                  show: true, 
                  gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:  [
                    const Color.fromARGB(255, 116, 141, 188).withOpacity(0.8), // Start with opacity at the top
                    const Color.fromARGB(255, 116, 141, 188).withOpacity(0.6), 
                    const Color.fromARGB(255, 116, 141, 188).withOpacity(0.4),
                    const Color.fromARGB(255, 116, 141, 188).withOpacity(0.2),
                    ],
                  ),
                ),
                spots: const [
                  FlSpot(0, 65),
                  FlSpot(1, 70),
                  FlSpot(2, 68),
                  FlSpot(3, 72),
                  FlSpot(4, 75),
                  FlSpot(5, 72),
                  FlSpot(6, 75),
                ],
              ),
            ],
            titlesData: const FlTitlesData(
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide right Y-axis
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false), // Hide top X-axis
              ),
            ),
            gridData: const FlGridData(show: true),
          ),
        ),
      ),
    );
  }
}
