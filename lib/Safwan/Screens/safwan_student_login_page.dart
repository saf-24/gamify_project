import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const Stloginpage(),
    );
  }
}

class Stloginpage extends StatelessWidget {
  const Stloginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
  
      actions: <Widget>[
      IconButton(
      icon: const Icon(
        Icons.settings,
        size: 35.4,
        color: Color.fromARGB(197, 0, 129, 189),
      ),
        onPressed: () {},
    )
  ],
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        
      ),
      body: 
         Stack(
           children: [
            Positioned(
              bottom: -59,
              right: -42,
            child:
             Image.asset("assets/img/login_bachground1.png",scale: 0.75,),
             ),
             Center(
               child: Container(
                width: 360,
                height:444 ,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(50),
                   color: const Color.fromARGB(179, 255, 255, 255)
                 )
                ),
             ),
           ],
         ),
      
    );
  }
}