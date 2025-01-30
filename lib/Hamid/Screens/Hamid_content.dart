import 'package:flutter/material.dart';
import 'package:gamify_project/zayed/Screens/zayed_courses_page.dart';

void main() {
  runApp(MaterialApp(
    home: ContentPage(),
    debugShowCheckedModeBanner: false,
  ));
}
class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
    appBar: AppBar(
      toolbarHeight: 65,
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
                size: 39.4, color: Color.fromARGB(197, 0, 129, 189),),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContentPage()),
                );
            },
          ),
        ],
        leading: IconButton(
          tooltip: "Menu",
          icon: const Icon(Icons.menu,
              size: 43.4, color: Color.fromARGB(197, 0, 129, 189),),
          onPressed: () {
            
          },
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: 
        
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('java programing 2',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),),
                  SizedBox(height: 20),
                  
                  SizedBox(height: 20),
                  Text(
                    'Java is a versatile, object-oriented programming language used for building cross-platform applications.\n\nIt features strong memory management, security, and a rich set of libraries for various tasks. Java is widely adopted in web, mobile (Android), and enterprise-level applicationsJava is a versatile, object-oriented programming language used for building cross-platform applications. It features strong memory management, security, and a rich set of libraries for various tasks. Java is widely adopted in web, mobile (Android), and enterprise-level applications.',
                    style: TextStyle(fontSize: 22),
                    
                  ),
                  SizedBox(height: 40),
                  Center(
                  child: SizedBox(
                    height: 53,
                    width: 160,
                    child: ElevatedButton(
                      
                      style: ElevatedButton.styleFrom(
                        
                    
                        backgroundColor: Color.fromARGB(255, 65, 153, 255),
                      ),
                      onPressed: () {
                        Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Zayed_standard_navigations()));
                      },
                      child: Text('Next',style: TextStyle(fontSize: 26,color: Colors.white),),
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
          
        
      
    );
  }
}


