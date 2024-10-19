import 'package:flutter/material.dart';
import 'package:frontend_daktmt/responsive.dart';

// ignore: camel_case_types
class noitification_setting extends StatelessWidget {
  const noitification_setting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final bool isRowLayout = isDesktop;

    return Positioned(
      top: isRowLayout ? 15 : 30,
      right: isRowLayout ? 170 : 55,
      child: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              barrierColor: Colors.transparent, // Để nền không bị tối
              builder: (BuildContext context) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: isRowLayout ? 300 : MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.only(top: 16, right: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Noitifications',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('lêu lêu'),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

