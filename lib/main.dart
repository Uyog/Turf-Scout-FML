import 'package:flutter/material.dart';
import 'package:turf_scout/auth/login_sign_up.dart';
import 'package:turf_scout/screens/booking.dart';
import 'package:turf_scout/screens/create.dart';
import 'package:turf_scout/screens/create_registration.dart';
import 'package:turf_scout/screens/home_page.dart';
import 'package:turf_scout/screens/intro.dart';
import 'package:turf_scout/screens/payment.dart';
import 'package:turf_scout/screens/profile.dart';
import 'package:turf_scout/screens/turfs.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff97FB57),
        ),
        useMaterial3: true,
      ),
      home:  const Intro(),
      routes: {
        '/loginOrSignUp': (context) => const LoginOrSignUp(),
        '/home': (context) => const HomePage(),
        '/book': (context) => const TurfsPage(
              turfName: '',
              turfLocation: '',
              turfImage: '',
              turfDescription: '',
              amenities: '',
              availability: '',
              turfId: '',
              
            ),
        '/profile': (context) => const ProfilePage(),
        '/createturf':(context) => const CreatorRegistrationPage(),
        '/create': (context) => const CreatePage(),
        '/bookings': (context) => const BookingPage(),
        '/payment': (context) => const PaymentPage(),
      },
    );
  }
}
