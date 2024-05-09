import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Turf {
  final String id;
  final String name;
  final String location;
  final String description;
  final double price;
  final String creatorId;

  Turf({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.creatorId,
  });
}

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<Turf> userTurfs = [];
  final _storage = const FlutterSecureStorage();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUserTurfs();
  }

  Future<String?> _retrieveToken() async {
    return await _storage.read(key: 'token');
  }

  Future<void> _fetchUserTurfs() async {
    setState(() {
      _isLoading = true;
    });
    final token = await _retrieveToken();
    if (token == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Token not found. Please login again.';
      });
      return;
    }

    String url = 'http://127.0.0.1:8000/api/turf';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include JWT token in the header
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          userTurfs = responseData.map((turf) => Turf(
            id: turf['id'].toString(),
            name: turf['name'],
            location: turf['location'],
            description: turf['description'],
            price: double.parse(turf['price'].toString()),
            creatorId: turf['creator_id'].toString(),
          )).toList();
        });
      } else {
         setState(() {
          _isLoading = false;
          _errorMessage = 'Error: ${response.statusCode}. Unable to fetch user turfs.';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error: $e. Unable to fetch user turfs.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        title: const Text('Your Turfs'),
      ),
      body: userTurfs.isEmpty
          ? const Center(
              child: Text('No turfs created'),
            )
      : ListView.builder(
        itemCount: userTurfs.length,
        itemBuilder: (context, index) {
          final turf = userTurfs[index];
          return ListTile(
            title: Text(turf.name),
            subtitle: Text(turf.description),
            trailing: Text('\$${turf.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}