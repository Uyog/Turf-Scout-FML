import 'package:flutter/material.dart';
import 'package:turf_scout/screens/home_page.dart';
import 'package:turf_scout/screens/login.dart';
import 'package:turf_scout/screens/sign_up.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: SignUp(onTap: (){}),
      routes: {
            '/home': (context) => const HomePage(),
          },
    );
  }
}
