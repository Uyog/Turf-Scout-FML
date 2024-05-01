import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:turf_scout/auth/login_sign_up.dart';
import 'package:turf_scout/components/button.dart';
import 'package:turf_scout/components/text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:turf_scout/screens/forgot_password.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:turf_scout/screens/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  const Login({
    super.key,
    required this.onTap,
  });

  final storage = const FlutterSecureStorage();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final String email = emailcontroller.text;
    final String password = passwordcontroller.text;

    final response = await loginUser(email, password);

    // Hide the progress indicator
    Navigator.of(context).pop();

    if (response.statusCode == 201) {
      // Registration successful
      final responseData = jsonDecode(response.body);
      final token = responseData['token'];
      final user_id = responseData['id'];

      // Store the token securely
      await widget.storage.write(key: 'token', value: token);
      await widget.storage.write(key: 'user_id', value: user_id);

      print('Token stored securely');

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xff121212),
          title: Lottie.asset('assets/images/Tick.json', height: 100, width: 100),
          content: const Text(
            'Logged In Successfully!',
            style: TextStyle(color: Color(0xff97FB57)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xff97FB57)),
              ),
            ),
          ],
        ),
      );
    } else {
      // Registration failed
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title:Lottie.asset('assets/images/Failed.json', height: 100, width: 100),
          content: Text('Error: ${response.body}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginOrSignUp()),
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xff97FB57)),
              ),
            ),
          ],
        ),
      );
    }
  }

  Future<http.Response> loginUser(
    String email,
    String password,
  ) async {
    const String apiUrl =
        'http://127.0.0.1:8000/api/login'; 

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Center(
                  child: Column(
                    children: [
                      const Text(
                        "Welcome to TurfScout",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff97FB57)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          hintText: "Email",
                          labeltext: 'Email',
                          obscureText: false,
                          controller: emailcontroller,
                          prefixIcon: const Icon(Icons.email),
                          suffixIcon: null),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        hintText: 'Password',
                        labeltext: "Password",
                        obscureText: _isHidden,
                        controller: passwordcontroller,
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(_isHidden
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyButton(text: "Login", onTap: login),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(color: Color(0xff97FB57)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color(0xff97FB57),
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Forgot Password?',
                                style: const TextStyle(
                                  color: Color(0xff97FB57),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                const ForgotPassword()));
                                  }),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 160,
                      ),
                      RichText(
                        text: const TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: '© Terms and Conditions',
                                style: TextStyle(
                                  color: Color(0xff97FB57),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
