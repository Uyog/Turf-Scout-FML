import 'package:flutter/material.dart';


class Stack extends StatefulWidget {
  final String? turfId;

  const Stack({super.key, required this.turfId, required List<Widget> children});

  @override
  State<Stack> createState() => _StackState();
}

class _StackState extends State<Stack> {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Stack(
                turfId: '',
                children: [
                  Image.asset('assets/images/football1.jpg'),
                  const Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'Welcome to TurfScout!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}