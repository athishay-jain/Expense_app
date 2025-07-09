import 'dart:async';

import 'package:expance_app/UI/screens/HomeScreen/HomePage.dart';
import 'package:expance_app/UI/screens/onBoard/onboard_1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpashScreen extends StatefulWidget {
  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }

  bool _minimumDelayPassed = true;

  void checklogin() async {
    Timer(Duration(seconds: 2), () {
      if (mounted) {
        _minimumDelayPassed = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print("the auth id is :${FirebaseAuth.instance.currentUser?.uid}");
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (_, snapshot) {
          if (_minimumDelayPassed ||snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Image.asset(
                "Assets/Images/Ic_logo.png",
                scale: 3,
              ),
            );
          }
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return OnboardingScreen();
          }
        },
      ),
    );
  }
}
