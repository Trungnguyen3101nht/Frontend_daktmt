import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend_daktmt/extensions/string_extensions.dart';

import '../../apis/apis.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController_1 = TextEditingController();
  final TextEditingController _passwordController_2 = TextEditingController();
  final TextEditingController _aiouser = TextEditingController();
  final TextEditingController _aiokey = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();

  bool _isVerificationCodeVisible = false;
  bool _passwordVisible = false;

  String? _errorMessage;

  // Timer-related variables
  Timer? _timer;
  int _start = 60;
  bool _isTimerActive = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _isTimerActive = true;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _timer?.cancel();
          _isTimerActive = false;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  Future<void> _handleOnClick(BuildContext context) async {
    bool isSuccess = await fetchConfirmcode(
      _emailController.text,
      _code.text,
    );

    if (isSuccess) {
      isSuccess = await fetchRegister(_username, _emailController,
          _passwordController_1, _aiouser, _aiokey, _phone, context);

      if (!isSuccess) {
        setState(() {
          _errorMessage = "Đã xảy ra lỗi khi đăng ký. Vui lòng thử lại.";
        });
      }
    } else {
      setState(() {
        _errorMessage = "Mã xác thực không đúng";
      });
    }
  }

  void _handleSignInClick(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/signin');
  }

  void _handleForgotPasswordClick(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/forget-password');
  }

  Future<void> _sendcode() async {
    if (_emailController.toString().isEmpty) {
      _errorMessage = "Vui lòng điền email";
    }
    bool isSuccess = await fetchSendcode(_emailController.text);
    if (isSuccess) {
      setState(() {
        _isVerificationCodeVisible = true;
        _errorMessage = null;
      });
    } else {
      setState(() {
        _errorMessage = 'Đã xảy ra lỗi khi gửi mã xác thực';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffB81736), Color(0xff281537)],
              ),
            ),
            padding: const EdgeInsets.only(top: 60.0, left: 22),
            alignment: Alignment.topLeft,
            child: const Text(
              'Hello\nRegister!',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (!_isVerificationCodeVisible) ...[
                    // Username Field
                    _buildTextField(controller: _username, label: 'Username'),
                    // Email Field with validation icon
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
                            color: Color(0xffB81736),
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    // Password Field
                    _buildPasswordField(
                      controller: _passwordController_1,
                      label: 'Password',
                    ),
                    // Confirm Password Field
                    _buildPasswordField(
                      controller: _passwordController_2,
                      label: 'Confirm Password',
                    ),
                    _buildTextField(
                        controller: _aiouser, label: 'AIO Username'),
                    _buildTextField(controller: _aiokey, label: 'AIO Key'),
                    _buildTextField(controller: _phone, label: 'Phone number'),
                    const SizedBox(height: 20),
                    _buildSignUpButton_1(context),
                  ],
                  if (_isVerificationCodeVisible) ...[
                    const Text(
                      'Enter the verification code sent to your email',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xffB81736)),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _code,
                            decoration: const InputDecoration(
                              label: Text(
                                'Verification Code',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB81736),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        if (_isTimerActive)
                          Text(
                            '$_start',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 16),
                          )
                        else
                          ElevatedButton(
                            onPressed: () {
                              startTimer();
                              _sendcode();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffB81736),
                                    Color(0xff281537)
                                  ],
                                ),
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.center,
                                height: 40,
                                child: const Text(
                                  'Send',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildSignUpButton_2(context),
                  ],
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => _handleSignInClick(context),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xff281537),
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
                            color: Color(0xff281537),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpButton_1(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
        onPressed: () async {
          if (_username.text.isEmpty ||
              _emailController.text.isEmpty ||
              _passwordController_1.text.isEmpty ||
              _aiouser.text.isEmpty ||
              _aiokey.text.isEmpty ||
              _phone.text.isEmpty) {
            setState(() {
              _errorMessage = 'Vui lòng nhập đủ thông tin';
            });
            return;
          }

          if (!_emailController.text.isValidEmail()) {
            setState(() {
              _errorMessage = 'Email không đúng định dạng';
            });
            return;
          }

          if (_passwordController_1.text != _passwordController_2.text) {
            setState(() {
              _errorMessage = 'Mật khẩu không khớp';
            });
            return;
          }
          _sendcode();
        },
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: const LinearGradient(
              colors: [Color(0xffB81736), Color(0xff281537)],
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton_2(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
              colors: [Color(0xffB81736), Color(0xff281537)],
            ),
          ),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Confirm Sign Up',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffB81736),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        label: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xffB81736),
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xffB81736),
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
}