import 'package:flutter/material.dart';
import 'package:turf_scout/auth/login_sign_up.dart';
import 'package:turf_scout/screens/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const  Color(0xff97FB57),),
        useMaterial3: true,
      ),
      home: const LoginOrSignUp(),
      routes: {
            '/home': (context) => const HomePage(),
          },
    );
  }
}

