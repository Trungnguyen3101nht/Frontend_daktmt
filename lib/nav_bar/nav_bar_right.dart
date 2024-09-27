import 'package:flutter/material.dart';

// ignore: camel_case_types
class Navbar_right extends StatelessWidget {
  const Navbar_right({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text('NguyenTrung'),
            accountEmail: Text('trungvodich@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  // child: Image.asset('images/profile.jpg'),
                  ),
            ),
            decoration: BoxDecoration(
             color: Color.fromARGB(255, 165, 165, 165),
            //   image: DecorationImage(image: AssetImage('C:/Users/trung/Pictures/download image/pxfuel.jpg'))
            ),
          ),
          Divider(),
          ListTile(
              title: Text('Tests scheduled'),
         ),
      ],
      ),
    );
  }
}
