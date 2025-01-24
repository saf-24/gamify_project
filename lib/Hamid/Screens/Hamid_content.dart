import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gamify'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        '', // إزالة النص
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 27, 111, 167),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.play_circle_fill,
                        size: 30, color: Color.fromARGB(255, 27, 111, 167)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Slider(
                        value: 5,
                        onChanged: (value) {},
                        min: 0,
                        max: 10,
                        activeColor: Color.fromARGB(255, 27, 111, 167),
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Text(
                      '10:00',
                      style:
                          TextStyle(color: Color.fromARGB(255, 27, 111, 167)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Java is a versatile, object-oriented programming language used for building cross-platform applications. It features strong memory management, security, and a rich set of libraries for various tasks. Java is widely adopted in web, mobile (Android), and enterprise-level applications.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 27, 111, 167),
                    ),
                    onPressed: () {},
                    child: Text('Test'),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white.withOpacity(0.7), // لون شفاف
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home,
                          color: Color.fromARGB(255, 27, 111, 167)),
                      SizedBox(height: 5),
                      Text(
                        'Home',
                        style:
                            TextStyle(color: Color.fromARGB(255, 27, 111, 167)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.book,
                          color: Color.fromARGB(255, 27, 111, 167)),
                      SizedBox(height: 5),
                      Text(
                        'Courses',
                        style:
                            TextStyle(color: Color.fromARGB(255, 27, 111, 167)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.games,
                          color: Color.fromARGB(255, 27, 111, 167)),
                      SizedBox(height: 5),
                      Text(
                        'Games',
                        style:
                            TextStyle(color: Color.fromARGB(255, 27, 111, 167)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_circle,
                          color: Color.fromARGB(255, 27, 111, 167)),
                      SizedBox(height: 5),
                      Text(
                        'Account',
                        style:
                            TextStyle(color: Color.fromARGB(255, 27, 111, 167)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TestPage(),
    debugShowCheckedModeBanner: false,
  ));
}
