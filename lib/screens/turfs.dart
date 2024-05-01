import 'package:flutter/material.dart';
import 'package:turf_scout/components/button.dart';
import 'package:turf_scout/screens/booking.dart';

class TurfsPage extends StatefulWidget {
  final String turfName;
  final String turfLocation;
  final String turfImage;
  final String turfDescription;
  final String amenities;
  final String availability;
  final String? turfId;
  

  const TurfsPage({
    super.key,
    required this.turfName,
    required this.turfLocation,
    required this.turfImage,
    required this.turfDescription,
    required this.amenities,
    required this.availability,
    required this.turfId,
  });

  @override
  State<TurfsPage> createState() => _TurfsPageState();
}

class _TurfsPageState extends State<TurfsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        title: Text(
          widget.turfName,
          style: const TextStyle(
              color: Color(0xff97FB57), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xff121212),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xff97FB57)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'http://127.0.0.1:8000/storage/${widget.turfImage}',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              widget.turfName,
              style: const TextStyle(fontSize: 24, color: Color(0xff97FB57)),
            ),
            Text(
              widget.turfLocation,
              style: const TextStyle(fontSize: 18, color: Color(0xff97FB57)),
            ),
            Text(
              widget.availability,
              style: const TextStyle(fontSize: 18, color: Color(0xff97FB57)),
            ),
            const Text('ksh 2500',style: TextStyle(fontSize: 16, color: Color(0xff97FB57))),
            const SizedBox(height: 16),
            Text(
              widget.turfDescription,
              style: const TextStyle(fontSize: 16, color: Color(0xff97FB57)),
            ),
            Text(
              widget.amenities,
              style: const TextStyle(fontSize: 16),
            ),
            MyButton(
              text: 'Book',
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      backgroundColor: Color(0xff121212),
                      title: Text(
                        'Book Turf',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff97FB57),
                            fontWeight: FontWeight.bold),
                      ),
                      content: BookingPage(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
