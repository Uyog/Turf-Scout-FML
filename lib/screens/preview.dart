import 'dart:io';
import 'package:flutter/material.dart';


class PreviewPage extends StatelessWidget {
  final String turfName;
  final String location;
  final String description;
  final String price;
  final File? image;

  const PreviewPage({
    super.key,
    required this.turfName,
    required this.location,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Preview",
          style: TextStyle(color: Color(0xff97FB57), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff121212),
        iconTheme: const IconThemeData(color: Color(0xff97FB57)),
      ),
      backgroundColor: const Color(0xff121212),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Preview Turf',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xff97FB57),
              ),
            ),
            const SizedBox(height: 20),
            _buildPreviewCard(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to display notification here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Turf created successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
                // Navigate to view turf page
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewTurfPage()));
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildPreviewCard() {
    return Card(
      color: Colors.grey[800],
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Turf Name: $turfName',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Location: $location',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Description: $description',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: $price',
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 10),
            if (image != null) Image.file(image!), // Display selected image
          ],
        ),
    ));
  }
}