import 'package:flutter/material.dart';
import 'package:frontend_daktmt/custom_card.dart';
import 'package:frontend_daktmt/pages/home/widget/chart.dart';
import 'package:frontend_daktmt/pages/home/widget/map.dart';
import 'package:frontend_daktmt/pages/home/widget/toggle.dart';
import 'package:frontend_daktmt/responsive.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_right.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  @override
  void initState() {
    super.initState();
    fetchSensorData();
  }

// Function to fetch sensor data
  Future<void> fetchSensorData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    double humidityData = 0.00; 
    double temperatureData = 0.00; 

    if (token == null || token.isEmpty) {
      print('Access Token không tồn tại.');
    } else {
      // Fetch humidity data
      humidityData = await fetchHumidityData(token);

      // Fetch temperature data
      temperatureData = await fetchTemperatureData(token);
    }

    // Cập nhật trạng thái
    setState(() {
      humidity = humidityData ; // Sử dụng '0' nếu không có giá trị
      temperature = temperatureData ; // Sử dụng '0' nếu không có giá trị
    });
  } catch (error) {
    print("Error fetching sensor data: $error");
  }
}


  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isMobile ? 0.0 : 100;
    final double verticalPadding = isMobile ? 0.0 : 100;
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
              decoration: backgound_Color(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                child: isRowLayout
                    //!/ Layout dành cho desktop, tablets
                    ? Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        toggle(
                                          toggleHeight: 100.0,
                                          toggleWidth: 600.0,
                                          numOfRelay: 6,
                                        ),
                                        map(
                                          mapHeight: 280.0,
                                          mapWidth: 500,
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
                                          gaugeWidth: 500,
                                          value: temperature,
                                        ),
                                        const SizedBox(height: 10),
                                        humigauge(
                                          gaugeHeight: 195.0,
                                          gaugeWidth: 500,
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
                                      gaugeHeight: 200.0,
                                      gaugeWidth: 80.0,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: HumiChart(
                                      gaugeHeight: 200.0,
                                      gaugeWidth: 2000.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          )
                        ],
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
                                map(
                                    mapHeight: gaugeHeight,
                                    mapWidth: gaugeWidth),
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
            const navbarleft_set(),
            const noitification_setting(),
            const nabarright_set(),
          ],
        ),
      ),
    );
  }
}
