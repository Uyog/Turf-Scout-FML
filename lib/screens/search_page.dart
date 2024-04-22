import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  TextEditingController searchController = TextEditingController();

  Future<List<dynamic>> searchTurfs(String search) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/turfs/search?search=$search'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load turfs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        title: const Text('Search Turfs', style: TextStyle(color: Color(0xff97FB57)),),
        backgroundColor: const Color(0xff121212),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search turfs...',
                hintStyle: const TextStyle(color: Color(0xff97FB57)),
                prefixIcon: const Icon(Icons.search, color: Color(0xff97FB57)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xff97FB57)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xff97FB57), width: 2.0),
                ),
              ),
              style: const TextStyle(color: Color(0xff97FB57)),
            ),
          ),
          Expanded(
            child: query.isNotEmpty
                ? FutureBuilder<List<dynamic>>(
                    future: searchTurfs(query),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final turf = snapshot.data![index];
                            return ListTile(
                              title: Text(turf['turf_name'], style: const TextStyle(color: Color(0xff97FB57))),
                              subtitle: Text(turf['location'], style: const TextStyle(color: Color(0xff97FB57))),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}', style: const TextStyle(color: Color(0xff97FB57)));
                      } else {
                        return const Center(child: CircularProgressIndicator(color: Color(0xff97FB57)));
                      }
                    },
                  )
                : const Center(child: Text('Enter a search term to find turfs', style: TextStyle(color: Color(0xff97FB57)))),
          ),
        ],
     ),
);
}
}
