import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';

import 'package:turf_scout/screens/turfs.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';
  TextEditingController searchController = TextEditingController();

  Future<List<dynamic>> searchTurfs(String search) async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/turfs/search?search=$search'));

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
        title: const Text(
          'Turfs',
          style: TextStyle(color: Color(0xff97FB57), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff121212),
        iconTheme: const IconThemeData(color: Color(0xff97FB57)),
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
                  borderSide:
                      const BorderSide(color: Color(0xff97FB57), width: 2.0),
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
                            return GestureDetector(
                              onTap: () {
                                final selectedTurf = snapshot.data![index];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TurfsPage(
                                      turfName: 
                                          selectedTurf['name'],
                                      turfLocation: 
                                          selectedTurf['location'],
                                      //turfImage: 
                                         // selectedTurf['description'],
                                      turfDescription:
                                          selectedTurf['image_url'],
                                      turfId: 
                                          selectedTurf['id'].toString(),
                                     
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  turf['name'],
                                  style: const TextStyle(
                                    color: Color(0xff97FB57),
                                  ),
                                ),
                                subtitle: Text(
                                  turf['location'],
                                  style: const TextStyle(
                                    color: Color(0xff97FB57),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(color: Color(0xff97FB57)),
                        );
                      } else {
                        return  Center(
                          child:Lottie.asset(
                    'assets/images/Loadingball.json',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                        ));
                      }
                    },
                  )
                : Center(
                    child: Lottie.asset(
                    'assets/images/Search.json',
                    width: 500,
                    height: 500,
                    fit: BoxFit.contain,
                  )),
          ),
        ],
      ),
    );
  }
}
