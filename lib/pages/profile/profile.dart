import 'package:flutter/material.dart';
import 'package:frontend_daktmt/nav_bar/nav_bar_left.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Biến để lưu trữ thông tin người dùng
  String username = 'Username';
  String email = 'user@example.com';
  String phone = '0123456789';
  String address = '123 Main St';

  // Biến để kiểm soát trạng thái chỉnh sửa
  bool isEditing = false;

  // TextEditingControllers cho các trường thông tin
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Khởi tạo các TextEditingControllers với giá trị ban đầu
    usernameController.text = username;
    emailController.text = email;
    phoneController.text = phone;
    addressController.text = address;
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
      if (!isEditing) {
        // Nếu không còn chỉnh sửa, cập nhật thông tin người dùng
        username = usernameController.text;
        email = emailController.text;
        phone = phoneController.text;
        address = addressController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar_left(),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ảnh bìa
            Container(
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://i0.wp.com/cdn.vietgame.asia/wp-content/uploads/20160316232806/Gundam-Extreme-Vs-Force-Danh-Gia-Game-1.jpg?fit=1920%2C870&ssl=1'), // Thay bằng URL ảnh bìa
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/avatar.jpg'), // Thay bằng URL avatar
            ),
            const SizedBox(height: 16),
            // Thông tin người dùng
            TextField(
              controller: usernameController,
              readOnly: !isEditing,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: emailController,
              readOnly: !isEditing,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              readOnly: !isEditing,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: addressController,
              readOnly: !isEditing,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
          ],
        ),
      ),
    );
  }
}
