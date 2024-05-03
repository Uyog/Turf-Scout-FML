import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:turf_scout/auth/login_sign_up.dart';
import 'package:turf_scout/components/button.dart';
import 'package:turf_scout/components/text_field.dart';
import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/forgot-password'),
        body: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xff121212),
              title: Lottie.asset('assets/images/Tick.json',
                  height: 100, width: 100),
              content: const Text(
                'Password reset link sent successfully',
                style: TextStyle(color: Color(0xff97FB57)),
              ),
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
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: const Color(0xff121212),
              title: Lottie.asset('assets/images/Failed.json',
                  height: 100, width: 100),
              content: const Text('Failed to send password reset link'),
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
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xff121212),
            title: Lottie.asset('assets/images/Failed.json',
                height: 100, width: 100),
            content: const Text('Something Went Wrong'),
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
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        title: const Text(
          'Forgot Password',
          style:
              TextStyle(color: Color(0xff97FB57), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xff97FB57)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
                hintText: 'Email',
                labeltext: 'Email',
                obscureText: false,
                controller: _emailController,
                prefixIcon: const Icon(Icons.email),
                suffixIcon: null),
            const SizedBox(height: 16.0),
            MyButton(text: 'Send', onTap: _sendPasswordResetEmail)
          ],
        ),
      ),
    );
  }
}
