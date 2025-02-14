import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamify_project/Abdulhadi/Screens/abdulhadi_instrctor_page.dart';

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
      home: const Taloginpage(),
    );
  }
}

class Taloginpage extends StatelessWidget {
  const Taloginpage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> ischecked = ValueNotifier(false);
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> _loginTeacher() async {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Login_inst')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => teatcher_page()),
            (Route<dynamic> route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('The account does not exist in the database'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Login error';
        if (e.code == 'user-not-found') {
          errorMessage = 'Email not registered';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'The password is incorrect';
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
            content: Text('An unexpected error occurred: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

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
              child: const Text(
                "Gamify",
                style: TextStyle(
                  fontSize: 47,
                  color: Color.fromARGB(255, 54, 127, 156),
                  fontWeight: FontWeight.w700,
                ),
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
                  width: 360,
                  height: 390,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(40),
                    ),
                    color: const Color.fromARGB(153, 231, 231, 231),
                    border: Border.all(
                      color: const Color.fromARGB(94, 161, 161, 161),
                      width: 3,
                    ),
                  ),
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 35,
                        left: 65,
                        child: Text(
                          "Login as a Teacher",
                          style: TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 54, 127, 156),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 102,
                        left: 28,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: const Color.fromARGB(141, 241, 241, 241),
                            border: Border.all(
                              color: const Color.fromARGB(255, 54, 127, 156),
                              width: 3,
                            ),
                          ),
                          width: 303,
                          height: 55,
                          child: TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "E-mail",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 54, 127, 156),
                              ),
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 179,
                        left: 28,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: const Color.fromARGB(141, 241, 241, 241),
                            border: Border.all(
                              color: const Color.fromARGB(255, 54, 127, 156),
                              width: 3,
                            ),
                          ),
                          width: 303,
                          height: 55,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 54, 127, 156),
                              ),
                              contentPadding: EdgeInsets.only(left: 20),
                            ),
                          ),
                        ),
                      ),
                      
                      Positioned(
                        top: 280,
                        left: 93,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill out all fields'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            await _loginTeacher();
                          },
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(197, 0, 129, 189),
                            ),
                            padding: WidgetStateProperty.all(
                              const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            ),
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 190, 228, 253),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
