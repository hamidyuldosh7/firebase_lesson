import 'dart:async';


import 'package:firebase_lesson/service/auth_service.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      if (AuthService.isLoggedIn()) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return HomePage();
        }));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return const LoginPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.indigo,
                  Colors.deepPurple,
                  Colors.purple,
                  Colors.purpleAccent,
                ],
                stops: [
                  0.1,
                  0.3,
                  0.6,
                  0.9
                ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                child: Image.asset("assets/instagram.png"),
              ),
              Text(
                "INSTAGRAM",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
