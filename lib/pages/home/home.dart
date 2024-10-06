import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/widget/chart.dart';
import 'package:frontend_daktmt/pages/home/widget/map.dart';
import 'package:frontend_daktmt/pages/home/widget/toggle.dart';
import 'package:frontend_daktmt/responsive.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_right.dart';
import 'widget/gauge.dart';
import 'package:frontend_daktmt/api_server.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double humidity = 0.0;
  double temperature = 0.0;
  final ApiService apiService = ApiService();
  String token = 'token';

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

Future<void> fetchSensorData() async {
  try {
    final double? humi = await apiService.getHumidity(token);
    final double? temp = await apiService.getTemperature(token);

    setState(() {
      humidity = humi ?? 0.0; // Cập nhật giá trị độ ẩm
      temperature = temp ?? 0.0; // Cập nhật giá trị nhiệt độ
    });
  } catch (error) {
    print("Lỗi khi tải dữ liệu: $error");
  }
}



  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isMobile ? 8.0 : 100.0;
    const double verticalPadding = 10.0;
    final double gaugeHeight = isMobile ? 200.0 : 150.0;
    final double gaugeWidth = isMobile ? double.infinity : 100.0;

    final bool isRowLayout = isDesktop;

    return Scaffold(
      drawer: const Navbar_left(),
      endDrawer: const Navbar_right(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text('Home'),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              bottomRight: Radius.circular(50.0),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 98, 145, 227),
              Color.fromARGB(255, 104, 216, 84)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: isRowLayout
                // Layout dành cho desktop
                ? Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                toggle(
                                  toggleHeight: 140.0,
                                  toggleWidth: 800.0,
                                  numOfRelay: 6,
                                ),
                                SizedBox(height: 10),
                                map(
                                    gaugeHeight: 280.0,
                                    gaugeWidth: double.infinity),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                tempgauge(
                                    gaugeHeight: 195.0,
                                    gaugeWidth: double.infinity,
                                    value: temperature),
                                const SizedBox(height: 10),
                                humigauge(
                                    gaugeHeight: 195.0,
                                    gaugeWidth: double.infinity,
                                    value: humidity),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Expanded(
                            child: TempChart(
                                gaugeHeight: 250.0, gaugeWidth: 100.0),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: HumiChart(
                                gaugeHeight: 250.0, gaugeWidth: 100.0),
                          ),
                        ],
                      ),
                    ],
                  )
                // Layout dành cho mobile
                : Column(
                    children: [
                      const toggle(
                        toggleHeight: 230.0,
                        toggleWidth: 350.0,
                        numOfRelay: 3,
                      ),
                      const SizedBox(height: 10),
                      tempgauge(
                        gaugeHeight: gaugeHeight,
                        gaugeWidth: gaugeWidth,
                        value: temperature,
                      ),
                      const SizedBox(height: 10),
                      humigauge(
                        gaugeHeight: gaugeHeight,
                        gaugeWidth: gaugeWidth,
                        value: humidity,
                      ),
                      const SizedBox(height: 10),
                      map(gaugeHeight: gaugeHeight, gaugeWidth: gaugeWidth),
                      const SizedBox(height: 10),
                      HumiChart(
                        gaugeHeight: gaugeHeight,
                        gaugeWidth: gaugeWidth,
                      ),
                      const SizedBox(height: 10),
                      TempChart(
                        gaugeHeight: gaugeHeight,
                        gaugeWidth: gaugeWidth,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// Widget bổ sung viền quanh các thành phần
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
