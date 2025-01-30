import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      home: const Stloginpage(),
    );
  }
}

class Stloginpage extends StatelessWidget {
  const Stloginpage({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> ischecked = ValueNotifier(false);
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> _loginStudent() async {
      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Login_info')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => St_home_page()),
            (Route<dynamic> route) => false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('الحساب غير موجود في قاعدة البيانات'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'خطأ في تسجيل الدخول';
        if (e.code == 'user-not-found') {
          errorMessage = 'البريد الإلكتروني غير مسجل';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'كلمة المرور غير صحيحة';
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
            content: Text('حدث خطأ غير متوقع: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.settings,
              size: 35.4,
              color: Color.fromARGB(255, 54, 127, 156),
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 30,
            left: 115,
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
                  child: Stack(
                    children: [
                      const Positioned(
                        top: 25,
                        left: 34,
                        child: Text(
                          "Login as a Student",
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
                        top: 240,
                        left: 24,
                        child: Row(
                          children: [
                            ValueListenableBuilder<bool>(
                              valueListenable: ischecked,
                              builder: (context, value, child) {
                                return Checkbox(
                                  activeColor:
                                      const Color.fromARGB(255, 54, 127, 156),
                                  value: value,
                                  onChanged: (bool? newValue) {
                                    ischecked.value = newValue ?? false;
                                  },
                                  side: const BorderSide(
                                    color: Color.fromARGB(255, 0, 87, 145),
                                    width: 2,
                                  ),
                                );
                              },
                            ),
                            const Text(
                              "remember me",
                              style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 0, 54, 90),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 300,
                        left: 83,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('الرجاء ملء جميع الحقول'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            await _loginStudent();
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 190, 228, 253),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
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
                        ),
                      ),
                    ],
                  ),
                  width: 360,
                  height: 410,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class St_home_page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة الرئيسية للطالب'),
      ),
      body: const Center(
        child: Text('مرحبا بك في الصفحة الرئيسية'),
      ),
    );
  }
}
