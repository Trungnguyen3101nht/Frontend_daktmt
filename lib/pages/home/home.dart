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
    final isTablet = Responsive.isTablet(context);
    final isDesktop = Responsive.isDesktop(context);

    final double horizontalPadding = isMobile ? 8.0 : 200.0; // Padding cho 2 bên cho trên và dưới
    const double verticalPadding = 10.0;
    final double gaugeHeight = isMobile ?   200.0 : (isTablet ? 175.0 : 150.0);
    final double gaugeWidth = isMobile ? double.infinity : (isTablet ? 350.0 : 100.0); 
    final bool isRowLayout = isDesktop;  
    return Scaffold(
      drawer: const Navbar_left(),
      endDrawer: const Navbar_right(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: isRowLayout
              ? const Column(
                      children: [
                        // Hàng 1
                        Row(
                          children: [
                            Expanded(
                              flex: 3, // Cột 1 của hàng 1
                              child: Column(
                                children: [
                                  toggle(), // Toggle
                                  SizedBox(height: 10),
                                  Mapdesk(), // Map
                                ],
                              ),
                            ),
                            SizedBox(width: 10), // Khoảng cách giữa cột 1 và cột 2
                            Expanded(
                              flex: 2, // Cột 2 của hàng 1
                              child: Column(
                                children: [
                                  tempgaugedesk(), // Gauge của nhiệt độ
                                  SizedBox(height: 10),
                                  humigaugedesk(), // Gauge của độ ẩm
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 10), // Khoảng cách giữa hàng 1 và hàng 2
                        
                        // Hàng 2
                        Row(
                          children: [
                            Expanded(
                              child: tempchartdesk(), // Chart nhiệt độ
                            ),
                            SizedBox(width: 10), // Khoảng cách giữa 2 chart
                            Expanded(
                              child: humichartdesk(), // Chart độ ẩm
                            ),
                          ],
                        ),
                      ],
                    )

              : Column(
                  children: [
                    // Grid với các Switches cho Mobile/Tablet layout
                    const toggle(),
                    const SizedBox(height: 10),

                    // Temperature Gauge
                    tempgaugemobile(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                    const SizedBox(height: 10),

                    // Humidity Gauge
                    humigaugemobile(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                    const SizedBox(height: 10),

                    // Map
                    mapmobile(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                    const SizedBox(height: 10),
                    humichartmobile(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                    const SizedBox(height: 10),
                    tempchartmobile(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                  ],
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
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
