import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/widget/chart.dart';
import 'package:frontend_daktmt/pages/home/widget/map.dart';
import 'package:frontend_daktmt/pages/home/widget/toggle.dart';
import 'package:frontend_daktmt/responsive.dart';

import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_right.dart';

import 'widget/gauge.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override   
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    // final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);

    final double horizontalPadding = isMobile ? 8.0 : 100.0; // Padding cho 2 bên cho trên và dưới
    const double verticalPadding = 10.0;
    final double gaugeHeight = isMobile ?   200.0 : 150.0;
    final double gaugeWidth = isMobile ? double.infinity  : 100.0; 

    final bool isRowLayout = isDesktop;  
    return Scaffold(
      drawer: const Navbar_left(),
      endDrawer: const Navbar_right(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // Thay đổi chiều cao của AppBar
        child: AppBar(
            title: const Text('Home'),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Màu nền của AppBar
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50.0),
                bottomRight: Radius.circular(50.0),
              ),
            ),
          ),
      ),
      body:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 98, 145, 227), Color.fromARGB(255, 104, 216, 84)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: isRowLayout
              // desk devieces 
              ? const Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  toggle(toggleHeight: 140.0, toggleWidth: 800.0, numOfRelay:6, ), // Toggle
                                  SizedBox(height: 10),
                                  map(gaugeHeight: 280.0, gaugeWidth: double.infinity),
// Map
                                ],
                              ),
                            ),
                            SizedBox(width: 10), 
                            Expanded(
                              flex: 2, 
                              child: Column(
                                children: [
                                  tempgauge(gaugeHeight: 195.0, gaugeWidth: double.infinity), 
                                  SizedBox(height: 10),
                                  humigauge(gaugeHeight: 195.0, gaugeWidth: double.infinity), 
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10), 
                        Row(
                          children: [
                            Expanded(
                              child: TempChart(gaugeHeight: 250.0, gaugeWidth: 100.0), // Chart nhiệt độ
                            ),
                            SizedBox(width: 10), // Khoảng cách giữa 2 chart
                            Expanded(
                              child: HumiChart(gaugeHeight: 250.0, gaugeWidth: 100.0), // Chart độ ẩm
                            ),
                          ],
                        ),
                      ],
                    )

            //Mobile devices
            : Column(
                children: [
                  
                  const toggle(toggleHeight: 230.0, toggleWidth: 350.0, numOfRelay: 3,),
                  const SizedBox(height: 10),

                  // Temperature Gauge
                  tempgauge(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                  const SizedBox(height: 10),

                  // Humidity Gauge
                  humigauge(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                  const SizedBox(height: 10),

                  // Map
                  map(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                  const SizedBox(height: 10),
                  HumiChart(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                  const SizedBox(height: 10),
                  TempChart(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                ],
              ),
        ),
      ),
      ),
    );
  }
}

// Widget to add a border around components
class BorderedContainer extends StatelessWidget {
  final Widget child;

  const BorderedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 233, 167, 233),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
