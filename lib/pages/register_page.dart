// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/pages/homepage.dart';
import 'package:firebase_login/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _regEmailController = TextEditingController();
  final _regPasswordController = TextEditingController();

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.deepPurple,
            ),
          );
        });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _regEmailController.text,
        password: _regPasswordController.text,
      );
      Navigator.pop(context);

      await Future.delayed(
        const Duration(seconds: 1),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Homepage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      String message = '';
      if (e.code == 'weak-password') {
        message = 'password must be atleast 6 characters';
      } else if (e.code == 'email-already-in-use') {
        message = 'account already exist with that email';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  @override
  void dispose() {
    _regEmailController.dispose();
    _regPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple[100],
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon
                const Icon(Icons.login_outlined, size: 150),
                const SizedBox(height: 30),
                //Hello & Welcome back text
                const Text(
                  'REGISTER HERE',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Register Here to login'),
                const SizedBox(height: 30),

                //Usename Textbox
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Enter e-mail',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 5),
                  child: TextField(
                    controller: _regEmailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.deepPurple[200],
                      hintText: 'e-mail or mobile number',
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),

                //Password Textbox
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Enter Password',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 20, right: 20, top: 5),
                  child: TextField(
                    controller: _regPasswordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.deepPurple[200],
                      hintText: 'password',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                //Sign in button
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 4),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'LOG IN',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
