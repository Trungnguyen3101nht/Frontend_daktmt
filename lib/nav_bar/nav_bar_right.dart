import 'package:flutter/material.dart';

// ignore: camel_case_types
class nabarright_set extends StatelessWidget {
  const nabarright_set({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}

// ignore: camel_case_types
class Navbar_right extends StatelessWidget {
  const Navbar_right({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  [
          UserAccountsDrawerHeader(
            accountName: const Text('NguyenTrung'),
            accountEmail: const Text('trungvodich@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.asset('assets/hcmut.png'),
                  ),
            ),
            decoration: const BoxDecoration(
             color: Color.fromARGB(255, 165, 165, 165),
            //   image: DecorationImage(image: AssetImage('C:/Users/trung/Pictures/download image/pxfuel.jpg'))
            ),
          ),
          const Divider(),
          const ListTile(
              title: Text('Tests scheduled'),
         ),
      ],
      ),
    );
  }
}
