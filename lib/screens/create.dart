import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:turf_scout/components/button.dart';

class CreatePage extends StatefulWidget {
  final String userRole;
  const CreatePage({super.key, required this.userRole});

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final _storage = const FlutterSecureStorage();

  Future<String?> _retrieveToken() async {
    return await _storage.read(key: 'token');
  }

  void _createTurf() async {
    final token = await _retrieveToken();
    if (token == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Lottie.asset('assets/images/Failed.json',
                height: 100, width: 100),
            content: const Text('Unauthorized!',
                style: TextStyle(color: Color(0xff97FB57))),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK',
                    style: TextStyle(color: Color(0xff97FB57))),
              ),
            ],
          );
        },
      );
      return;
    }

    String url = 'http://127.0.0.1:8000/api/turf';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include JWT token in the header
    };

    Map<String, dynamic> body = {
      'name': _nameController.text,
      'location': _locationController.text,
      'description': _descriptionController.text,
      'price': _priceController.text,
      // Add other fields if needed
    };

    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Lottie.asset('assets/images/Tick.json',
                  height: 100, width: 100),
              content: const Text('Turf Created Succesfully!',
                  style: TextStyle(color: Color(0xff97FB57))),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/collection');
                  },
                  child: const Text('OK',
                      style: TextStyle(color: Color(0xff97FB57))),
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
              title: Lottie.asset('assets/images/Failed.json',
                  height: 100, width: 100),
              content: const Text(
                  'Failed to create turf! Please try again later.',
                  style: TextStyle(color: Color(0xff97FB57))),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK',
                      style: TextStyle(color: Color(0xff97FB57))),
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
            backgroundColor: Colors.black,
            title: Lottie.asset('assets/images/Failed.json',
                height: 100, width: 100),
            content: const Text(
                'An unexpected error occurred! Please try again later.',
                style: TextStyle(color: Color(0xff97FB57))),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK',
                    style: TextStyle(color: Color(0xff97FB57))),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        title: const Text('Create Turf'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                cursorErrorColor: const Color(0xff97FB57),
                style: const TextStyle(color: Color(0xff97FB57)),
                cursorColor: const Color(0xff97FB57),
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                cursorErrorColor: const Color(0xff97FB57),
                style: const TextStyle(color: Color(0xff97FB57)),
                cursorColor: const Color(0xff97FB57),
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              TextFormField(
                cursorErrorColor: const Color(0xff97FB57),
                style: const TextStyle(color: Color(0xff97FB57)),
                cursorColor: const Color(0xff97FB57),
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                cursorErrorColor: const Color(0xff97FB57),
                style: const TextStyle(color: Color(0xff97FB57)),
                cursorColor: const Color(0xff97FB57),
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              MyButton(
                  text: 'Create Turf',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _createTurf();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
