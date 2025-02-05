// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_inst_signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_inst_HP.dart';

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
      home: const In_login_page(),
    );
  }
}

class In_login_page extends StatefulWidget {
  const In_login_page({super.key});

  @override
  State<In_login_page> createState() => _In_login_pageState();
}

class _In_login_pageState extends State<In_login_page> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> ischecked = ValueNotifier(false);

  Future<void> signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => InstHomePage()),
        (Route<dynamic> route) => false,
      );

    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        default:
          errorMessage = 'Login failed: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred'),
          backgroundColor: Colors.red,
        ),
      );
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
            top: 30,
            left: 135,
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
                        top: 28,
                        right: 27,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => instisignup()));
                          },
                          child: Text("Sign up",
                              style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      const Color.fromARGB(255, 27, 111, 167),
                                  fontWeight: FontWeight.w900)),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(225, 255, 255, 255),
                              ),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.fromLTRB(24, 12, 24, 12)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28)))),
                        ),
                      ),
                      Positioned(
                        top: 28,
                        left: 33,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      const Color.fromARGB(255, 190, 228, 253),
                                  fontWeight: FontWeight.w900)),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(197, 0, 129, 189),
                              ),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.fromLTRB(35, 12, 35, 12)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28)))),
                        ),
                      ),
                      SizedBox(
                        height: 44,
                      ),
                      Positioned(
                        top: 119,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 54, 127, 156),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Institution Email",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 54, 127, 156)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      Positioned(
                        top: 191,
                        left: 28,
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                color: const Color.fromARGB(141, 241, 241, 241),
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 54, 127, 156),
                                    width: 3)),
                            width: 303,
                            height: 55,
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromARGB(
                                          255, 54, 127, 156)),
                                  contentPadding: EdgeInsets.only(left: 20)),
                            )),
                      ),
                      
                      Positioned(
                        top: 280,
                        left: 93,
                        child: ElevatedButton(
                          onPressed: signIn,
                          child: Text("Login",
                              style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      const Color.fromARGB(255, 190, 228, 253),
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1)),
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(197, 0, 129, 189),
                              ),
                              padding: WidgetStateProperty.all(
                                  EdgeInsets.fromLTRB(40, 10, 40, 10)),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(28)))),
                        ),
                      ),
                    ],
                  ),
                  width: 360,
                  height: 390,
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