import 'package:flutter/material.dart';

// ignore: camel_case_types
class noitification_setting extends StatelessWidget {
  const noitification_setting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 30,
      right: 55,
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
                    width: 300,
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
                          'Thông báo',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('Noitifications'),
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

