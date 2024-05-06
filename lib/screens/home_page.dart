import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:turf_scout/components/drawer.dart';
import 'package:turf_scout/screens/create_registration.dart';
import 'package:turf_scout/screens/profile.dart';
import 'package:turf_scout/screens/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              Stack(
                  children: [
                    Image.asset('assets/images/football1.jpg'),
                    const Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Text(
                          'Welcome to TurfScout!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        color: const Color(0xff121212),
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
                        color: const Color(0xff121212),
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
                        color: const Color(0xff121212),
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
