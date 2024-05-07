import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:turf_scout/components/button.dart';
import 'package:turf_scout/components/text_field.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
   final TextEditingController _turfNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _availabilityController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future<void> _createOrUpdateTurf(bool isUpdate, {String? turfId}) async {
    String apiUrl = 'http://127.0.0.1:8000/api/turf';
    if (isUpdate) {
      apiUrl = 'http://127.0.0.1:8000/api/turf/$turfId';
    }
    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'turf_name': _turfNameController.text,
        'location': _locationController.text,
        'description': _descriptionController.text,
        'amenities': _amenitiesController.text,
        'price_per_hour': _priceController.text,
        'availability': _availabilityController.text,
        // Add image file as base64 string if an image is selected
        if (_image != null) 'image': base64Encode(_image!.readAsBytesSync()),
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      // Turf created or updated successfully
      final responseData = jsonDecode(response.body);
      // Do something with responseData
    } else {
      // Error handling
      print('Error: ${response.statusCode}');
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text(
            "Create",
            style: TextStyle(
                color: Color(0xff97FB57), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff121212),
          iconTheme: const IconThemeData(color: Color(0xff97FB57)),
      ),
      backgroundColor: const Color(0xff121212),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text('Begin Creating', style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff97FB57),
                  ),), 
              const SizedBox(height: 20),
              MyTextField(
                hintText: 'TurfName', 
                labeltext: 'TurfName', 
                obscureText: false, 
                controller: _turfNameController, 
                prefixIcon: const Icon(Icons.grass_rounded), 
                suffixIcon: null),

              const SizedBox(height: 10),

              MyTextField(
                hintText: 'Location', 
                labeltext: 'Location', 
                obscureText: false, 
                controller: _locationController, 
                prefixIcon: const Icon(Icons.location_on), 
                suffixIcon: null),

              const SizedBox(height: 10),
              
               MyTextField(
                hintText: 'Description', 
                labeltext: 'Description', 
                obscureText: false, 
                controller: _descriptionController, 
                prefixIcon: const Icon(Icons.description), 
                suffixIcon: null),
              const SizedBox(height: 10),
               MyTextField(
                hintText: 'Amenities', 
                labeltext: 'Amenities', 
                obscureText: false, 
                controller: _amenitiesController, 
                prefixIcon: const Icon(Icons.notes_outlined), 
                suffixIcon: null),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Price', 
                labeltext: 'Price', 
                obscureText: false, 
                controller: _priceController, 
                prefixIcon: const Icon(Icons.attach_money_rounded), 
                suffixIcon: null),
              const SizedBox(height: 10),
               MyTextField(
                hintText: 'Hours', 
                labeltext: 'Hours', 
                obscureText: false, 
                controller: _availabilityController, 
                prefixIcon: const Icon(Icons.access_time_filled_outlined), 
                suffixIcon: null),
              const SizedBox(height: 20),
              MyButton(text: 'Create', onTap:  () => _createOrUpdateTurf(false),),

              const SizedBox(height: 10),

              MyButton(text: 'Update', onTap: () => _createOrUpdateTurf(true),),
              
              const SizedBox(height: 20),

              MyButton(text: 'Image', onTap:  _getImage, ),
    
              if (_image != null) Image.file(_image!), // Display selected image
            ]
        ))));
  }
}