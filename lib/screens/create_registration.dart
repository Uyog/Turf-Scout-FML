import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:turf_scout/components/drawer2.dart';

class CreatorRegistrationPage extends StatefulWidget {
  

  const CreatorRegistrationPage({
    super.key,});

  @override
  State<CreatorRegistrationPage> createState() => _CreatorRegistrationPageState();
  
}

class _CreatorRegistrationPageState extends State<CreatorRegistrationPage> {
  late String userName; // Declare userName variable

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve userName from arguments
    userName = ModalRoute.of(context)!.settings.arguments as String;
  }
 
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        title: const Text(
          "TurfScout",
          style: TextStyle(color: Color(0xff97FB57), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff121212),
        iconTheme: const IconThemeData(color: Color(0xff97FB57)),
      ),
      drawer: const MyDrawer2(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: Colors.black,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Lottie.asset(
                            'assets/images/Creator.json',
                            key: UniqueKey(),
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100
                          ),
                  const SizedBox(width: 20),
                 
                          Expanded(
                    child: Text(
                      'Welcome $userName',
                      style: const TextStyle(
                        color: Color(0xff97FB57),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
