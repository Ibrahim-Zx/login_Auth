import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/pages/homepage.dart';
import 'package:firebase_login/pages/login_page.dart';
import 'package:flutter/material.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Homepage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
