import 'dart:async';

import 'package:expance_app/UI/screens/onBoard/onboard_1.dart';
import 'package:flutter/material.dart';

class SpashScreen extends StatefulWidget{
  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen(),));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("Assets/Images/Ic_logo.png",scale: 3,),
      ),
    );
  }
}