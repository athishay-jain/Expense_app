import 'dart:async';

import 'package:expance_app/UI/screens/HomeScreen/HomePage.dart';
import 'package:expance_app/UI/screens/onBoard/onboard_1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpashScreen extends StatefulWidget{
  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {
  @override
  void initState() {
  checklogin();
  }
  void checklogin()async{
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    int? islogin = Prefs.getInt("user") ??0;
    print("the userId after the logout : ${Prefs.getInt("user")}");
    if(islogin > 0){
      Timer(
          Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
      }
      );
    }
    else{
      Timer(
          Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnboardingScreen(),));
      }
      );
    }
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