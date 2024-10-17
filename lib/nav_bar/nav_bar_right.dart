import 'package:flutter/material.dart';

// ignore: camel_case_types
class nabarright_set extends StatelessWidget {
  const nabarright_set({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 38,
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
        children: [
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
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('Tests scheduled'),
          ),
          // Schedule cards wrapped in boxes
          _buildScheduleCard("Mathematics", "On", "Mon"),
          _buildScheduleCard("Physics", "Off", "Wed"),
          _buildScheduleCard("Chemistry", "On", "Fri"),
          _buildScheduleCard("English", "Off", "Sun"),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(String subject, String status, String day) {
    // ignore: non_constant_identifier_names
    String Subject =
        subject.length > 10 ? "${subject.substring(0, 10)}..." : subject;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Subject,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              status ,
              style: TextStyle(
                color: status == "On" ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
