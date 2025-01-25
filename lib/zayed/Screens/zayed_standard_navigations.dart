
import 'package:flutter/material.dart';

void main() {
  runApp(const Zayed_standard_navigations2());
}

class Zayed_standard_navigations2 extends StatelessWidget {
  const Zayed_standard_navigations2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: Scaffold(
        
      appBar: AppBar(
        title: Text(
          "Gamify",
          style: TextStyle(
              fontSize: 32,
              color: Color.fromARGB(197, 0, 129, 189),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: "notifications",
            icon: const Icon(Icons.notifications_none,
                size: 35.4, color: Color.fromARGB(197, 0, 129, 189),),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          tooltip: "Menu",
          icon: const Icon(Icons.menu,
              size: 35.4, color: Color.fromARGB(197, 0, 129, 189),),
          onPressed: () {},
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),

        // Main content of the page better be here : ////////////-----------//////////------

        

        // Custom Bottom Taskbar///////////---------------//////////-------

        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 28.0),
          height: 107,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.home, size: 40.0),
                    color: Colors.grey,
                    onPressed: () {
                    },
                  ),
                  const Text("Home", style: TextStyle(height: 0.1)),
                ],
              ),
              
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.menu_book_rounded, size: 37.0),
                    color: Color.fromARGB(197, 0, 129, 189),
                    onPressed: () {
                    },
                  ),
                  const Text("Courses", style: TextStyle(height: 0.1)),
                ],
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.videogame_asset, size: 42.5),
                    color: Colors.grey,
                    onPressed: () {
                    },
                  ),
                  const Text("Games", style: TextStyle(height: 0.1)),
                ],
              ),

              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.person, size: 38.0),
                    color: Colors.grey,
                    onPressed: () {
                    },
                  ),
                  const Text("Profile", style: TextStyle(height: 0.1)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}