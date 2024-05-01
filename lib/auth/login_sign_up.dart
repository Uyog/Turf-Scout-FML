import 'package:flutter/material.dart';
import 'package:turf_scout/screens/login.dart';
import 'package:turf_scout/screens/sign_up.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  bool showLogin = true;

  void togglePages(){
    setState(() {
      showLogin = !showLogin;
    });
  }


@override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(onTap: togglePages);
    }
    else {
      return SignUp(onTap: togglePages,);
      }
    
  }
}