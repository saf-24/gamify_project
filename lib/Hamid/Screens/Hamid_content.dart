import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gamify'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu), // أيقونة القوائم
          onPressed: () {
            // يمكنك إضافة الإجراء هنا (فتح درج أو قائمة جانبية)
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // أيقونة الإشعارات
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/diagram.png', // ضع مسار الصورة هنا
                        fit: BoxFit.cover,
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
                    child: Text(
                      'Test',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white.withOpacity(0.7),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.home, size: 40.0),
                        color: Color.fromARGB(197, 0, 129, 189),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/st_home');
                        },
                      ),
                      const Text(
                        "Home",
                        style: TextStyle(height: 0.1),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu_book_rounded, size: 40.0),
                        color: Color.fromARGB(197, 0, 129, 189),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/st_course');
                        },
                      ),
                      const Text(
                        "Courses",
                        style: TextStyle(
                          height: 0.1,
                          color: Color.fromARGB(197, 0, 129, 189),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.videogame_asset, size: 41),
                        color: Color.fromARGB(197, 0, 129, 189),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/st_games_list');
                        },
                      ),
                      const Text(
                        "Games",
                        style: TextStyle(height: 0.1),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.person, size: 43),
                        color: Color.fromARGB(197, 0, 129, 189),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/st_account');
                        },
                      ),
                      const Text(
                        "Account",
                        style: TextStyle(height: 0.1),
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
