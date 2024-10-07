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
  String token = 'accesstoken';

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
                    Color.fromARGB(255, 0, 66, 180),
                    Color.fromARGB(255, 26, 175, 0),
                    Color.fromARGB(158, 255, 187, 0),
                   
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: 0.0),
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
                                        gaugeHeight: 280.0,
                                        gaugeWidth: double.infinity,
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
                            const Row(
                              children: [
                                Expanded(
                                  child: TempChart(
                                    gaugeHeight: 250.0,
                                    gaugeWidth: 100.0,
                                  ),
                                ),
                                SizedBox(width: 10),
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
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 243, 243, 243).withOpacity(1),
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
                                map(
                                    gaugeHeight: gaugeHeight,
                                    gaugeWidth: gaugeWidth),
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
            Positioned(
              top: 30,
              left: 16,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),


            Positioned(
              top: 30,
              right: 55,
              child: Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
              ),
            ),



            // Nút mở endDrawer bên phải
            Positioned(
              top: 40,
              right: 16,
              child: Builder(
                builder: (context) => GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: ClipOval(
                    child: Image.asset(
                      'assets/hcmut.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
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
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: child,
    );
  }
}
