import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:turf_scout/auth/login_sign_up.dart';
import 'package:http/http.dart' as http;


class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final storage = const FlutterSecureStorage();

  Future<void> logout() async {
    // Get the token from secure storage
    final token = await storage.read(key: 'token');

    // Revoke the token from the backend
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // Include the token in the Authorization header
      },
    );

    if (response.statusCode == 200) {
      // Token revoked successfully
      //print('Token revoked');

      // Remove the token from secure storage
      await storage.delete(key: 'token');
      //print('Token removed from secure storage');

      // Navigate to the login screen
    
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  const LoginOrSignUp()),
      );
    } else {
      // Handle error
      //print('Failed to revoke token: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff121212),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              
            ],
          ),

           ListTile(
            leading: const Icon(Icons.person),
            title:  const Text('P R O F I L E', 
            style: TextStyle(
              color: Color(0xff97FB57),
              fontWeight: FontWeight.w500,
              ),),
              iconColor: const Color(0xff97FB57),
              onTap: (){
                Navigator.pushNamed(context, '/profile');
              },


          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                "L O G O U T",
                style: TextStyle(
                  color:  Color(0xff97FB57),
                  fontWeight: FontWeight.w500,
                ),
              ),
              iconColor: const Color(0xff97FB57),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
