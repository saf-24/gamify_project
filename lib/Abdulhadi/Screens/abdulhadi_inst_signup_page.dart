// ignore_for_file: prefer_const_constructors, sort_child_properties_last
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_inst_HP.dart';
import 'package:gamify_project/Safwan/Screens/safwan_institusoin_logn_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const instisignup(),
    );
  }
}

class instisignup extends StatefulWidget {
  const instisignup({super.key});

  @override
  State<instisignup> createState() => _instisignupState();
}

class _instisignupState extends State<instisignup> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController institutionNameController =
      TextEditingController();

  Future<void> signUp() async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Save user data to Firestore
      await FirebaseFirestore.instance.collection('Signup').add({
        'full_name': fullNameController.text,
        'email': emailController.text,
        'institution_name': institutionNameController.text,
      });

      // Navigate to home page or show success
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => InstHomePage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      // Handle errors
      print("Error: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 115,
            child: Container(
              child: Text(
                "Gamify",
                style: TextStyle(
                    fontSize: 47,
                    color: const Color.fromARGB(255, 54, 127, 156),
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            bottom: -59,
            right: -51,
            child: Image.asset(
              "assets/img/login_bachground1.png",
              scale: 0.75,
            ),
          ),
          Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 11),
                child: Container(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 30,
                        right: 27,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => instisignup()));
                            },
                            child: Text("Sign up",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: const Color.fromARGB(
                                        255, 190, 228, 253),
                                    fontWeight: FontWeight.w900)),
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(197, 0, 129, 189),
                                ),
                                padding: WidgetStateProperty.all(
                                    EdgeInsets.fromLTRB(24, 11, 24, 12)),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28))))),
                      ),
                      Positioned(
                        top: 30,
                        left: 33,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => In_login_page()));
                            },
                            child: Text("Login",
                                style: TextStyle(
                                    fontSize: 22,
                                    color:
                                        const Color.fromARGB(255, 27, 111, 167),
                                    fontWeight: FontWeight.w900)),
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(244, 255, 255, 255),
                                ),
                                padding: WidgetStateProperty.all(
                                    EdgeInsets.fromLTRB(35, 12, 35, 12)),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28))))),
                      ),
                      Positioned(
                        top: 125,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              controller: fullNameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Full name *",
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 200,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Institution Email Address *",
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 274,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password *",
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 347,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 64, 157, 194),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              controller: institutionNameController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Institution name *",
                                  hintStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 33, 123, 165)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 435,
                        left: 80,
                        child: ElevatedButton(
                            onPressed: signUp,
                            child: Text("Sign up",
                                style: TextStyle(
                                    fontSize: 27,
                                    color: const Color.fromARGB(
                                        255, 212, 238, 255),
                                    fontWeight: FontWeight.w900)),
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  const Color.fromARGB(197, 0, 129, 189),
                                ),
                                padding: WidgetStateProperty.all(
                                    EdgeInsets.fromLTRB(40, 10, 40, 10)),
                                shape: WidgetStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(28))))),
                      ),
                    ],
                  ),
                  width: 360,
                  height: 550,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(40),
                      ),
                      color: const Color.fromARGB(153, 231, 231, 231),
                      border: Border.all(
                          color: const Color.fromARGB(94, 161, 161, 161),
                          width: 3)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
