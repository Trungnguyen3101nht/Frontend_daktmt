import 'package:flutter/material.dart';
import 'package:frontend_daktmt/pages/home/widget/chart.dart';
import 'package:frontend_daktmt/pages/home/widget/map.dart';
import 'package:frontend_daktmt/pages/home/widget/toggle.dart';
import 'package:frontend_daktmt/responsive.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_right.dart';
import 'widget/gauge.dart';
import 'package:frontend_daktmt/apis/api_server.dart';
import 'package:frontend_daktmt/pages/noitification/noitification.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double humidity = 0.0;
  double temperature = 0.0;
  String token = 'accesstoken';

  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

  Future<void> fetchSensorData() async {
    try {
      final humiValue = await fetchHumidity(token, context);
      // ignore: use_build_context_synchronously
      final tempValue = await fetchTemperature(token, context);

      setState(() {
        humidity = humiValue ?? 0.0; // Cập nhật giá trị độ ẩm
        temperature = tempValue ?? 0.0; // Cập nhật giá trị nhiệt độ
      });
    } catch (error) {
      print("Lỗi khi tải dữ liệu: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isMobile ? 0.0 : 100.0;
    final double gaugeHeight = isMobile ? 200.0 : 150.0;
    final double gaugeWidth = isMobile ? double.infinity : 100.0;

    final bool isRowLayout = isDesktop;

    return Scaffold(
      drawer: const Navbar_left(),
      endDrawer: const Navbar_right(),
      body: SingleChildScrollView(
        // Chuyển SingleChildScrollView lên đây
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 0, 94, 255),
                    Color.fromARGB(255, 38, 255, 0),
                    Color.fromARGB(255, 255, 187, 0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: isRowLayout
                    //!/ Layout dành cho desktop, tablets
                    ? SizedBox(
                        height: MediaQuery.of(context)
                            .size
                            .height, // Chiều cao bằng chiều cao màn hình
                        child: Column(
                          children: [
                            const SizedBox(height: 80.0),
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
                                        mapHeight: 280.0,
                                        mapWidth: double.infinity,
                                      ),
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
                                        value: temperature,
                                      ),
                                      const SizedBox(height: 10),
                                      humigauge(
                                        gaugeHeight: 195.0,
                                        gaugeWidth: double.infinity,
                                        value: humidity,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TempChart(
                                    gaugeHeight: 250.0,
                                    gaugeWidth: 100.0,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: HumiChart(
                                    gaugeHeight: 250.0,
                                    gaugeWidth: 100.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      )

                    //!/ Layout dành cho mobile
                    : Column(
                        children: [
                          const SizedBox(height: 80.0),
                          const toggle(
                            toggleHeight: 270.0,
                            toggleWidth: 350.0,
                            numOfRelay: 3,
                          ),
                          const SizedBox(height: 40),
                          // Bao bọc các thành phần còn lại trong Container
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243)
                                  .withOpacity(1),
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(17.0),
                              ),
                            ),
                            child: Column(
                              children: [
                                tempgauge(
                                  gaugeHeight: gaugeHeight,
                                  gaugeWidth: gaugeWidth,
                                  value: temperature,
                                ),
                                const SizedBox(height: 20),
                                humigauge(
                                  gaugeHeight: gaugeHeight,
                                  gaugeWidth: gaugeWidth,
                                  value: humidity,
                                ),
                                const SizedBox(height: 20),
                                map(mapHeight: gaugeHeight, mapWidth: gaugeWidth),
                                const SizedBox(height: 20),
                                HumiChart(
                                  gaugeHeight: gaugeHeight,
                                  gaugeWidth: gaugeWidth,
                                ),
                                const SizedBox(height: 20),
                                TempChart(
                                  gaugeHeight: gaugeHeight,
                                  gaugeWidth: gaugeWidth,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),

            // Nút mở Drawer bên trái
            const navbarleft_set(),

            const noitification_setting(),

            // Nút mở endDrawer bên phải
            const nabarright_set(),
          ],
        ),
      ),
    );
  }
}

// // Widget bổ sung viền quanh các thành phần
// class BorderedContainer extends StatelessWidget {
//   final Widget child;

//   const BorderedContainer({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 255, 255, 255),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: child,
//     );
//   }
// }
