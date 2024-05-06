import 'package:flutter/material.dart';

class CreatorRegistrationPage extends StatefulWidget {
  const CreatorRegistrationPage({super.key});

  @override
  State<CreatorRegistrationPage> createState() => _CreatorRegistrationPageState();
}

class _CreatorRegistrationPageState extends State<CreatorRegistrationPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('Become a Creator'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call API to update user role to creator
            // Redirect user to dashboard or home page after successful registration
          },
          child: Text('Become a Creator'),
        ),
      ),
    );
  }
}