import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:turf_scout/components/drawer.dart';
import 'package:turf_scout/screens/search_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

        //AppBar
        appBar: AppBar(
          title: const Text(
            "TurfScout",
            style: TextStyle(
                color: Color(0xff97FB57), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff121212),
          iconTheme: const IconThemeData(color: Color(0xff97FB57)),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const SearchPage(),
                      ));
                },
                icon: const Icon(Icons.search))
          ],
        ),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
             Card(
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Categories",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff97FB57),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                  ),
                  items: [
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Card(
                        color: Colors.black,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Center(
                                    child: Image.asset(
                                  'assets/images/Footballer2.png',
                                  color: const Color(0xff97FB57),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Card(
                        color: Colors.black,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Center(
                                    child: Image.asset(
                                        'assets/images/Footballer1.png',
                                        color: const Color(0xff97FB57))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Card(
                        color: Colors.black,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Center(
                                  child: Image.asset(
                                    'assets/images/GoalKeeper.png',
                                    color: const Color(0xff97FB57),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
       
     
        );
  }
}
