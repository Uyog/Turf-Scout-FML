import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CreatePage extends StatefulWidget {
  final String userRole;
  const CreatePage({Key? key, required this.userRole}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final _storage = FlutterSecureStorage();

  Future<String?> _retrieveToken() async {
    return await _storage.read(key: 'token');
  }

  void _createTurf() async {
    final token = await _retrieveToken();
    if (token == null) {
      // Token not found, handle unauthorized access
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
      final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
      if (response.statusCode == 201) {
        // Turf created successfully
        print('Turf created: ${response.body}');
        // You can navigate to another page or show a success message
      } else {
        // Error creating turf
        print('Error creating turf: ${response.statusCode}');
        // Handle error, show error message to the user
      }
    } catch (e) {
      print('Error creating turf: $e');
      // Handle error, show error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Turf'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _createTurf();
                  }
                },
                child: Text('Create Turf'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
