import 'package:flutter/material.dart';
import 'package:frontend_daktmt/apis/apis.dart';
import 'package:frontend_daktmt/custom_card.dart';
import 'package:frontend_daktmt/extensions/string_extensions.dart';
import 'package:frontend_daktmt/responsive.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;
  String? _errorMessage;

  Future<void> _handleOnClick(BuildContext context) async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.isValidEmail()) {
      bool isSuccess =
          await fetchSignIn(_emailController, _passwordController, context);
      print('API Response: $isSuccess');
      if (!isSuccess) {
        setState(() {
          _errorMessage = 'Login failed. Please try again.';
        });
      } else {
        setState(() {
          _errorMessage = null;
        });
      }
    } else {
      print('Emails and passwords should not be left blank.');
    }
  }

  void _handleSignUpClick(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/register');
  }

  void _handleForgotPasswordClick(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/forget-password');
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final bool isRowLayout = isMobile;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: backgound_Color(),
              padding:
                  EdgeInsets.only(top: 120.0, left: isRowLayout ? 55 : 222),
              alignment: Alignment.topLeft,
              child: const Text(
                'Welcome to CaCoIot!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment:
                  Alignment.centerRight, // Đặt phần tử này ở giữa màn hình
              child: Padding(
                padding: EdgeInsets.only(
                    right: isRowLayout ? 0.0 : 100.0,
                    top: isRowLayout ? 250.0 : 50.0,
                    bottom: isRowLayout ? 0.0 : 50.0),
                child: Container(
                  width: isRowLayout ? double.infinity : 500.0,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: isRowLayout
                        ? const BorderRadius.only(
                            // Nếu isRowLayout = true
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )
                        : BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: isRowLayout ? 18.0 : 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Điều chỉnh màu nếu cần
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.check,
                            color: _emailController.text.isValidEmail()
                                ? Colors.green
                                : Colors.grey,
                          ),
                          label: const Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 25.0),
                      TextField(
                        keyboardType: TextInputType.text,
                        controller: _passwordController,
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color:
                                  _passwordVisible ? Colors.green : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          label: const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => _handleSignUpClick(context),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color.fromARGB(255, 0, 132, 255),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _handleForgotPasswordClick(context),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color.fromARGB(255, 0, 132, 255),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (_errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 150),
                      _buildSignInButton(context),
                      const SizedBox(height: 50),
                      const DividerWithText(),
                      const SizedBox(height: 30),
                      const _SignWithGG(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () => _handleOnClick(context),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 0, 110, 255),
                Color.fromARGB(255, 247, 0, 255)
              ],
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignWithGG extends StatelessWidget {
  const _SignWithGG();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Xử lý sự kiện khi nhấn vào nút
        print("Sign in with Google");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white, // Màu nền nút
        padding: const EdgeInsets.symmetric(
            horizontal: 12.0, vertical: 12.0), // Padding cho nút
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Tạo viền bo tròn cho nút
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize
            .min, // Đảm bảo hàng chỉ chiếm kích thước tối thiểu cần thiết
        children: [
          Image.asset(
            'assets/google.png', // Đường dẫn logo Google
            width: 32.0, // Chiều rộng logo
            height: 32.0, // Chiều cao logo
          ),
          const SizedBox(width: 10.0), // Khoảng cách giữa logo và text
          const Text(
            "Sign in with Google",
            style: TextStyle(
              color: Colors.black, // Màu chữ
              fontSize: 16.0, // Kích thước chữ
            ),
          ),
        ],
      ),
    );
  }
}

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            thickness: 1, // Độ dày của dòng
            color: Colors.grey, // Màu của dòng
            indent: 10.0, // Khoảng cách từ dòng đến cạnh bên trái
            endIndent: 10.0, // Khoảng cách từ dòng đến chữ "or"
          ),
        ),
        Text("or", style: TextStyle(color: Colors.grey)),
        Expanded(
          child: Divider(
            thickness: 1,
            color: Colors.grey,
            indent: 10.0,
            endIndent: 10.0,
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:frontend_daktmt/apis/apis.dart';
// import 'package:frontend_daktmt/extensions/string_extensions.dart';

// class SignIn extends StatefulWidget {
//   const SignIn({super.key});

//   @override
//   State<SignIn> createState() => _SignInState();
// }

// class _SignInState extends State<SignIn> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _passwordVisible = false;
//   String? _errorMessage;

//   Future<void> _handleOnClick(BuildContext context) async {
//     if (_emailController.text.isNotEmpty &&
//         _passwordController.text.isNotEmpty &&
//         _emailController.text.isValidEmail()) {
//       bool isSuccess =
//           await fetchSignIn(_emailController, _passwordController, context);
//       if (!isSuccess) {
//         setState(() {
//           _errorMessage = 'Đăng nhập không thành công. Vui lòng thử lại.';
//         });
//       } else {
//         setState(() {
//           _errorMessage = null;
//         });
//       }
//     } else {
//       print('Email và mật khẩu không được để trống.');
//     }
//   }

//   void _handleSignUpClick(BuildContext context) {
//     Navigator.pushReplacementNamed(context, '/register');
//   }

//   void _handleForgotPasswordClick(BuildContext context) {
//     Navigator.pushReplacementNamed(context, '/forget-password');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xffB81736), Color(0xff281537)],
//               ),
//             ),
//             padding: const EdgeInsets.only(top: 60.0, left: 22),
//             alignment: Alignment.topLeft,
//             child: const Text(
//               'Hello\nSign in!',
//               style: TextStyle(
//                 fontSize: 30,
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 200.0),
//             child: Container(
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//                 color: Colors.white,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 18),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       suffixIcon: Icon(
//                         Icons.check,
//                         color: _emailController.text.isValidEmail()
//                             ? Colors.green
//                             : Colors.grey,
//                       ),
//                       label: const Text(
//                         'Email',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xffB81736),
//                         ),
//                       ),
//                     ),
//                     onChanged: (value) {
//                       setState(() {});
//                     },
//                   ),
//                   // Error message display
//                   if (_errorMessage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Text(
//                         _errorMessage!,
//                         style: const TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   TextField(
//                     keyboardType: TextInputType.text,
//                     controller: _passwordController,
//                     obscureText: !_passwordVisible,
//                     decoration: InputDecoration(
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _passwordVisible
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: _passwordVisible ? Colors.green : Colors.grey,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _passwordVisible = !_passwordVisible;
//                           });
//                         },
//                       ),
//                       label: const Text(
//                         'Password',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xffB81736),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () => _handleSignUpClick(context),
//                         child: const Text(
//                           'Sign up',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                             color: Color(0xff281537),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () => _handleForgotPasswordClick(context),
//                         child: const Text(
//                           'Forgot Password?',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                             color: Color(0xff281537),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 70),
//                   _buildSignInButton(context),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSignInButton(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 55,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           padding: EdgeInsets.zero,
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//         ),
//         onPressed: () => _handleOnClick(context),
//         child: Ink(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(30),
//             gradient: const LinearGradient(
//               colors: [Color(0xffB81736), Color(0xff281537)],
//             ),
//           ),
//           child: Container(
//             alignment: Alignment.center,
//             child: const Text(
//               'Sign In',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
