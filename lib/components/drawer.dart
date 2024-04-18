import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.person_rounded),
                  title: const Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  iconColor: Colors.black,
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/account_page');
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.black,
                         fontWeight: FontWeight.w500
                      ),
                    ),
                    iconColor: Colors.black,
                    onTap: () {
                      Navigator.pop(context);

                      Navigator.pushNamed(context, '/account_page');
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.black,
                         fontWeight: FontWeight.w500
                      ),
                    ),
                    iconColor: Colors.black,
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),
            ],
          ),
         const Padding(
            padding:  EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading:  Icon(Icons.logout),
              title: Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.black,
                   fontWeight: FontWeight.w500
                ),
              ),
              iconColor: Colors.black,
              
            ),
          ),
        ],
      ),
    );
  }
}
