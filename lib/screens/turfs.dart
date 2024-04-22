import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TurfsPage extends StatefulWidget {
  const TurfsPage({super.key});

  @override
  State<TurfsPage> createState() => _TurfsPageState();
}

class _TurfsPageState extends State<TurfsPage> {
  
  Future<http.Response> createTurf(Map<String, dynamic> data) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/turfs'),
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  

  return response;
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0xff121212),
        title: const Text('Bookings', style: TextStyle(color: Color(0xff97FB57), fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body:  SingleChildScrollView( 
        scrollDirection: Axis.vertical,
        child: Column( 
          children: [
            Card(
              child: Column(
                children: [
                  Image.asset('assets/images/Football Icon1.png'),
                  const Text('Freedom Heights', style: TextStyle(fontWeight: FontWeight.bold),)
                  
                ],
              ),
            ),
             Card(
              child: Column(
                children: [
                  Image.asset('assets/images/Football Icon1.png', ),
                  const Text('Freedom Heights', style: TextStyle(fontWeight: FontWeight.bold),)
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}